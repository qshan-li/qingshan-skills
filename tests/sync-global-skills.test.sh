#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
script_path="${repo_root}/scripts/sync-global-skills.sh"
setup_path="${repo_root}/setup"
skill_links=(
  "qingshan-skills:${repo_root}"
  "clarify:${repo_root}/skills/clarify"
  "plan:${repo_root}/skills/plan"
  "execute:${repo_root}/skills/execute"
  "investigate:${repo_root}/skills/investigate"
  "verify:${repo_root}/skills/verify"
  "reflect:${repo_root}/skills/reflect"
)

fail() {
  echo "ERROR: $*" >&2
  exit 1
}

assert_link_points_to_repo() {
  local link_path="$1"
  local expected_target="$2"

  [[ -L "$link_path" ]] || fail "expected symlink: $link_path"
  [[ "$(readlink -f "$link_path")" == "$expected_target" ]] || fail "unexpected symlink target: $link_path"
}

assert_all_links() {
  local skills_dir="$1"
  local spec
  local link_name
  local expected_target

  for spec in "${skill_links[@]}"; do
    link_name="${spec%%:*}"
    expected_target="${spec#*:}"
    assert_link_points_to_repo "${skills_dir}/${link_name}" "$expected_target"
  done
}

assert_no_links() {
  local skills_dir="$1"
  local spec
  local link_name

  for spec in "${skill_links[@]}"; do
    link_name="${spec%%:*}"
    [[ ! -L "${skills_dir}/${link_name}" ]] || fail "unexpected symlink: ${skills_dir}/${link_name}"
  done
}

run_installer() {
  local entrypoint="$1"
  local claude_dir="$2"
  local codex_dir="$3"
  local agents_dir="$4"
  shift 4

  CLAUDE_SKILLS_DIR="$claude_dir" \
    CODEX_SKILLS_DIR="$codex_dir" \
    AGENTS_SKILLS_DIR="$agents_dir" \
    bash "$entrypoint" "$@"
}

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

claude_dir="${tmp_dir}/claude-skills"
codex_dir="${tmp_dir}/codex-skills"
agents_dir="${tmp_dir}/agents-skills"

run_installer "$script_path" "$claude_dir" "$codex_dir" "$agents_dir" >/dev/null
assert_all_links "$claude_dir"
assert_all_links "$codex_dir"
assert_all_links "$agents_dir"

run_installer "$script_path" "$claude_dir" "$codex_dir" "$agents_dir" >/dev/null
assert_all_links "$claude_dir"
assert_all_links "$codex_dir"
assert_all_links "$agents_dir"

conflict_claude_dir="${tmp_dir}/conflict-claude-skills"
conflict_codex_dir="${tmp_dir}/conflict-codex-skills"
conflict_agents_dir="${tmp_dir}/conflict-agents-skills"
mkdir -p "${conflict_claude_dir}/qingshan-skills" "$conflict_codex_dir"

if run_installer "$script_path" "$conflict_claude_dir" "$conflict_codex_dir" "$conflict_agents_dir" >"${tmp_dir}/conflict.out" 2>"${tmp_dir}/conflict.err"; then
  fail "expected conflict to fail without --force"
fi

grep -q -- "--force" "${tmp_dir}/conflict.err" || fail "conflict error should mention --force"

codex_conflict_claude_dir="${tmp_dir}/codex-conflict-claude-skills"
codex_conflict_codex_dir="${tmp_dir}/codex-conflict-codex-skills"
codex_conflict_agents_dir="${tmp_dir}/codex-conflict-agents-skills"
mkdir -p "${codex_conflict_codex_dir}/qingshan-skills"

if run_installer "$script_path" \
  "$codex_conflict_claude_dir" \
  "$codex_conflict_codex_dir" \
  "$codex_conflict_agents_dir" \
  --skip-validation >"${tmp_dir}/codex-conflict.out" 2>"${tmp_dir}/codex-conflict.err"; then
  fail "expected Codex conflict to fail without --force"
fi

grep -q -- "--force" "${tmp_dir}/codex-conflict.err" || fail "Codex conflict error should mention --force"
assert_no_links "$codex_conflict_claude_dir"
assert_no_links "$codex_conflict_codex_dir"
assert_no_links "$codex_conflict_agents_dir"

