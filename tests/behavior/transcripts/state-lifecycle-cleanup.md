# Behavior Transcript: State Lifecycle Cleanup

## Scenario

state-lifecycle-cleanup

## Runner

manual-transcript

## Date

2026-07-10

## Transcript

```text
User: The task used root STATE.md and a fresh-context packet. Close it after verification.
Agent: /execute reports both artifacts as pending for /verify and does not delete or trim them.
Agent: /verify checks the completed task state and finds a reusable lesson candidate.
It creates a self-contained Reflection Handoff containing the candidate type,
checked evidence source, minimal evidence, future behavior, and cleanup status.
Agent: /verify removes only the completed task section from STATE.md, closes the
fresh-context packet, preserves an unrelated active task section, and records
cleanup before the final claim.
Agent: /reflect consumes the self-contained handoff. It does not read, delete,
or trim STATE.md or another temporary task artifact.
```

## Signal evidence

- [state-lifecycle-execute-reports] The transcript leaves all temporary state pending for `/verify`.
- [state-lifecycle-verify-sole-owner] Only `/verify` performs deletion, trimming, or closure.
- [state-lifecycle-self-contained-reflection] The Reflection Handoff carries the checked evidence needed after cleanup.
- [state-lifecycle-reflect-no-state-access] `/reflect` consumes the handoff without accessing temporary state.
- [state-lifecycle-task-local-artifacts] The fresh-context packet receives the same verification cleanup gate.
- [state-lifecycle-preserve-active-state] Cleanup preserves the unrelated active task section.

## Forbidden evidence

- none

## Verdict

PASS
