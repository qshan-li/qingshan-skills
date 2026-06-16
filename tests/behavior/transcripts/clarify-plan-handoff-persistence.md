# Behavior Transcript: Clarify Plan Handoff Persistence

## Scenario

clarify-plan-handoff-persistence

## Runner

manual-transcript

## Date

2026-06-16

## Transcript

```text
User: Clarify a medium-risk feature, then hand it to /plan after a long session.
Agent: Routes /clarify -> /plan and uses docs/templates/task-handoff.md because
the clarified goal, non-goals, constraints, acceptance criteria, and open
decisions must survive context compression.
Agent: Writes the handoff to STATE.md because no existing task artifact exists.
Agent: Keeps CONTEXT.md limited to confirmed glossary terms; goal, non-goals,
acceptance criteria, constraints, and decision rationale stay in STATE.md only.
```

## Signal evidence

- [clarify-plan-handoff-template] The transcript uses `docs/templates/task-handoff.md` for clarified task state that must survive the conversation.
- [clarify-plan-handoff-artifact-path] The transcript names `STATE.md` as the fallback task artifact path.
- [clarify-plan-handoff-context-clean] The transcript keeps goal, non-goals, constraints, acceptance criteria, and decision rationale out of `CONTEXT.md`.

## Forbidden evidence

- none

## Verdict

PASS
