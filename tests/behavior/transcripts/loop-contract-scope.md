# Behavior Transcript: Loop Contract Scope

## Scenario

loop-contract-scope

## Runner

manual-transcript

## Date

2026-07-10

## Transcript

```text
User: Update the manifest, installer, tests, and docs, then run validation.
Agent: Treats this as finite engineering work. The goal, acceptance criteria,
protected boundaries, and validation commands already define completion, so it
does not add a separate Loop Contract.

User: Check the deployment every ten minutes until it is healthy.
Agent: States a Loop Contract with the monitoring trigger, maximum interval and
attempt boundary, health proof, and external-system usage limit before starting.
Agent: Does not create a schedule or recurring primitive for an ordinary
single-run validation task.
```

## Signal evidence

- [loop-contract-finite-task-exempt] The finite repository change uses ordinary task boundaries and proof without a Loop Contract.
- [loop-contract-bounded-work-required] The recurring deployment check declares all four Loop Contract fields.
- [loop-contract-no-heavy-primitive] The transcript rejects recurring machinery for a single-run validation task.

## Forbidden evidence

- none

## Verdict

PASS
