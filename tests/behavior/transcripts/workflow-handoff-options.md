# Behavior Transcript: Workflow Handoff Options

## Scenario

workflow-handoff-options

## Runner

manual-transcript

## Date

2026-07-15

## Transcript

```text
User: /investigate only: explain the deployment failure.
Agent: Completes the investigation report. Because this is a stopping handoff
and the runtime supports native input, it presents valid next-workflow options
with "进入计划" first as the recommendation, followed by "进入执行" and
"继续调查". The user can select an option without typing `/plan`, `/execute`,
or `/investigate`.

User: The same stopping handoff runs in a host without native option controls.
Agent: Shows a compact fallback such as "1. 进入计划（推荐）; 2. 进入执行;
3. 继续调查" and accepts `1` or the label. It does not require a skill command.

User: Diagnose, fix, and prove the login regression. Investigation established
causal evidence, re-graded the fix to Low, and left no stop condition open.
Agent: Continues directly to `/execute` without opening a handoff selection,
because root Workflow Continuation authorizes the complete outcome.

User: The plan still has an open Taste decision. Choose `/execute` next.
Agent: Does not offer or enter `/execute`. A route choice is navigation, not
Taste approval, so it presents the Decision Brief approval options first.
```

## Signal evidence

- [workflow-handoff-options-native-channel] The first handoff uses native input instead of bare command text.
- [workflow-handoff-options-recommended-first] The first handoff recommends plan first and offers only valid routes for that scenario.
- [workflow-handoff-options-no-manual-command] The fallback accepts `1` or a label without `/skill` syntax.
- [workflow-handoff-options-continuation-boundary] The complete-outcome request continues to execution without a prompt.
- [workflow-handoff-options-approval-boundary] The open Taste decision blocks execution even when the user chooses that route.

## Forbidden evidence

- none

## Verdict

PASS
