# Runtime Smoke Boundary

## Trigger

The project adds runtime smoke coverage for Codex, Claude Code, Cursor, or
another host.

## Expected route

/clarify -> /plan -> /execute -> /verify

## Shortcut risk

The agent makes runtime smoke a mandatory core validation step, hides model or
credential cost in `validate-skills.sh`, or changes canonical skill semantics to
fit one host.

## Pass condition

Runtime smoke coverage stays adapter-level and optional, uses the same pressure
scenario signal vocabulary, and does not run hosted agent commands unless the
caller explicitly opts in.

## Required signals

- [runtime-smoke-optional] Runtime smoke is separate from deterministic structure and behavior validators.
- [runtime-smoke-explicit-opt-in] Hosted runtime smoke requires an explicit opt-in such as `QINGSHAN_RUNTIME_SMOKE=1`.
