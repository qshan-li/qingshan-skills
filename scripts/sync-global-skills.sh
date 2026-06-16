#!/usr/bin/env bash
set -euo pipefail

skill_links=(
  "qingshan-skills:."
  "clarify:skills/clarify"
  "plan:skills/plan"
  "execute:skills/execute"
  "investigate:skills/investigate"
  "verify:skills/verify"
  "reflect:skills/reflect"
)
force=false

fail() {
  echo "ERROR: $*" >&2
  exit 1
}

usage() {
  cat <<'USAGE'
Usage: bash scripts/sync-global-skills.sh [--force]

Install this repository's root skill and workflow skills for Claude Code and Codex.

Options:
  --force   Move an existing conflicting target aside before linking this repo.
  -h, --help
            Show this help.

Environment:
  CLAUDE_SKILLS_DIR   Override Claude Code skills directory.
  CODEX_SKILLS_DIR    Override Codex skills directory.
  CODEX_HOME          Used when CODEX_SKILLS_DIR is not set.
USAGE
}

repo_root() {
  cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P
}

next_backup_path() {
  local path="$1"
  local timestamp
  local candidate
  local suffix=0

  timestamp="$(date +%Y%m%d%H%M%S)"
  candidate="${path}.backup.${timestamp}"

  while [[ -e "$candidate" || -L "$candidate" ]]; do
    suffix=$((suffix + 1))
    candidate="${path}.backup.${timestamp}.${suffix}"
  done

  printf '%s\n' "$candidate"
}

install_link() {
  local runtime="$1"
  local skills_dir="$2"
  local link_name="$3"
  local source_dir="$4"
  local link_path="${skills_dir}/${link_name}"
  local current_target
  local backup_path

  mkdir -p "$skills_dir"

  if [[ -L "$link_path" ]]; then
    current_target="$(readlink -f "$link_path" 2>/dev/null || true)"

    if [[ "$current_target" == "$source_dir" ]]; then
      echo "${runtime}: already linked at ${link_path}"
      return
    fi

    if [[ "$force" != true ]]; then
      fail "${runtime}: ${link_path} already points elsewhere. Re-run with --force to replace it."
    fi

    backup_path="$(next_backup_path "$link_path")"
    mv "$link_path" "$backup_path"
    ln -s "$source_dir" "$link_path"
    echo "${runtime}: replaced existing symlink and saved backup at ${backup_path}"
    return
  fi

  if [[ -e "$link_path" ]]; then
    if [[ "$force" != true ]]; then
      fail "${runtime}: ${link_path} already exists. Re-run with --force to move it aside."
    fi

    backup_path="$(next_backup_path "$link_path")"
    mv "$link_path" "$backup_path"
    ln -s "$source_dir" "$link_path"
    echo "${runtime}: moved existing target to ${backup_path}"
    return
  fi

  ln -s "$source_dir" "$link_path"
  echo "${runtime}: linked ${link_path} -> ${source_dir}"
}

install_links() {
  local runtime="$1"
  local skills_dir="$2"
  local repo_dir="$3"
  local spec
  local link_name
  local relative_source
  local source_dir

  for spec in "${skill_links[@]}"; do
    link_name="${spec%%:*}"
    relative_source="${spec#*:}"
    source_dir="${repo_dir}/${relative_source}"
    install_link "$runtime" "$skills_dir" "$link_name" "$(cd "$source_dir" && pwd -P)"
  done
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --force)
      force=true
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      usage >&2
      fail "unknown argument: $1"
      ;;
  esac
  shift
done

source_dir="$(repo_root)"
codex_base="${CODEX_HOME:-${HOME}/.codex}"
claude_skills_dir="${CLAUDE_SKILLS_DIR:-${HOME}/.claude/skills}"
codex_skills_dir="${CODEX_SKILLS_DIR:-${codex_base}/skills}"

(
  cd "$source_dir"
  bash scripts/validate-skills.sh
)

install_links "Claude Code" "$claude_skills_dir" "$source_dir"
install_links "Codex" "$codex_skills_dir" "$source_dir"