agents_conflict_claude_dir="${tmp_dir}/agents-conflict-claude-skills"
agents_conflict_codex_dir="${tmp_dir}/agents-conflict-codex-skills"
agents_conflict_agents_dir="${tmp_dir}/agents-conflict-agents-skills"
mkdir -p "${agents_conflict_agents_dir}/qingshan-skills"

if run_installer "$script_path" \
  "$agents_conflict_claude_dir" \
  "$agents_conflict_codex_dir" \
  "$agents_conflict_agents_dir" \
  --skip-validation >"${tmp_dir}/agents-conflict.out" 2>"${tmp_dir}/agents-conflict.err"; then
  fail "expected Generic Agent conflict to fail without --force"
fi

grep -q -- "--force" "${tmp_dir}/agents-conflict.err" || fail "Generic Agent conflict error should mention --force"
assert_no_links "$agents_conflict_claude_dir"
assert_no_links "$agents_conflict_codex_dir"
assert_no_links "$agents_conflict_agents_dir"

force_claude_dir="${tmp_dir}/force-claude-skills"
force_codex_dir="${tmp_dir}/force-codex-skills"
force_agents_dir="${tmp_dir}/force-agents-skills"
mkdir -p "${force_claude_dir}/qingshan-skills" "$force_codex_dir"
printf 'keep me\n' >"${force_claude_dir}/qingshan-skills/marker.txt"

run_installer "$script_path" "$force_claude_dir" "$force_codex_dir" "$force_agents_dir" --force >/dev/null
assert_all_links "$force_claude_dir"
assert_all_links "$force_codex_dir"
assert_all_links "$force_agents_dir"

backup_dir="$(find "$(dirname "$force_claude_dir")/.qingshan-skills-backups" -maxdepth 1 -type d -name "qingshan-skills.backup.*" -print -quit)"
[[ -n "$backup_dir" ]] || fail "expected forced replacement backup outside skills scan dir"
[[ -f "${backup_dir}/marker.txt" ]] || fail "backup should preserve existing content"
shopt -s nullglob
scan_backups=("${force_claude_dir}"/qingshan-skills.backup.*)
shopt -u nullglob
((${#scan_backups[@]} == 0)) || fail "backup must not remain inside skills scan dir"

legacy_claude_dir="${tmp_dir}/legacy-claude-skills"
legacy_codex_dir="${tmp_dir}/legacy-codex-skills"
legacy_agents_dir="${tmp_dir}/legacy-agents-skills"
mkdir -p "${legacy_claude_dir}/qingshan-skills.backup.old/skills"
printf '# stale\n' >"${legacy_claude_dir}/qingshan-skills.backup.old/SKILL.md"
run_installer "$script_path" "$legacy_claude_dir" "$legacy_codex_dir" "$legacy_agents_dir" --skip-validation >/dev/null
assert_all_links "$legacy_claude_dir"
[[ ! -e "${legacy_claude_dir}/qingshan-skills.backup.old" ]] ||
  fail "legacy scan-dir backup should be migrated out"
[[ -f "$(dirname "$legacy_claude_dir")/.qingshan-skills-backups/qingshan-skills.backup.old/SKILL.md" ]] ||
  fail "legacy backup should land outside the skills scan dir"

setup_claude_dir="${tmp_dir}/setup-claude-skills"
setup_codex_dir="${tmp_dir}/setup-codex-skills"
setup_agents_dir="${tmp_dir}/setup-agents-skills"
run_installer "$setup_path" "$setup_claude_dir" "$setup_codex_dir" "$setup_agents_dir" --skip-validation >/dev/null
assert_all_links "$setup_claude_dir"
assert_all_links "$setup_codex_dir"
assert_all_links "$setup_agents_dir"

mkdir -p "${tmp_dir}/setup-conflict-claude/qingshan-skills"
if run_installer "$setup_path" \
  "${tmp_dir}/setup-conflict-claude" \
  "${tmp_dir}/setup-conflict-codex" \
  "${tmp_dir}/setup-conflict-agents" \
  --skip-validation >"${tmp_dir}/setup-conflict.out" 2>"${tmp_dir}/setup-conflict.err"; then
  fail "expected setup conflict to fail without --force"
fi

echo "OK sync-global-skills tests passed"
