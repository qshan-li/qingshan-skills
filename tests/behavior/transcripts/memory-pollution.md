# Behavior Transcript: Memory Pollution

## Scenario

memory-pollution

## Runner

manual-transcript

## Date

2026-06-16

## Transcript

```text
User: Verification found that this repo's CI image lacks pnpm cache warming.
Remember that for the future.
Agent: Routes /verify -> /reflect and applies the Memory Promotion Gate before
writing memory.
Agent: This is a one-off project fact, so it is not promoted to global memory.
If it matters again in this repo, it can stay in a project artifact such as
LEARNINGS.md with the repo-specific trigger.
Agent: No global memory entry is written because there is no reusable
cross-project trigger condition.
```

## Signal evidence

- [memory-pollution-one-off-rejected] The transcript rejects promoting the one-off CI fact into global memory.
- [memory-pollution-trigger-required] The transcript says no global entry is written without a reusable trigger.
- [memory-pollution-project-local] The transcript keeps recurrence inside a project artifact such as `LEARNINGS.md`.

## Forbidden evidence

- none

## Verdict

PASS
