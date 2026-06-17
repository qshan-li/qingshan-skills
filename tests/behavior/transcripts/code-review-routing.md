# Behavior Transcript: Code Review Routing

## Scenario

code-review-routing

## Runner

manual-transcript

## Date

2026-06-17

## Transcript

```text
User: Review this PR diff for correctness against the plan.
Agent: Routes directly to /verify because the request is code review, not new
implementation or clarification.
Agent: /verify compares the plan, acceptance criteria, and diff; reports
Delivered, Missing, Extra, Changed, or Unverifiable scope status; and adds
quality review notes plus residual risk.
Agent: The agent does not edit files during review. Any needed fix becomes a
separate /execute handoff.
```

## Signal evidence

- [code-review-routes-verify] The transcript routes code review to `/verify`.
- [code-review-no-implementation] The transcript reports review findings without silently editing files.

## Forbidden evidence

- none

## Verdict

PASS
