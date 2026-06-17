#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

fail() {
  echo "ERROR: $*" >&2
  exit 1
}

if [[ "${QINGSHAN_RUNTIME_SMOKE:-}" != "1" ]]; then
  echo "SKIP qingshan-skills runtime smoke disabled; set QINGSHAN_RUNTIME_SMOKE=1 to run"
  exit 0
fi

command -v codex >/dev/null 2>&1 || fail "Codex CLI not found; runtime smoke currently supports Codex CLI"

output_file="$(mktemp)"
trap 'rm -f "$output_file"' EXIT

prompt="Runtime smoke test for qingshan-skills. Do not edit files. Do not run write commands. Read the repository root SKILL.md and ETHOS.md if needed, then answer only with the workflow route for this task: Fix a typo in one sentence of README.md. The answer must include ROUTE: followed by the route."

if ! codex exec --sandbox read-only --ask-for-approval never -C "$repo_root" "$prompt" >"$output_file" 2>&1; then
  cat "$output_file" >&2
  fail "Codex runtime smoke command failed"
fi

grep -q "/clarify" "$output_file" || {
  cat "$output_file" >&2
  fail "runtime smoke output did not include /clarify"
}

grep -q "/execute" "$output_file" || {
  cat "$output_file" >&2
  fail "runtime smoke output did not include /execute"
}

grep -q "/verify" "$output_file" || {
  cat "$output_file" >&2
  fail "runtime smoke output did not include /verify"
}

echo "OK qingshan-skills runtime smoke passed"
