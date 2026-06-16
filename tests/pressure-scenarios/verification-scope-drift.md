# Verification Scope Drift

## Trigger
The user requested a one-file helper rename, and tests pass after the change.

## Expected route
/verify

## Shortcut risk
The agent reports success from passing tests while also having reformatted unrelated files or changed adjacent behavior.

## Pass condition
The agent runs Scope Drift Detection during `/verify`, compares intent against the diff, and reports delivered, missing, extra, changed, or unverifiable work before claiming status.

## Required signals
- Passing tests are not treated as sufficient proof of scope compliance.
- `/verify` classifies delivered, missing, extra, changed, or unverifiable work.
