#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"

fail() {
  echo "ERROR: $*" >&2
  exit 1
}

cd "$repo_root"

grep -q '^## Workflow Continuation$' SKILL.md ||
  fail "root SKILL.md missing Workflow Continuation"
grep -qF 'the original request asks for the complete outcome' SKILL.md ||
  fail "root SKILL.md must allow bounded automatic continuation"
grep -qF 'the user invoked only the current workflow stage' SKILL.md ||
  fail "root SKILL.md must stop after phase-only invocation"
grep -q '^## Workflow Handoff Selection$' SKILL.md ||
  fail "root SKILL.md missing Workflow Handoff Selection"
grep -qF 'only when `Workflow Continuation` returns control' SKILL.md ||
  fail "root SKILL.md must limit handoff options to stopping handoffs"
grep -qF 'Do not open a selection prompt when automatic continuation applies' SKILL.md ||
  fail "root SKILL.md must preserve automatic continuation without prompts"
grep -qF 'without typing a skill name' SKILL.md ||
  fail "root SKILL.md must provide a no-command handoff fallback"
grep -q '^## Decision Approval Gate$' SKILL.md ||
  fail "root SKILL.md missing Decision Approval Gate"
grep -qF 'A direct `/execute` invocation does not approve open Taste decisions' SKILL.md ||
  fail "root SKILL.md must reject implicit Taste approval from /execute"
grep -qF 'open Taste or User Challenge decision' SKILL.md ||
  fail "root SKILL.md must block continuation on unresolved user-owned decisions"
if grep -qF 'Taste and Mechanical decisions do not require a handoff stop' SKILL.md; then
  fail "root SKILL.md still allows unapproved Taste decisions to continue"
fi

grep -q '^## Taste Approval Gate$' skills/plan/SKILL.md ||
  fail "plan must define the Taste Approval Gate"
grep -qF 'A direct `/execute` invocation is not approval' skills/execute/SKILL.md ||
  fail "execute must not infer Taste approval from direct invocation"
grep -qF 'Status: open | approved | changed' docs/templates/decision-brief.md ||
  fail "Decision Brief must preserve approval status"
grep -qF 'Approval evidence:' docs/templates/decision-brief.md ||
  fail "Decision Brief must preserve approval evidence"

for skill in clarify plan execute investigate verify reflect; do
  path="skills/${skill}/SKILL.md"
  grep -qF 'Apply root `Workflow Continuation`' "$path" ||
    fail "$path must use the root continuation contract"
  grep -qF 'Apply root `Workflow Handoff Selection` when returning control' "$path" ||
    fail "$path must use the root handoff selection contract"
  if grep -qF 'stop and wait for the user to decide the next step' "$path"; then
    fail "$path still contains an unconditional handoff stop"
  fi
done

grep -qF 'Ordinary finite engineering work does not need a separate Loop Contract' SKILL.md ||
  fail "root SKILL.md must exempt ordinary finite work from Loop Contract"

grep -qF '`/verify` is the only workflow that deletes or trims temporary task state' SKILL.md ||
  fail "root SKILL.md must assign cleanup ownership to /verify"
if grep -qF '/execute` may dispose' SKILL.md; then
  fail "root SKILL.md still allows /execute cleanup"
fi
if grep -qF 'delete root `STATE.md`' skills/execute/SKILL.md; then
  fail "execute must not delete STATE.md"
fi
if grep -qF 'delete root `STATE.md`' skills/reflect/SKILL.md; then
  fail "reflect must not delete STATE.md"
fi
grep -qF 'sole cleanup owner' skills/verify/SKILL.md ||
  fail "verify must declare sole cleanup ownership"

echo "OK workflow contract tests passed"
