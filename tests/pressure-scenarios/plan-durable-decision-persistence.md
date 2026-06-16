# Plan Durable Decision Persistence

## Trigger
During planning, the team approves a hard-to-reverse architecture decision that
would be surprising without context and was made after rejecting viable
alternatives.

## Expected route
/clarify -> /plan

## Shortcut risk
The agent notes that the choice is durable but does not record where future
sessions should find the decision or what evidence would justify reversing it.

## Pass condition
`/plan` records the approved durable decision in the project's existing ADR or
decision artifact, or in root `DECISIONS.md` when no project convention exists,
using the fields from `docs/templates/durable-decision.md`.

## Required signals
- [plan-durable-decision-three-gate] `/plan` applies the hard-to-reverse, surprising-without-context, real-trade-off gate.
- [plan-durable-decision-artifact-path] `/plan` names the decision artifact path, defaulting to root `DECISIONS.md` when no convention exists.
- [plan-durable-decision-template-fields] The recorded entry includes decision, date, scope, rationale, rejected alternatives, and reversal conditions.
