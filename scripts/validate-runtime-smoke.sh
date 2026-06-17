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

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

print_output() {
  local name="$1"
  local output_file="$2"
  local log_file="$3"

  echo "---- ${name} final message ----" >&2
  if [[ -f "$output_file" ]]; then
    sed -n '1,160p' "$output_file" >&2 || true
  else
    echo "<missing final message file>" >&2
  fi
  echo "---- ${name} codex log ----" >&2
  if [[ -f "$log_file" ]]; then
    sed -n '1,160p' "$log_file" >&2 || true
  else
    echo "<missing codex log file>" >&2
  fi
}

require_text() {
  local name="$1"
  local route="$2"
  local log_file="$3"
  local text="$4"

  grep -qiF "$text" <<<"$route" || {
    print_output "$name" "${tmp_dir}/${name}.out" "$log_file"
    fail "${name}: output did not include required text: ${text}"
  }
}

assert_route_only() {
  local name="$1"
  local output_file="$2"
  local log_file="$3"
  local non_empty_count
  local route

  non_empty_count="$(grep -c '[^[:space:]]' "$output_file" || true)"
  if [[ "$non_empty_count" -ne 1 ]]; then
    print_output "$name" "$output_file" "$log_file"
    fail "${name}: output must contain exactly one non-empty ROUTE line"
  fi

  route="$(grep -Eim1 '^[[:space:]]*ROUTE:' "$output_file" || true)"
  [[ -n "$route" ]] || {
    print_output "$name" "$output_file" "$log_file"
    fail "${name}: output did not include a ROUTE line"
  }

  printf '%s\n' "$route"
}

run_scenario() {
  local name="$1"
  local prompt="$2"
  local output_file="${tmp_dir}/${name}.out"
  local log_file="${tmp_dir}/${name}.log"
  local route
  local text

  shift 2

  if ! codex exec --sandbox read-only --ephemeral -C "$repo_root" \
    --output-last-message "$output_file" "$prompt" >"$log_file" 2>&1; then
    print_output "$name" "$output_file" "$log_file"
    fail "${name}: Codex runtime smoke command failed"
  fi

  [[ -s "$output_file" ]] || {
    print_output "$name" "$output_file" "$log_file"
    fail "${name}: Codex runtime smoke produced no final message"
  }

  route="$(assert_route_only "$name" "$output_file" "$log_file")"

  for text in "$@"; do
    require_text "$name" "$route" "$log_file" "$text"
  done

  echo "OK runtime smoke scenario passed: ${name}"
}

common_instruction="Runtime smoke test for qingshan-skills. Do not edit files. Do not run write commands. Read repository root SKILL.md and ETHOS.md if needed. Answer exactly one non-empty line in this format: ROUTE: /skill -> /skill."

run_scenario \
  "new-feature-clarify-route" \
  "${common_instruction} Task: Add CSV export to the reporting screen. What workflow route should be used before implementation?" \
  "/clarify"

run_scenario \
  "bug-investigate-route" \
  "${common_instruction} Task: Users report that login sometimes fails after password reset. What workflow route should be used before any fix?" \
  "/investigate"

run_scenario \
  "planned-work-plan-route" \
  "${common_instruction} Task: The goal is clarified, but it needs sequencing, rollback, and validation strategy. What workflow route should be used next?" \
  "/plan"

run_scenario \
  "dependency-upgrade-plan-route" \
  "${common_instruction} Task: Upgrade the TypeScript toolchain across the repository. What workflow route should be used before implementation?" \
  "/plan"

run_scenario \
  "test-system-investigate-route" \
  "${common_instruction} Task: Improve flaky CI tests whose coverage gap and failure behavior are unclear. What workflow route should be used first?" \
  "/investigate"

run_scenario \
  "planned-docs-execute-route" \
  "${common_instruction} Task: The typo location and validation path are already known. Fix one sentence in README.md. What workflow route should be used?" \
  "/execute" \
  "/verify"

run_scenario \
  "review-verify-route" \
  "${common_instruction} Task: Review this repository diff for correctness without making implementation changes." \
  "/verify"

run_scenario \
  "completion-claim-verify-route" \
  "${common_instruction} Task: Confirm that the implemented documentation workflow is complete and ready. What workflow route should be used before claiming completion?" \
  "/verify"

run_scenario \
  "release-verify-route" \
  "${common_instruction} Task: Publish the current skill package release. What workflow route should be used before release?" \
  "/verify"

run_scenario \
  "learning-reflect-route" \
  "${common_instruction} Task: Completed work revealed a reusable verification command that should affect future tasks. What workflow route should be used?" \
  "/reflect"

echo "OK qingshan-skills runtime smoke passed"
