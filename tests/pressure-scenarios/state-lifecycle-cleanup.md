# State Lifecycle Cleanup

## Trigger
The task used root `STATE.md` or another temporary handoff artifact and is
approaching final verification or reflection.

## Expected route
/execute reports state -> /verify creates any self-contained Reflection Handoff,
cleans completed temporary state, and then may route to /reflect

## Shortcut risk
Multiple workflows compete to delete task state, reflection depends on stale
scratch files, or completed state survives after the final claim.

## Pass condition
`/execute` reports temporary state without deleting it. `/verify` is the sole
cleanup owner, preserves unrelated active state, creates a self-contained
Reflection Handoff when needed, and cleans completed temporary state before the
final claim. `/reflect` consumes only the handoff and never reads or edits task
state.

## Required signals
- [state-lifecycle-execute-reports] `/execute` reports temporary state and leaves cleanup pending for `/verify`.
- [state-lifecycle-verify-sole-owner] `/verify` is the only workflow that deletes or trims temporary task state.
- [state-lifecycle-self-contained-reflection] Reflection evidence is copied into a self-contained Reflection Handoff before cleanup.
- [state-lifecycle-reflect-no-state-access] `/reflect` does not read, delete, or trim temporary task state.
- [state-lifecycle-task-local-artifacts] Task Handoff artifacts and fresh-context packets receive the same terminal cleanup gate.
- [state-lifecycle-preserve-active-state] Cleanup removes only completed task state and preserves unrelated active state.
