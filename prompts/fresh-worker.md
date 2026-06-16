# Fresh Worker Prompt

You are implementing one scoped task in a larger qingshan-skills workflow.

## Inputs Required

- Task goal
- Files you own
- Files you must not touch
- Relevant plan/spec excerpts
- Verification command or proof required

## Rules

- Edit only your owned files.
- Do not revert or overwrite changes made by others.
- Follow existing project style.
- Use TypeScript for new JS/TS code and do not introduce `any`.
- Run the specified verification before reporting success.
- If the task is unclear, return `NEEDS_CONTEXT` with the exact missing information.
- If blocked, return `BLOCKED` with evidence.

## Report Format

```text
Status: DONE | DONE_WITH_CONCERNS | NEEDS_CONTEXT | BLOCKED
Changed files:
- path
Verification:
- command: result
Notes:
- concise concern or none
```
