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
skip_validation=false

fail() {
  echo "ERROR: $*" >&2
  exit 1
}

usage() {
  cat <<'USAGE'
Usage: bash scripts/sync-global-skills.sh [options]

Install this repository's root skill and workflow skills for Claude Code,
Codex, and generic agent runtimes.

Options:
  --force            Move an existing conflicting target aside before linking this repo.
  --skip-validation  Skip repository validation before installing links.
  -h, --help
            Show this help.

Environment:
  CLAUDE_SKILLS_DIR   Override Claude Code skills directory.
  CODEX_SKILLS_DIR    Override Codex skills directory.
  CODEX_HOME          Used when CODEX_SKILLS_DIR is not set.
  AGENTS_SKILLS_DIR   Override generic agent skills directory.
USAGE
}

repo_root() {
  cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P
}

next_backup_path() {
  local path="$1"
  local skills_dir
  local backup_root
  local base_name
  local timestamp
  local candidate
  local suffix=0

  skills_dir="$(dirname "$path")"
  # Keep backups outside the skills scan directory so runtimes do not load
  # old SKILL.md trees from *.backup.* siblings.
  backup_root="$(dirname "$skills_dir")/.qingshan-skills-backups"
  base_name="$(basename "$path")"
  mkdir -p "$backup_root"

  timestamp="$(date +%Y%m%d%H%M%S)"
  candidate="${backup_root}/${base_name}.backup.${timestamp}"

  while [[ -e "$candidate" || -L "$candidate" ]]; do
    suffix=$((suffix + 1))
    candidate="${backup_root}/${base_name}.backup.${timestamp}.${suffix}"
  done

  printf '%s\n' "$candidate"
}

link_state() {
  local link_path="$1"
  local source_dir="$2"
  local current_target

  if [[ -L "$link_path" ]]; then
    current_target="$(readlink -f "$link_path" 2>/dev/null || true)"

    if [[ "$current_target" == "$source_dir" ]]; then
      printf 'linked\n'
    else
      printf 'symlink-conflict\n'
    fi
    return
  fi

  if [[ -e "$link_path" ]]; then
    printf 'path-conflict\n'
    return
  fi

  printf 'missing\n'
}

preflight_link() {
  local runtime="$1"
  local skills_dir="$2"
  local link_name="$3"
  local source_dir="$4"
  local link_path="${skills_dir}/${link_name}"
  local state

  state="$(link_state "$link_path" "$source_dir")"

  case "$state" in
    linked|missing)
      return
      ;;
    symlink-conflict)
      [[ "$force" == true ]] || fail "${runtime}: ${link_path} already points elsewhere. Re-run with --force to replace it."
      ;;
    path-conflict)
      [[ "$force" == true ]] || fail "${runtime}: ${link_path} already exists. Re-run with --force to move it aside."
      ;;
  esac
}

install_link() {
  local runtime="$1"
  local skills_dir="$2"
  local link_name="$3"
  local source_dir="$4"
  local link_path="${skills_dir}/${link_name}"
  local backup_path
  local state

  mkdir -p "$skills_dir"
  state="$(link_state "$link_path" "$source_dir")"

  case "$state" in
    linked)
      echo "${runtime}: already linked at ${link_path}"
      return
      ;;
    symlink-conflict)
      [[ "$force" == true ]] || fail "${runtime}: ${link_path} changed after preflight. Re-run the installer."
      backup_path="$(next_backup_path "$link_path")"
      mv "$link_path" "$backup_path"
      ln -s "$source_dir" "$link_path"
      echo "${runtime}: replaced existing symlink and saved backup at ${backup_path}"
      ;;
    path-conflict)
      [[ "$force" == true ]] || fail "${runtime}: ${link_path} changed after preflight. Re-run the installer."
      backup_path="$(next_backup_path "$link_path")"
      mv "$link_path" "$backup_path"
      ln -s "$source_dir" "$link_path"
      echo "${runtime}: moved existing target to ${backup_path}"
      ;;
    missing)
      ln -s "$source_dir" "$link_path"
      echo "${runtime}: linked ${link_path} -> ${source_dir}"
      ;;
  esac
}

preflight_links() {
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
    preflight_link "$runtime" "$skills_dir" "$link_name" "$(cd "$source_dir" && pwd -P)"
  done
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

# Move pre-fix backups that still sit inside the skills scan directory.
migrate_legacy_skill_backups() {
  local runtime="$1"
  local skills_dir="$2"
  local backup_root
  local entry
  local dest
  local base_name

  [[ -d "$skills_dir" ]] || return 0
  backup_root="$(dirname "$skills_dir")/.qingshan-skills-backups"
  shopt -s nullglob
  for entry in "${skills_dir}"/*.backup.*; do
    [[ -e "$entry" || -L "$entry" ]] || continue
    base_name="$(basename "$entry")"
    mkdir -p "$backup_root"
    dest="${backup_root}/${base_name}"
    if [[ -e "$dest" || -L "$dest" ]]; then
      dest="${backup_root}/${base_name}.migrated.$(date +%Y%m%d%H%M%S)"
    fi
    mv "$entry" "$dest"
    echo "${runtime}: migrated legacy scan-dir backup to ${dest}"
  done
  shopt -u nullglob
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --force)
      force=true
      ;;
    --skip-validation)
      skip_validation=true
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
agents_skills_dir="${AGENTS_SKILLS_DIR:-${HOME}/.agents/skills}"

if [[ "$skip_validation" != true ]]; then
  (
    cd "$source_dir"
    bash scripts/validate-skills.sh
  )
fi

preflight_links "Claude Code" "$claude_skills_dir" "$source_dir"
preflight_links "Codex" "$codex_skills_dir" "$source_dir"
preflight_links "Generic Agent" "$agents_skills_dir" "$source_dir"

install_links "Claude Code" "$claude_skills_dir" "$source_dir"
install_links "Codex" "$codex_skills_dir" "$source_dir"
install_links "Generic Agent" "$agents_skills_dir" "$source_dir"

migrate_legacy_skill_backups "Claude Code" "$claude_skills_dir"
migrate_legacy_skill_backups "Codex" "$codex_skills_dir"
migrate_legacy_skill_backups "Generic Agent" "$agents_skills_dir"
