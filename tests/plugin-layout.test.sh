#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"

fail() {
  echo "ERROR: $*" >&2
  exit 1
}

cd "$repo_root"

jq -e '.skills == "./skills/"' .codex-plugin/plugin.json >/dev/null ||
  fail ".codex-plugin/plugin.json must expose ./skills/"

for field in displayName shortDescription longDescription developerName category; do
  jq -e --arg field "$field" '.interface[$field] | type == "string" and length > 0' .codex-plugin/plugin.json >/dev/null ||
    fail ".codex-plugin/plugin.json missing interface.${field}"
done

jq -e '.interface.defaultPrompt | type == "array" and length > 0 and length <= 3 and all(type == "string" and length > 0)' \
  .codex-plugin/plugin.json >/dev/null ||
  fail ".codex-plugin/plugin.json interface.defaultPrompt must contain one to three prompts"
jq -e '.interface.capabilities | type == "array" and all(type == "string" and length > 0)' \
  .codex-plugin/plugin.json >/dev/null ||
  fail ".codex-plugin/plugin.json interface.capabilities must be an array of strings"
jq -e '.interface.websiteURL | type == "string" and startswith("https://")' \
  .codex-plugin/plugin.json >/dev/null ||
  fail ".codex-plugin/plugin.json interface.websiteURL must be an HTTPS URL"

jq -e '.interface.defaultPrompts == null and .interface.websiteUrl == null' \
  .codex-plugin/plugin.json >/dev/null ||
  fail ".codex-plugin/plugin.json contains unsupported interface fields"

[[ -f skills/qingshan-skills/SKILL.md ]] ||
  fail "missing Codex root-router adapter: skills/qingshan-skills/SKILL.md"
grep -qF '../../SKILL.md' skills/qingshan-skills/SKILL.md ||
  fail "Codex root-router adapter must load the canonical root SKILL.md"

while IFS= read -r skill_path; do
  normalized_path="${skill_path#./}"
  [[ -f "${normalized_path}/SKILL.md" ]] ||
    fail ".claude-plugin/plugin.json references missing skill: ${skill_path}"
done < <(jq -r '.skills[]' .claude-plugin/plugin.json)

echo "OK plugin layout tests passed"
