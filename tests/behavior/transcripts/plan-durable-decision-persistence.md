# Behavior Transcript: Plan Durable Decision Persistence

## Scenario

plan-durable-decision-persistence

## Runner

manual-transcript

## Date

2026-06-16

## Transcript

```text
User: The team approves a hard-to-reverse architecture direction after comparing
two viable alternatives.
Agent: In /plan, applies the three-gate rule: hard to reverse,
surprising without context, and based on a real trade-off.
Agent: No existing ADR convention exists, so the durable decision is recorded in
root DECISIONS.md using docs/templates/durable-decision.md.
Agent: The entry includes decision, date, scope, rationale, alternatives
rejected, and reversal conditions.
```

## Signal evidence

- [plan-durable-decision-three-gate] The transcript applies the hard-to-reverse, surprising-without-context, real-trade-off gate.
- [plan-durable-decision-artifact-path] The transcript names root `DECISIONS.md` as the fallback decision artifact.
- [plan-durable-decision-template-fields] The transcript includes decision, date, scope, rationale, rejected alternatives, and reversal conditions.

## Forbidden evidence

- none

## Verdict

PASS
