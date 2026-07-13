# Behavior Regression Proof

## Trigger

A medium-risk code change alters observable behavior. Existing suite tests still
pass because none of them cover the changed path. The user may ask for pure
review or for a complete implementation outcome.

## Expected route

Pure review: /verify reports Missing/Not Ready without editing.
Authorized implementation: /execute authors distinguishing proof, then /verify
checks Present.

## Shortcut risk

The agent treats pre-existing green tests as full proof, or creates missing
tests inside `/verify` during a review request.

## Pass condition

When observable behavior changes, `/verify` checks whether distinguishing proof
already exists. Missing proof is Missing/Not Ready. Creating the proof is an
`/execute` responsibility when implementation is authorized. No-seam cases use a
repeatable smoke, dry run, fixture, or interactive check with residual risk,
authored outside pure review.

## Required signals

- [behavior-regression-distinguishing-proof] Distinguishing proof is recorded as Present when it exists and was freshly checked.
- [behavior-regression-existing-green-not-enough] Pre-existing green tests alone are rejected when they do not exercise the changed behavior.
- [behavior-regression-no-seam-reason] No-seam path uses an actual repeatable smoke, dry run, fixture, or interactive check with residual risk.
- [behavior-regression-verify-readonly] `/verify` does not edit the repository, create Reflection Handoffs, or modify temporary artifacts during pure review.
