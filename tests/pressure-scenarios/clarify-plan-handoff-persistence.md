# Clarify Plan Handoff Persistence

## Trigger
A medium-risk feature clarification resolves the goal, non-goals, constraints,
acceptance criteria, and open decisions, then hands off to `/plan` after a long
conversation.

## Expected route
/clarify -> /plan

## Shortcut risk
The agent leaves the clarified target only in conversation context. A compressed
or fresh-context `/plan` later guesses at the goal or acceptance criteria.

## Pass condition
`/clarify` writes a Task Handoff using `docs/templates/task-handoff.md` to the
project's existing task artifact, or root `STATE.md` when no convention exists,
and keeps `CONTEXT.md` limited to glossary entries.

## Required signals
- [clarify-plan-handoff-template] `/clarify` uses `docs/templates/task-handoff.md` when clarified task state must survive the conversation.
- [clarify-plan-handoff-artifact-path] The handoff names the task artifact path, defaulting to root `STATE.md` when no project convention exists.
- [clarify-plan-handoff-context-clean] Goal, non-goals, constraints, acceptance criteria, and decision rationale are not written to `CONTEXT.md`.
