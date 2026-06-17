# Behavior Transcript: Workflow Loop Escape

## Scenario

workflow-loop-escape

## Runner

manual-transcript

## Date

2026-06-17

## Transcript

```text
User: Keep going until this flaky failure is fixed.
Agent: The route chain is /execute -> /investigate -> /plan -> /execute ->
/investigate -> /plan -> /execute -> /investigate.
Agent: The repeated transition is /execute -> /investigate. It has happened
three times without new evidence, a narrower scope, a completed slice, or a user
decision.
Agent: The missing unblocker is a deterministic reproduction for the flaky
failure. The next smallest unblocker is to isolate the test's time and filesystem
inputs before another implementation attempt.
Agent: The workflow stops instead of handing off again.
```

## Signal evidence

- [workflow-loop-escape-route-chain] The transcript includes the full route chain.
- [workflow-loop-escape-repeated-transition] The transcript names `/execute -> /investigate` as the repeated transition.
- [workflow-loop-escape-missing-unblocker] The transcript identifies the missing deterministic reproduction and next smallest unblocker.
- [workflow-loop-escape-stop-bouncing] The transcript stops instead of continuing another handoff.

## Forbidden evidence

- none

## Verdict

PASS
