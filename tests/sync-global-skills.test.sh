#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
script_path="${repo_root}/scripts/sync-global-skills.sh"
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

run_sync() {
  local claude_dir="$1"
  local codex_dir="$2"
  shift 2

  CLAUDE_SKILLS_DIR="$claude_dir" \
    CODEX_SKILLS_DIR="$codex_dir" \
    bash "$script_path" "$@"
}

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

claude_dir="${tmp_dir}/claude-skills"
codex_dir="${tmp_dir}/codex-skills"

run_sync "$claude_dir" "$codex_dir" >/dev/null
assert_all_links "$claude_dir"
assert_all_links "$codex_dir"

run_sync "$claude_dir" "$codex_dir" >/dev/null
assert_all_links "$claude_dir"
assert_all_links "$codex_dir"

conflict_claude_dir="${tmp_dir}/conflict-claude-skills"
conflict_codex_dir="${tmp_dir}/conflict-codex-skills"
mkdir -p "${conflict_claude_dir}/qingshan-skills" "$conflict_codex_dir"

if run_sync "$conflict_claude_dir" "$conflict_codex_dir" >"${tmp_dir}/conflict.out" 2>"${tmp_dir}/conflict.err"; then
  fail "expected conflict to fail without --force"
fi

grep -q -- "--force" "${tmp_dir}/conflict.err" || fail "conflict error should mention --force"

force_claude_dir="${tmp_dir}/force-claude-skills"
force_codex_dir="${tmp_dir}/force-codex-skills"
mkdir -p "${force_claude_dir}/qingshan-skills" "$force_codex_dir"
printf 'keep me\n' >"${force_claude_dir}/qingshan-skills/marker.txt"

run_sync "$force_claude_dir" "$force_codex_dir" --force >/dev/null
assert_all_links "$force_claude_dir"
assert_all_links "$force_codex_dir"

backup_dir="$(find "$force_claude_dir" -maxdepth 1 -type d -name "qingshan-skills.backup.*" -print -quit)"
[[ -n "$backup_dir" ]] || fail "expected forced replacement backup"
[[ -f "${backup_dir}/marker.txt" ]] || fail "backup should preserve existing content"

echo "OK sync-global-skills tests passed"
