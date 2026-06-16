# Behavior Transcript: Durable Decision Log

## Scenario

durable-decision-log

## Runner

manual-transcript

## Date

2026-06-16

## Transcript

```text
User: We decided to keep REST endpoints instead of migrating this project to
GraphQL.
Agent: Routes to /reflect because the work is verified and the outcome is a
durable project decision, not a reusable lesson about GraphQL generally.
Agent: Records a Durable Decision Log entry with decision "keep REST endpoints",
date 2026-06-16, scope "this repository API boundary", rationale, rejected
alternative "GraphQL migration", and reversal conditions such as client
requirements changing.
```

## Signal evidence

- [durable-decision-log-separation] The transcript separates the durable project decision from a reusable lesson.
- [durable-decision-log-complete-fields] The transcript includes decision, date, scope, rationale, rejected alternatives, and reversal conditions.

## Forbidden evidence

- none

## Verdict

PASS
