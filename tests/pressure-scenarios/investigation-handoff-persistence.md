# Investigation Handoff Persistence

## Trigger
A high-risk production bug investigation establishes reproduction, facts,
ranked hypotheses, confidence, and a recommended fix path, then hands off to
`/plan` or `/execute`.

## Expected route
/investigate -> /plan

## Shortcut risk
The agent summarizes the investigation in chat only. After context compression
or a fresh worker handoff, the fix path loses the reproduction method, evidence,
or confidence level.

## Pass condition
`/investigate` writes an Investigation Handoff using
`docs/templates/task-handoff.md` to the project's existing task artifact, or
root `STATE.md` when no convention exists, before handing off.

## Required signals
- [investigation-handoff-template] `/investigate` uses `docs/templates/task-handoff.md` when evidence must survive the conversation.
- [investigation-handoff-evidence] The handoff includes reproduction or observation method, feedback loop limits, facts collected, narrowed surface, hypotheses with confidence, and recommended fix path.
- [investigation-handoff-artifact-path] The handoff names the task artifact path, defaulting to root `STATE.md` when no project convention exists.
