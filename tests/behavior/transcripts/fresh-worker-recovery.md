# Behavior Transcript: Fresh Worker Recovery

## Scenario

fresh-worker-recovery

## Runner

manual-transcript

## Date

2026-06-17

## Transcript

```text
User: Execute this scoped slice with a fresh-context worker.
Agent: The worker returns NEEDS_CONTEXT because it needs src/search/schema.ts,
which is inside the approved owned surface. /execute updates the context
manifest with src/search/schema.ts as read-only reference and retries with that
named artifact.
Agent: The worker then returns NEEDS_CONTEXT for deployment config, which would
change protected boundaries and release risk. /execute stops and routes back to
/plan instead of widening scope.
Agent: In a separate run, the worker returns BLOCKED with evidence that the
verification command fails before the touched code path is reached. /execute
preserves that blocker and routes to /investigate because the failure is
unexplained.
Agent: The main session does not guess locally around either worker status.
```

## Signal evidence

- [fresh-worker-recovery-needs-context-in-scope] The transcript updates the context manifest with an in-scope artifact before retry.
- [fresh-worker-recovery-needs-context-plan] The transcript routes scope-changing missing context back to `/plan`.
- [fresh-worker-recovery-blocked-evidence] The transcript preserves the worker's blocking evidence.
- [fresh-worker-recovery-no-guessing] The transcript explicitly avoids guessing around worker statuses.

## Forbidden evidence

- none

## Verdict

PASS
