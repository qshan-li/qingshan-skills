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
grep -q '^## Local Completion Exit$' SKILL.md ||
  fail "root SKILL.md missing Local Completion Exit"
grep -qF 'risk is Low and the decision is Mechanical' SKILL.md ||
  fail "Local Completion Exit must be limited to Low-risk Mechanical work"
grep -qF 'no temporary task state was created or consumed' SKILL.md ||
  fail "Local Completion Exit must preserve /verify cleanup ownership"
grep -qF 'File count and words such as' SKILL.md ||
  fail "Local Completion Exit must reject subjective size shortcuts"
grep -qF 'Apply root Local Completion Exit first' skills/execute/SKILL.md ||
  fail "execute must apply Local Completion Exit before /verify handoff"
grep -q '^## Workflow Handoff Selection$' SKILL.md ||
  fail "root SKILL.md missing Workflow Handoff Selection"
grep -qF 'only when `Workflow Continuation` returns control' SKILL.md ||
  fail "root SKILL.md must limit handoff options to stopping handoffs"
grep -qF 'Do not open a selection prompt when automatic continuation applies' SKILL.md ||
  fail "root SKILL.md must preserve automatic continuation without prompts"
grep -qF 'without typing a skill name' SKILL.md ||
  fail "root SKILL.md must provide a no-command handoff fallback"
grep -q '^## Runtime Handoff Interaction$' skills/qingshan-skills/SKILL.md ||
  fail "plugin adapter missing Runtime Handoff Interaction"
grep -qF 'AskUserQuestion' skills/qingshan-skills/SKILL.md ||
  fail "Claude Code adapter must name AskUserQuestion"
grep -qF 'request_user_input' skills/qingshan-skills/SKILL.md ||
  fail "Codex adapter must name request_user_input"
grep -qF 'before writing any prose' skills/qingshan-skills/SKILL.md ||
  fail "runtime adapter must prioritize native interaction before prose"
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

grep -q '^## Uncertainty Pass$' skills/clarify/SKILL.md ||
  fail "clarify must define Uncertainty Pass"
if grep -q '^## Unknowns Pass$' skills/clarify/SKILL.md; then
  fail "clarify still uses the ambiguous Unknowns Pass name"
fi
grep -qF 'Unfamiliarity triggers this pass; it does not raise task risk by itself.' skills/clarify/SKILL.md ||
  fail "clarify must separate unfamiliarity from task risk"
grep -qF 'A user question is not a discovery probe.' skills/clarify/SKILL.md ||
  fail "clarify must separate user decisions from discovery probes"
grep -qF 'Every `/clarify` discovery probe must be non-mutating.' skills/clarify/SKILL.md ||
  fail "clarify discovery probes must be non-mutating"
grep -qF 'Writable spikes and prototypes are planned execution slices' skills/clarify/SKILL.md ||
  fail "clarify must not run writable spikes as discovery probes"
grep -q '^## Implementation Constraint Probe$' skills/execute/SKILL.md ||
  fail "execute must define Implementation Constraint Probe"
if grep -q '^## Unknown-Unknowns Probe$' skills/execute/SKILL.md; then
  fail "execute still uses the ambiguous Unknown-Unknowns Probe name"
fi
grep -qF 'Reuse applicable, fresh evidence from the plan or Task Handoff.' skills/execute/SKILL.md ||
  fail "execute must reuse fresh upstream discovery evidence"
grep -q '^## Uncertainty Status (When Needed)$' docs/templates/task-handoff.md ||
  fail "Task Handoff must carry cross-stage uncertainty status"
for field in 'Item:' 'Kind:' 'Impact:' 'Next action:' 'Status:' 'Evidence:'; do
  grep -qF -- "- ${field}" docs/templates/task-handoff.md ||
    fail "Task Handoff uncertainty status missing field: ${field}"
done

for skill in clarify plan execute investigate verify reflect; do
  path="skills/${skill}/SKILL.md"
  grep -qF 'Apply root `Workflow Continuation`' "$path" ||
    fail "$path must use the root continuation contract"
  grep -qF 'Apply root `Workflow Handoff Selection` when returning control' "$path" ||
    fail "$path must use the root handoff selection contract"
  grep -qF 'Load the qingshan-skills runtime adapter' "$path" ||
    fail "$path must load the runtime handoff adapter before rendering options"
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
