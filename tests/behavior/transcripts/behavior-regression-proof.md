# Behavior Transcript: Behavior Regression Proof

## Scenario

behavior-regression-proof

## Runner

manual-transcript

## Date

2026-07-13

## Transcript

```text
User: Review this PR that changes the status line so offline mode shows OFFLINE
instead of silently omitting the mode chip. Do not implement anything.
Agent: Routes to /verify for pure review. Does not edit the repository.
Agent: Existing suite stays green but does not cover the offline status chip
path. Behavior Regression Proof status is Missing.
Agent: Reports Not Ready / Missing. Does not add a test, does not create a
Reflection Handoff file, and does not delete or trim STATE.md.
Agent: Recommends /execute only if the user authorizes implementation.
User: Implement the missing proof for the pure helper seam and also cover the
private-only chip path that has no unit seam.
Agent: In /execute, adds tests/status-label.test.ts for the public helper seam
distinguishing omitted vs OFFLINE.
Agent: For the private-only chip path with no reasonable unit seam, adds
fixtures/offline-status-chip.smoke.md and a scripted dry-run that renders the
chip, records residual risk that the dry-run is slower than unit tests, and
does not claim a unit seam exists.
Agent: Re-enters /verify. Behavior Regression Proof is Present for both the
unit test and the smoke dry-run. No pure-review write side effects occur.
```

## Signal evidence

- [behavior-regression-distinguishing-proof] After authorized /execute, verification records Present proof from tests/status-label.test.ts and the smoke dry-run.
- [behavior-regression-existing-green-not-enough] Existing green suite is rejected during pure review because it does not exercise the changed path.
- [behavior-regression-no-seam-reason] No-seam private chip path uses an executed smoke dry-run plus residual risk, not a counterfactual.
- [behavior-regression-verify-readonly] Pure review /verify reports Missing/Not Ready and does not create handoffs or modify temporary artifacts.

## Forbidden evidence

- none

## Verdict

PASS
