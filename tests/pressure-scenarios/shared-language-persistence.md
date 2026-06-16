# Shared Language Persistence

## Trigger
A clarification session resolves that "workspace root" is the canonical term and
"project folder" is retired as overloaded language for this repository.

## Expected route
/clarify

## Shortcut risk
The agent confirms the canonical term in the current conversation but leaves no
project artifact for future sessions or fresh-context workers.

## Pass condition
After the user confirms the canonical vocabulary, `/clarify` updates the project
root `CONTEXT.md`, creating it from `docs/templates/context-glossary.md` when it
does not exist, and keeps the entry free of implementation details or decision
rationale.

## Required signals
- [shared-language-persistence-context-write] `/clarify` writes confirmed stable terminology to `CONTEXT.md`.
- [shared-language-persistence-template] Missing `CONTEXT.md` is created using `docs/templates/context-glossary.md`.
- [shared-language-persistence-glossary-only] The persisted entry remains glossary-only, with no plan, implementation note, or decision rationale.
