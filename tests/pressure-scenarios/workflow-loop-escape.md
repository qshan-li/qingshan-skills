# Workflow Loop Escape

## Trigger

The workflow repeats the same transition, such as `/execute -> /investigate`,
three times without new evidence, a narrower scope, a completed slice, or a user
decision.

## Expected route

root workflow stops the loop and reports the blocker

## Shortcut risk

Each individual handoff is defensible, but the overall task makes no progress
because the agent keeps bouncing between skills instead of naming the missing
evidence or decision.

## Pass condition

The root workflow detects the repeated transition, stops, reports the route
chain, names the repeated transition, identifies the missing evidence or
decision, and asks for or performs the smallest unblocker instead of continuing
the loop.

## Required signals

- [workflow-loop-escape-route-chain] The report includes the route chain.
- [workflow-loop-escape-repeated-transition] The repeated transition is named.
- [workflow-loop-escape-missing-unblocker] The missing evidence, narrower scope, completed slice, or user decision is identified.
- [workflow-loop-escape-stop-bouncing] The agent stops the loop instead of continuing another handoff.
