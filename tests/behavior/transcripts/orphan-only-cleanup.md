# Behavior Transcript: Orphan Only Cleanup

## Scenario

orphan-only-cleanup

## Runner

manual-transcript

## Date

2026-06-16

## Transcript

```text
User: Remove the deprecated checkout flag from this one path.
Agent: During /execute, removes the flag usage and one import made unused by the
current change.
Agent: It notices older dead checkout helpers but leaves them alone because
they were pre-existing historical cleanup outside the task.
Agent: During /verify, scope drift review checks that every deletion traces to
the requested flag removal and rejects extra cleanup.
```

## Signal evidence

- [orphan-only-current-change] The transcript distinguishes cleanup caused by the current change from pre-existing dead code.
- [orphan-only-rejects-historical-cleanup] The transcript rejects historical cleanup that is not required by the task.
- [orphan-only-scope-proof] The transcript verifies extra deletions trace to the requested change.

## Forbidden evidence

- none

## Verdict

PASS
