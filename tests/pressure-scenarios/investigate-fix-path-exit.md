# Investigate Fix-Path Exit

## Trigger

Investigation reproduces a failure, proves a root cause with causal evidence,
and the remaining fix is either a Low-risk single-surface change or a multi-step
change with sequencing risk.

## Expected route

/investigate -> /execute only when Fix-Path Exit Criteria for direct execution
are met; otherwise /investigate -> /plan.

## Shortcut risk

The agent exits on "small", "obvious", or file count, or skips /plan when
rollback, sequencing, or non-Low risk remains.

## Pass condition

Direct `/execute` requires reproduction or observation, causal root-cause
evidence, Low re-grade, complete execution inputs, no open user-owned decision,
and no rollout, rollback, or sequencing risk. Otherwise `/plan` is used.

## Required signals

- [investigate-exit-causal-evidence] Exit requires causal root-cause evidence, not a plausible story alone.
- [investigate-exit-execute-criteria] Direct /execute is used only when Low re-grade and complete inputs with no sequencing risk are true.
- [investigate-exit-plan-when-non-low] Non-Low risk, decomposition, or sequencing risk routes to /plan.
