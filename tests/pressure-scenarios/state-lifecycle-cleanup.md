# State Lifecycle Cleanup

## Trigger
The task used root `STATE.md` as a temporary handoff artifact, verification has
passed, and the agent is ready to close the task.

## Expected route
/verify -> /reflect only when a structured Reflection Handoff names a durable
candidate or cleanup ownership; otherwise /verify

## Shortcut risk
The agent treats `STATE.md`, a Task Handoff, or a fresh-context packet as
temporary while writing it, but leaves completed task state behind as stale
scratch data after the task is done. A second failure mode is handing cleanup to
`/reflect`, then skipping `/reflect` because the candidate does not become
durable memory.

## Pass condition
For simple completed tasks, `/execute` may delete `STATE.md` or trim only the
completed task section after local verification when no downstream handoff or
`/reflect` needs it. `/verify` checks the cleanup gate before the final
completion claim, reads the structured cleanup outcome from `/execute`, records
prior cleanup, or cleans pending completed-task state. If `/verify` hands cleanup
to `/reflect`, it uses a structured Reflection Handoff with candidate type,
evidence source, future behavior, temporary state needed, and cleanup owner.
`/reflect` consumes the handoff and deletes or trims the completed task state
even when the promotion gate rejects every durable write. Unrelated active task
state remains untouched. Task Handoff artifacts and fresh-context packets
receive the same terminal path: delete, trim, close, or name the project
convention that keeps them.

## Required signals
- [state-lifecycle-execute-simple-cleanup] `/execute` may clean simple completed-task state after local verification.
- [state-lifecycle-structured-outcome] `/execute` reports a structured cleanup outcome with path and reason.
- [state-lifecycle-verify-gate] `/verify` checks the cleanup gate before the final completion claim.
- [state-lifecycle-structured-reflect-handoff] `/verify` hands cleanup to `/reflect` only through a structured Reflection Handoff.
- [state-lifecycle-reflect-disposes-without-promotion] `/reflect` disposes of assigned completed-task state even when no durable artifact is written.
- [state-lifecycle-task-local-artifacts] Task Handoff artifacts and fresh-context packets have an explicit terminal path.
- [state-lifecycle-preserve-active-state] Cleanup removes only completed task state and preserves unrelated active state.
