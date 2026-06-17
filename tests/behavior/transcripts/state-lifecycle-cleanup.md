# Behavior Transcript: State Lifecycle Cleanup

## Scenario

state-lifecycle-cleanup

## Runner

manual-transcript

## Date

2026-06-17

## Transcript

```text
User: The task used root STATE.md for a handoff. Verification passed; close it.
Agent: For a simple completed task with no handoff or reflection dependency,
/execute may remove the completed task section after local verification and
report that cleanup status to /verify.
Agent: /verify checks the cleanup gate before the final completion claim and
records whether /execute already cleaned it or cleanup remains pending.
Agent: In a different case, STATE.md contains a possible reusable lesson
candidate and an unrelated active task section. /verify routes /verify ->
/reflect only by writing a structured Reflection Handoff: candidate type,
evidence source, future behavior, temporary state needed, and cleanup owner.
Agent: /reflect consumes the handoff, rejects the candidate because no future
reader and trigger survive the Memory Promotion Gate, writes no durable
artifact, then removes the completed task section from STATE.md and preserves
the unrelated active task section.
Agent: Task Handoff artifacts and fresh-context packets get the same terminal
path: delete, trim, close, or name the project convention that keeps them after
the task closes.
Agent: Final status reports verification evidence and the temporary state
cleanup result.
```

## Signal evidence

- [state-lifecycle-execute-simple-cleanup] The transcript allows `/execute` to remove simple completed-task state after local verification.
- [state-lifecycle-verify-gate] The transcript includes cleanup gate checking before the final completion claim.
- [state-lifecycle-structured-reflect-handoff] The transcript routes cleanup to `/reflect` only after `/verify` writes a structured Reflection Handoff.
- [state-lifecycle-reflect-disposes-without-promotion] The transcript rejects durable promotion but still removes the completed task section from `STATE.md`.
- [state-lifecycle-task-local-artifacts] The transcript gives Task Handoff artifacts and fresh-context packets the same terminal path.
- [state-lifecycle-preserve-active-state] The transcript preserves the unrelated active task section while removing completed task state.

## Forbidden evidence

- none

## Verdict

PASS
