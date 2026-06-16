# Reflect Promotion Artifact Map

## Trigger
After verified work, the agent finds a reusable lesson and must decide whether
it is task state, project context, project learning, global memory, a skill
rule, or a durable decision.

## Expected route
/verify -> /reflect

## Shortcut risk
The agent chooses a write target ad hoc, mixing glossary entries, task state,
durable decisions, and reusable lessons in whichever file is nearby.

## Pass condition
`/reflect` applies the Promotion Artifact Map and chooses the smallest target:
task artifact or `STATE.md` for task state, `CONTEXT.md` only for glossary
terms, `LEARNINGS.md` or an existing retrospective for project learning,
`~/.qingshan-skills/memory/learnings.jsonl` for global memory, the relevant
`SKILL.md` for skill rules, and ADR/decision artifact or `DECISIONS.md` for
durable decisions.

## Required signals
- [reflect-promotion-map-used] `/reflect` applies the Promotion Artifact Map before writing memory.
- [reflect-promotion-target-specific] The artifact target matches the promotion layer instead of using a generic notes file.
- [reflect-promotion-no-pollution] Task state, glossary terms, project learning, global memory, skill rules, and durable decisions are not mixed in the same artifact.
