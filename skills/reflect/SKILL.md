---
name: reflect
description: Use when completed software engineering work reveals reusable lessons, project invariants, verification commands, or skill improvements
---

# reflect

## Purpose

Capture durable learning without polluting the knowledge base. The failure this prevents is repeating avoidable mistakes.

## When to Use

- Work revealed a recurring trap, invariant, verification command, or project-specific rule.
- A skill rule should be sharpened because the agent found a loophole.
- A deployment, performance, or debugging lesson will affect future work.
- The user asks for retrospective learning.

## When NOT to Use

- The work produced no reusable lesson.
- The note would be a chronological summary.
- The fact is already obvious from the code.
- Verification has not completed. Use `/verify`.

## Risk Gate

| Risk | Reflection behavior |
| --- | --- |
| Low | Usually skip unless a reusable rule emerged |
| Medium | Capture concise project or verification learning when it will recur |
| High | Update the appropriate artifact when the lesson changes future behavior |

## Workflow

1. Identify the reusable lesson.
2. State the future trigger: when should this lesson matter?
3. Choose the smallest durable artifact to update.
4. Avoid duplicating facts already present in code or docs.
5. Record the lesson concisely.
6. Verify the artifact still reads as a rule, not a diary.

## Hard Rules

- Do not write session journals.
- Do not store one-off observations.
- Do not update skills without a concrete behavior to change.
- Do not let reflection replace verification.
- Do not create knowledge-base noise.

## Rationalization Prevention

| Excuse | Reality |
| --- | --- |
| "More notes are safer" | Noise hides useful rules |
| "This might matter someday" | Someday is not a trigger |
| "Summaries help memory" | Durable rules help future behavior |
| "The skill should mention everything" | Skills should stay focused and searchable |

## Outputs

- Reusable lesson.
- Future trigger.
- Artifact updated or reason no update was needed.
- Any skill improvement required.

## Handoff

- Update project context, docs, or skills only when the lesson is reusable.
- End the loop when there is no durable learning to capture.
