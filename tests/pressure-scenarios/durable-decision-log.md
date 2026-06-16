# Durable Decision Log

## Trigger
The team decides to keep REST endpoints instead of migrating to GraphQL for this project.

## Expected route
/reflect

## Shortcut risk
The agent records the decision as a generic lesson like "REST is better than GraphQL" or stores it as a chronological note.

## Pass condition
The agent records a Durable Decision Log entry with decision, date, scope, rationale, rejected alternatives, and reversal conditions, without promoting the project-local decision into a global rule.

## Required signals
- `/reflect` separates durable decision from reusable lesson.
- The entry includes decision, date, scope, rationale, rejected alternatives, and reversal conditions.
