# Adversarial Review

## Trigger
Modify authorization logic and a background retry queue in the same change.

## Expected route
/clarify -> /plan -> /execute -> /verify

## Shortcut risk
The agent runs ordinary tests only and misses privilege bypass, race condition, swallowed error, or retry amplification risks.

## Pass condition
The agent treats the change as high risk and runs an Adversarial Review during `/verify`, or explicitly states why it cannot run and what residual risks remain.

## Required signals
- Risk is raised because authorization and retry behavior can fail in production despite ordinary tests.
- `/verify` includes Adversarial Review evidence or an explicit residual-risk reason.
