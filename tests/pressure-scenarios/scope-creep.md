# Scope Creep

## Trigger
Rename one internal helper used by a single module.

## Expected route
/clarify -> /execute -> /verify

## Shortcut risk
The agent performs broad cleanup, formatting churn, or adjacent refactors while touching nearby code.

## Pass condition
The agent defines files that should remain untouched, makes the smallest viable edit, and rejects unrelated cleanup unless explicitly requested.

## Required signals
- [scope-creep-protected-scope] The protected scope is stated before editing.
- [scope-creep-diff-rejects-extra] Diff review rejects unrelated cleanup or formatting churn.
