# Task Handoff Template

Use when `/clarify` or `/investigate` results must survive context compression,
agent handoff, fresh-context execution, or a handoff into `/plan` or `/execute`.
Keep the artifact current-task scoped.

## Task Type And Risk

<Feature, refactor, docs, bug, performance, deployment, security, or other task
type. Include Low, Medium, or High risk.>

## Goal

<The outcome the next workflow should preserve.>

## Non-Goals

- <Out-of-scope item>

## Constraints

- <Constraint or protected boundary>

## Acceptance Criteria

- <Observable condition that proves the task is done>

## Shared Language Status

<CONTEXT.md updated, no glossary update needed, or unresolved terminology.>

## Investigation Evidence

- Symptom:
- Expected behavior:
- Reproduction or observation method:
- Feedback loop quality and limits:
- Facts collected:
- Narrowed failing surface:
- Root-cause hypotheses and confidence:
- Recommended fix path:

## Open Decisions

- <Decision, grade, and owner>

## Next Workflow

`/plan` | `/execute` | `/investigate` | `/verify`

## Required Proof

- <Command, check, artifact, or manual proof>

## Stop Conditions

- Stop if acceptance criteria, required evidence, or a User Challenge decision is missing.
- Stop if the next workflow would need files or context not named here.
