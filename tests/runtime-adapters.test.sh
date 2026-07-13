#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
cursor_rule="${repo_root}/.cursor/rules/qingshan-skills.mdc"
install_script="${repo_root}/scripts/install-cursor-project-rule.sh"

fail() {
  echo "ERROR: $*" >&2
  exit 1
}

grep -qF 'QINGSHAN_SKILLS_ROOT' "$cursor_rule" ||
  fail "Cursor adapter must resolve QINGSHAN_SKILLS_ROOT"
grep -qF 'SKILL.md' "$cursor_rule" ||
  fail "Cursor adapter must load the canonical root router"
grep -qF 'ETHOS.md' "$cursor_rule" ||
  fail "Cursor adapter must load the canonical ethos"
grep -qF 'skills/<name>/SKILL.md' "$cursor_rule" ||
  fail "Cursor adapter must load the selected canonical workflow skill"
grep -qF 'Never assume the current workspace root is the qingshan-skills repository' "$cursor_rule" ||
  fail "Cursor adapter must not treat consumer project root as skills root"
grep -qF 'skills/{clarify,plan,execute,investigate,verify,reflect}/SKILL.md' "$cursor_rule" ||
  fail "Cursor adapter must require a complete skills root"

if grep -q '^## `/\(clarify\|plan\|execute\|investigate\|verify\|reflect\)`' "$cursor_rule"; then
  fail "Cursor adapter must not duplicate workflow summaries"
fi

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

# source == target template: no-op, no truncation
bash "$install_script" "$repo_root" >/dev/null
[[ -s "$cursor_rule" ]] || fail "install into skills repo must not empty the template"
grep -qF 'QINGSHAN_SKILLS_ROOT_BAKED=' "$cursor_rule" ||
  fail "template bake line must remain after self-install no-op"

consumer="${tmp_dir}/consumer"
mkdir -p "$consumer"
bash "$install_script" "$consumer" >/dev/null
installed="${consumer}/.cursor/rules/qingshan-skills.mdc"
[[ -f "$installed" ]] || fail "install-cursor-project-rule.sh did not create the project rule"
grep -qF "QINGSHAN_SKILLS_ROOT_BAKED=${repo_root}" "$installed" ||
  fail "installed Cursor rule must bake absolute skills root"

# identical reinstall is no-op success
bash "$install_script" "$consumer" >/dev/null

# existing different rule fails without --force
printf 'custom rule\n' >"$installed"
if bash "$install_script" "$consumer" >/dev/null 2>"${tmp_dir}/conflict.err"; then
  fail "expected conflict without --force"
fi
grep -q -- "--force" "${tmp_dir}/conflict.err" || fail "conflict error should mention --force"

# --force backs up and replaces
bash "$install_script" --force "$consumer" >/dev/null
grep -qF "QINGSHAN_SKILLS_ROOT_BAKED=${repo_root}" "$installed" ||
  fail "force install must replace with baked rule"
backup="$(find "${consumer}/.qingshan-skills-backups" -type f -name 'qingshan-skills.mdc.backup.*' -print -quit)"
[[ -n "$backup" ]] || fail "force install must create a backup"
grep -qxF 'custom rule' "$backup" || fail "backup should preserve prior rule content"

# symlink conflict also requires --force
rm -f "$installed"
ln -s /tmp/qingshan-cursor-rule-placeholder "$installed"
if bash "$install_script" "$consumer" >/dev/null 2>"${tmp_dir}/symlink.err"; then
  fail "expected symlink conflict without --force"
fi
bash "$install_script" --force "$consumer" >/dev/null
[[ -f "$installed" && ! -L "$installed" ]] || fail "force install should replace symlink with a file"

# paths with spaces, &, and | in the baked root via a temporary skills clone layout
# are covered by awk injection: install against a workspace whose absolute path
# contains those characters when the OS allows it.
space_root="${tmp_dir}/skills root with spaces"
mkdir -p "${space_root}/scripts" "${space_root}/.cursor/rules" "${space_root}/skills"
# Minimal complete skills root markers for the completeness check.
for name in clarify plan execute investigate verify reflect; do
  mkdir -p "${space_root}/skills/${name}"
  printf '# %s\n' "$name" >"${space_root}/skills/${name}/SKILL.md"
done
printf '# root\n' >"${space_root}/SKILL.md"
printf '# ethos\n' >"${space_root}/ETHOS.md"
cp "$cursor_rule" "${space_root}/.cursor/rules/qingshan-skills.mdc"
cp "$install_script" "${space_root}/scripts/install-cursor-project-rule.sh"
chmod +x "${space_root}/scripts/install-cursor-project-rule.sh"
consumer_space="${tmp_dir}/consumer-space"
mkdir -p "$consumer_space"
bash "${space_root}/scripts/install-cursor-project-rule.sh" "$consumer_space" >/dev/null
grep -qF "QINGSHAN_SKILLS_ROOT_BAKED=${space_root}" \
  "${consumer_space}/.cursor/rules/qingshan-skills.mdc" ||
  fail "baked path must preserve spaces"

amp_root="${tmp_dir}/skills&pipe|root"
mkdir -p "${amp_root}/scripts" "${amp_root}/.cursor/rules" "${amp_root}/skills"
for name in clarify plan execute investigate verify reflect; do
  mkdir -p "${amp_root}/skills/${name}"
  printf '# %s\n' "$name" >"${amp_root}/skills/${name}/SKILL.md"
done
printf '# root\n' >"${amp_root}/SKILL.md"
printf '# ethos\n' >"${amp_root}/ETHOS.md"
cp "$cursor_rule" "${amp_root}/.cursor/rules/qingshan-skills.mdc"
cp "$install_script" "${amp_root}/scripts/install-cursor-project-rule.sh"
chmod +x "${amp_root}/scripts/install-cursor-project-rule.sh"
consumer_amp="${tmp_dir}/consumer-amp"
mkdir -p "$consumer_amp"
bash "${amp_root}/scripts/install-cursor-project-rule.sh" "$consumer_amp" >/dev/null
grep -qF "QINGSHAN_SKILLS_ROOT_BAKED=${amp_root}" \
  "${consumer_amp}/.cursor/rules/qingshan-skills.mdc" ||
  fail "baked path must preserve & and |"

echo "OK runtime adapter tests passed"
