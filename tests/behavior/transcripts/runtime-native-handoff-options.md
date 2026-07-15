# Behavior Transcript: Runtime-Native Handoff Options

## Scenario

runtime-native-handoff-options

## Runner

manual-transcript

## Date

2026-07-15

## Transcript

```text
User: In Claude Code, /investigate only: explain the deployment failure.
Agent: Loads the qingshan-skills runtime adapter and calls AskUserQuestion with
one question. The options are "进入计划（推荐）", "进入执行", and "继续调查".
No prose recommendation list is emitted before the tool call.

User: In Codex, the same investigation stops with valid next routes.
Agent: Calls the native request_user_input action with the same route choices,
placing the recommended plan route first.

User: The request authorized a complete diagnose-fix-prove outcome and no stop
condition remains.
Agent: Does not call either native input tool and continues automatically.

User: The plan has an open Taste decision.
Agent: Keeps the approval gate; selecting a workflow route does not approve the
decision or enter execution.
```

## Signal evidence

- [runtime-native-handoff-claude-tool] Claude Code uses AskUserQuestion before any prose fallback.
- [runtime-native-handoff-codex-tool] Codex uses request_user_input before any prose fallback.
- [runtime-native-handoff-recommended-first] Both tool payloads put plan first as the recommendation.
- [runtime-native-handoff-boundary] Automatic continuation skips the prompt and open Taste still blocks execution.

## Forbidden evidence

- none

## Verdict

PASS
