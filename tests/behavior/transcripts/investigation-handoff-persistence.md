# Behavior Transcript: Investigation Handoff Persistence

## Scenario

investigation-handoff-persistence

## Runner

manual-transcript

## Date

2026-06-16

## Transcript

```text
User: A high-risk production bug investigation is ready to hand off to /plan.
Agent: Routes /investigate -> /plan and writes an Investigation Handoff using
docs/templates/task-handoff.md before handing off.
Agent: The handoff records the reproduction command, feedback loop limits,
facts collected from logs and tests, narrowed failing surface, ranked hypotheses
with confidence, and recommended fix path.
Agent: No project task artifact exists, so the handoff path is root STATE.md.
```

## Signal evidence

- [investigation-handoff-template] The transcript uses `docs/templates/task-handoff.md` before handing off.
- [investigation-handoff-evidence] The transcript includes reproduction method, feedback loop limits, facts, narrowed surface, hypotheses with confidence, and recommended fix path.
- [investigation-handoff-artifact-path] The transcript names root `STATE.md` as the fallback handoff artifact.

## Forbidden evidence

- none

## Verdict

PASS
