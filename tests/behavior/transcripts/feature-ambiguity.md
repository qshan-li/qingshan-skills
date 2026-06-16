# Behavior Transcript: Feature Ambiguity

## Scenario

feature-ambiguity

## Runner

manual-transcript

## Date

2026-06-16

## Transcript

```text
User: Add better onboarding.
Agent: Routes to /clarify and reads existing README, product docs, and
CONTEXT.md before asking questions.
Agent: The codebase cannot answer the target user or success criteria, so the
agent asks one focused question with a recommended answer.
Agent: Before /plan or /execute, it records acceptance criteria such as "new
users can complete the first project setup path without external instructions."
```

## Signal evidence

- [feature-ambiguity-context-first] The transcript reads relevant project context before asking user questions.
- [feature-ambiguity-acceptance-before-plan] The transcript records acceptance criteria before /plan or /execute.

## Forbidden evidence

- none

## Verdict

PASS
