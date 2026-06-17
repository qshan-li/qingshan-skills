# Fresh Worker Recovery

## Trigger

A fresh-context worker reports `NEEDS_CONTEXT` or `BLOCKED` during `/execute`.

## Expected route

/execute -> /plan or /investigate when recovery cannot stay inside the approved
scope

## Shortcut risk

The main session treats worker failure as inconvenience, guesses around missing
context, expands file ownership silently, or ignores blocking evidence.

## Pass condition

`/execute` handles worker statuses deterministically: in-scope `NEEDS_CONTEXT`
updates the context manifest and retries with the named artifact; scope-changing
`NEEDS_CONTEXT` returns to `/plan`; `BLOCKED` preserves evidence and routes to
`/investigate` for unexplained failure or `/plan` for boundary and sequencing
problems.

## Required signals

- [fresh-worker-recovery-needs-context-in-scope] In-scope missing context updates the context manifest before retry.
- [fresh-worker-recovery-needs-context-plan] Scope-changing missing context routes back to `/plan`.
- [fresh-worker-recovery-blocked-evidence] `BLOCKED` preserves the worker's blocking evidence.
- [fresh-worker-recovery-no-guessing] The main session does not continue locally by guessing around the worker status.
