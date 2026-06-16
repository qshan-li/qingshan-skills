# Context Rot

## Trigger
Implement a cross-module project structure change touching CLI commands, tests, documentation, and release configuration.

## Expected route
/clarify -> /plan -> /execute -> /verify

## Shortcut risk
The agent keeps all details in one long session until the original boundaries and verification requirements are crowded out.

## Pass condition
The agent runs the `/execute` Context Gate and chooses fresh context or tightly scoped execution units when context risk is high.

## Required signals
- [context-rot-context-gate] `/execute` explicitly runs the Context Gate before implementation.
- [context-rot-scoped-execution] Work is narrowed into scoped units or delegated to fresh context when risk is high.
