# Behavior Transcript: Taste Approval Gate

## Scenario

taste-approval-gate

## Runner

manual-transcript

## Date

2026-07-10

## Transcript

```text
User: Improve the plugin adapters and installer, then implement the plan.
Agent: /plan classifies the reversible adapter layout, test depth, and cleanup
ownership choices as Taste decisions. It presents one batch of Decision Briefs
with recommendations, alternatives, trade-offs, reversibility, and coverage.
Agent: Stops once before execution because the Taste batch is still open.

User: /execute
Agent: Does not treat the workflow invocation as approval. It returns the open
Taste batch and asks for explicit approval of all recommendations or named
alternatives.

User: Approve all recommended options.
Agent: Records the selected options and approval evidence, then continues to
/execute without asking again. If a recommendation, scope difference, or
reversibility assessment changes materially, it marks the decision changed and
requires approval again.
```

## Signal evidence

- [taste-approval-batched] The agent presents one batch instead of asking about each reversible choice separately.
- [taste-approval-explicit] Execution starts only after the user explicitly approves all recommended options.
- [taste-approval-execute-not-consent] The bare `/execute` invocation leaves the Taste batch open.
- [taste-approval-reopens-on-change] Material decision changes invalidate earlier approval.

## Forbidden evidence

- none

## Verdict

PASS
