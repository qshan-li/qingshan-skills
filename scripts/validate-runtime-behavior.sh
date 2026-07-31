#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"

fail() {
  echo "ERROR: $*" >&2
  exit 1
}

if [[ "${QINGSHAN_RUNTIME_BEHAVIOR:-}" != "1" ]]; then
  echo "SKIP qingshan-skills runtime behavior disabled; set QINGSHAN_RUNTIME_BEHAVIOR=1 to run"
  exit 0
fi

command -v codex >/dev/null 2>&1 || fail "Codex CLI not found"

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

run_scenario() {
  local name="$1"
  local prompt="$2"
  local expected="$3"
  local output_file="${tmp_dir}/${name}.out"
  local log_file="${tmp_dir}/${name}.log"
  local non_empty_count

  if ! codex exec --sandbox read-only --ephemeral -C "$repo_root" \
    --output-last-message "$output_file" "$prompt" >"$log_file" 2>&1; then
    sed -n '1,160p' "$log_file" >&2 || true
    fail "${name}: Codex runtime behavior command failed"
  fi

  non_empty_count="$(grep -c '[^[:space:]]' "$output_file" || true)"
  [[ "$non_empty_count" -eq 1 ]] || fail "${name}: expected exactly one non-empty output line"
  grep -qxF "$expected" "$output_file" || {
    sed -n '1,40p' "$output_file" >&2 || true
    fail "${name}: expected ${expected}"
  }

  echo "OK runtime behavior scenario passed: ${name}"
}

common_instruction="Read repository root SKILL.md and ETHOS.md. Do not edit files. Answer exactly one non-empty line using the requested format."

run_scenario \
  "complete-outcome-continues" \
  "${common_instruction} The original request was to diagnose, fix, and prove a login regression. Investigation reproduced the failure through the feedback loop, established causal root-cause evidence, re-graded the fix to Low risk, named complete execution inputs (target, protected boundaries, acceptance criteria, required proof), left no Taste or User Challenge decision open, and found no rollout, rollback, or sequencing risk. Answer as RESULT: CONTINUE: /skill or RESULT: STOP." \
  "RESULT: CONTINUE: /execute"

run_scenario \
  "incomplete-fix-path-investigates" \
  "${common_instruction} The original request was to diagnose, fix, and prove a login regression. Investigation has only a confident root-cause story without causal evidence. Answer as RESULT: CONTINUE: /skill or RESULT: STOP." \
  "RESULT: CONTINUE: /investigate"

run_scenario \
  "causal-but-non-low-plans" \
  "${common_instruction} The original request was to diagnose, fix, and prove a login regression. Investigation reproduced the failure, established causal root-cause evidence, but the fix still needs multi-service sequencing and re-grades to Medium. Answer as RESULT: CONTINUE: /skill or RESULT: STOP." \
  "RESULT: CONTINUE: /plan"

run_scenario \
  "phase-only-offers-options" \
  "${common_instruction} The user explicitly invoked only /investigate and asked for the root-cause report. The report is ready, and /plan, /execute, and /investigate are valid next routes. Answer exactly RESULT: OPTIONS or RESULT: CONTINUE: /skill or RESULT: STOP." \
  "RESULT: OPTIONS"

run_scenario \
  "open-taste-stops" \
  "${common_instruction} The original request asks for the complete outcome, but /plan contains an open Taste decision with a recommendation that the user has not approved. Answer as RESULT: CONTINUE: /skill or RESULT: STOP." \
  "RESULT: STOP"

run_scenario \
  "execute-invocation-is-not-approval" \
  "${common_instruction} A prior /plan left a Taste batch open. The user's next message is only /execute and does not approve any recommendation or alternative. Answer as RESULT: CONTINUE: /skill or RESULT: STOP." \
  "RESULT: STOP"

run_scenario \
  "approved-taste-continues" \
  "${common_instruction} The original request asks for the complete outcome. The user explicitly approved every Taste recommendation in /plan, no approved decision changed, and no User Challenge remains. Answer as RESULT: CONTINUE: /skill or RESULT: STOP." \
  "RESULT: CONTINUE: /execute"

run_scenario \
  "low-mechanical-local-completion" \
  "${common_instruction} A Low-risk Mechanical README title edit is complete. Execute freshly inspected the focused diff, which directly covers the complete touched surface. No distinguishing behavior proof is missing; no temporary state, reflection candidate, review, release, residual risk, or open decision exists. Answer exactly RESULT: LOCAL_COMPLETION or RESULT: CONTINUE: /verify." \
  "RESULT: LOCAL_COMPLETION"

run_scenario \
  "low-with-temporary-state-verifies" \
  "${common_instruction} A Low-risk Mechanical edit passed its local check, but execute consumed root STATE.md for task continuity. Answer exactly RESULT: LOCAL_COMPLETION or RESULT: CONTINUE: /verify." \
  "RESULT: CONTINUE: /verify"

run_scenario \
  "finite-work-no-loop-contract" \
  "${common_instruction} A finite repository task updates a manifest, installer, tests, and docs once, with acceptance criteria and validation commands already defined. Answer exactly LOOP: REQUIRED or LOOP: NOT_REQUIRED." \
  "LOOP: NOT_REQUIRED"

run_scenario \
  "recurring-work-needs-loop-contract" \
  "${common_instruction} The user asks to check deployment health every ten minutes until success, with a maximum number of attempts. Answer exactly LOOP: REQUIRED or LOOP: NOT_REQUIRED." \
  "LOOP: REQUIRED"

run_scenario \
  "unfamiliarity-probe-not-risk-floor" \
  "${common_instruction} Also read skills/clarify/SKILL.md. A narrow, reversible documentation metadata correction matches no Medium or High risk floor, but the repository build system and its local documentation-validation convention are unfamiliar and uninspected, so that convention may change the validation path. Answer exactly RESULT: RISK=LOW; UNCERTAINTY_PASS=REQUIRED; PROBE=REQUIRED or RESULT: RISK=MEDIUM; UNCERTAINTY_PASS=REQUIRED; PROBE=REQUIRED." \
  "RESULT: RISK=LOW; UNCERTAINTY_PASS=REQUIRED; PROBE=REQUIRED"

run_scenario \
  "decision-critical-uncertainty-stops" \
  "${common_instruction} Also read skills/clarify/SKILL.md and skills/plan/SKILL.md. A reporting feature still lacks an acceptance criterion and the user-owned output behavior decision; repository evidence cannot answer either item, and no user answer exists. Answer exactly RESULT: STOP; USER_QUESTION=DECISION_INPUT or RESULT: STOP; USER_QUESTION=DISCOVERY_PROBE or RESULT: CONTINUE: /plan." \
  "RESULT: STOP; USER_QUESTION=DECISION_INPUT"

echo "OK qingshan-skills runtime behavior passed"
