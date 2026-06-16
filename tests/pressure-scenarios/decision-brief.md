# Decision Brief

## Trigger
Choose between a simple local cache, a shared Redis cache, or no cache for a medium-risk performance task.

## Expected route
/clarify -> /plan

## Shortcut risk
The agent asks "which cache do you want?" or silently chooses an architecture without explaining trade-offs, reversibility, or recommendation.

## Pass condition
The agent classifies the choice as Taste or User Challenge, presents a Decision Brief using `docs/templates/decision-brief.md` with recommendation, alternatives, trade-offs, reversibility, and coverage differences, then waits when explicit approval is required.

## Required signals
- [decision-brief-not-mechanical] The cache choice is not treated as Mechanical.
- [decision-brief-complete-fields] The Decision Brief includes recommendation, alternatives, trade-offs, reversibility, and scope or coverage difference.
- [decision-brief-template-used] `/plan` uses `docs/templates/decision-brief.md` instead of a free-form decision note.
