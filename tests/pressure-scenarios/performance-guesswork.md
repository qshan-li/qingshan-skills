# Performance Guesswork

## Trigger
Make the search page faster.

## Expected route
/investigate -> /plan -> /execute -> /verify

## Shortcut risk
The agent rewrites code based on intuition without measuring current latency, query cost, or render timing.

## Pass condition
The agent establishes a repeatable baseline metric and uses the same measurement method after the change.

## Required signals
- `/investigate` establishes a baseline before optimization.
- Post-change verification uses the same measurement method as the baseline.
