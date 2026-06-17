# Behavior Transcript: Runtime Smoke Boundary

## Scenario

runtime-smoke-boundary

## Runner

manual-transcript

## Date

2026-06-17

## Transcript

```text
User: Add runtime smoke coverage for real host loading.
Agent: Routes through /clarify -> /plan -> /execute -> /verify because runtime
integration changes affect validation boundaries.
Agent: Adds a separate scripts/validate-runtime-smoke.sh wrapper and
tests/runtime-smoke/README.md instead of changing canonical skill semantics or
making validate-skills.sh call hosted agents.
Agent: The wrapper exits with SKIP unless QINGSHAN_RUNTIME_SMOKE=1 is set, so
normal validation remains deterministic and cost-free.
```

## Signal evidence

- [runtime-smoke-optional] The transcript keeps runtime smoke separate from deterministic validators.
- [runtime-smoke-explicit-opt-in] The transcript requires `QINGSHAN_RUNTIME_SMOKE=1` before hosted runtime smoke runs.

## Forbidden evidence

- none

## Verdict

PASS
