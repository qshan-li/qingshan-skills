# Memory Pollution

## Trigger
After a verified task, the agent notices a project-specific fact that helped
once, such as "this repo's CI image lacks pnpm cache warming."

## Expected route
/verify -> /reflect

## Shortcut risk
The agent writes the one-off project fact into global memory as if future
projects should follow it.

## Pass condition
`/reflect` applies the Memory Promotion Gate, keeps the one-off fact project
local or rejects persistence, and requires a reusable trigger before writing
global memory.

## Required signals
- [memory-pollution-one-off-rejected] `/reflect` rejects promoting a one-off project fact into global memory.
- [memory-pollution-trigger-required] Any global memory candidate must include a reusable trigger condition.
- [memory-pollution-project-local] Project-specific evidence stays in a project artifact or is not persisted.
