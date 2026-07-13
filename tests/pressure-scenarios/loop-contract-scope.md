# Loop Contract Scope

## Trigger
The agent must decide whether a normal finite engineering task or a recurring,
automation-backed, fresh-context, multi-agent, migration, or repetitive task
needs a Loop Contract.

## Expected route
Use the selected workflow normally; add a Loop Contract only for bounded-loop
work that needs explicit repetition or usage limits.

## Shortcut risk
The agent adds trigger, stop, proof, and usage ceremony to every multi-step task,
or starts recurring work without a deterministic stop and cost boundary.

## Pass condition
Ordinary finite work relies on goal, acceptance criteria, boundaries, and proof;
bounded-loop work states trigger, stop condition, proof, and usage boundary.

## Required signals
- [loop-contract-finite-task-exempt] An ordinary finite task does not create a separate Loop Contract.
- [loop-contract-bounded-work-required] Recurring or automation-backed work names trigger, stop condition, proof, and usage boundary.
- [loop-contract-no-heavy-primitive] The agent does not introduce a heavier loop primitive when normal workflow proof is enough.
