#!/usr/bin/env bash
set -euo pipefail

force=false

fail() {
  echo "ERROR: $*" >&2
  exit 1
}

usage() {
  cat <<'USAGE'
Usage: bash scripts/install-cursor-project-rule.sh [options] <consumer-project-root>

Install a Cursor project rule into the consumer project's .cursor/rules that
points at this qingshan-skills repository via an absolute baked path.

Options:
  --force   Replace an existing different rule after moving it to a backup.
  -h, --help

Also recommended:
  export QINGSHAN_SKILLS_ROOT=/absolute/path/to/qingshan-skills

This does not copy the full methodology into the consumer project.
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --force)
      force=true
      shift
      ;;
    -h | --help)
      usage
      exit 0
      ;;
    --)
      shift
      break
      ;;
    -*)
      fail "unknown option: $1"
      ;;
    *)
      break
      ;;
  esac
done

[[ $# -eq 1 ]] || {
  usage
  fail "consumer project root is required"
}

consumer_root="$(cd "$1" && pwd -P)"
skills_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"

is_full_skills_root() {
  local root="$1"
  [[ -f "${root}/SKILL.md" &&
    -f "${root}/ETHOS.md" &&
    -f "${root}/skills/clarify/SKILL.md" &&
    -f "${root}/skills/plan/SKILL.md" &&
    -f "${root}/skills/execute/SKILL.md" &&
    -f "${root}/skills/investigate/SKILL.md" &&
    -f "${root}/skills/verify/SKILL.md" &&
    -f "${root}/skills/reflect/SKILL.md" ]]
}

is_full_skills_root "$skills_root" || fail "skills root incomplete: ${skills_root}"

template="${skills_root}/.cursor/rules/qingshan-skills.mdc"
[[ -f "$template" ]] || fail "missing template rule: ${template}"

rules_dir="${consumer_root}/.cursor/rules"
target="${rules_dir}/qingshan-skills.mdc"

# Avoid in-place truncation when installing into this repository itself.
if [[ "$(readlink -f "$template" 2>/dev/null || printf '%s\n' "$template")" == \
  "$(readlink -f "$target" 2>/dev/null || printf '%s\n' "$target")" ]]; then
  echo "Cursor: target is the template inside the skills repo; no-op"
  exit 0
fi

render_rule() {
  local out_path="$1"
  # awk -v safely injects paths containing &, |, spaces, and other sed metacharacters.
  awk -v root="$skills_root" '
    /^QINGSHAN_SKILLS_ROOT_BAKED=/ {
      print "QINGSHAN_SKILLS_ROOT_BAKED=" root
      next
    }
    { print }
  ' "$template" >"$out_path"
  [[ -s "$out_path" ]] || fail "rendered Cursor rule is empty"
  grep -qF "QINGSHAN_SKILLS_ROOT_BAKED=${skills_root}" "$out_path" ||
    fail "failed to bake skills root into Cursor rule"
}

tmp_file="$(mktemp)"
trap 'rm -f "$tmp_file"' EXIT
render_rule "$tmp_file"

if [[ -e "$target" || -L "$target" ]]; then
  if cmp -s "$tmp_file" "$target"; then
    echo "Cursor: already installed at ${target}"
    exit 0
  fi

  if [[ "$force" != true ]]; then
    fail "Cursor: ${target} already exists and differs. Re-run with --force to back it up and replace."
  fi

  backup_root="${consumer_root}/.qingshan-skills-backups"
  mkdir -p "$backup_root"
  timestamp="$(date +%Y%m%d%H%M%S)"
  backup_path="${backup_root}/qingshan-skills.mdc.backup.${timestamp}"
  suffix=0
  while [[ -e "$backup_path" || -L "$backup_path" ]]; do
    suffix=$((suffix + 1))
    backup_path="${backup_root}/qingshan-skills.mdc.backup.${timestamp}.${suffix}"
  done
  mv "$target" "$backup_path"
  echo "Cursor: moved existing rule to ${backup_path}"
fi

mkdir -p "$rules_dir"
# Atomic replace into the final path.
mv "$tmp_file" "$target"
trap - EXIT

echo "Cursor: installed ${target}"
echo "Cursor: skills root baked as ${skills_root}"
echo "Optional: export QINGSHAN_SKILLS_ROOT=${skills_root}"
