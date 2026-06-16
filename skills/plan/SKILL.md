---
name: plan
description: Use when a clarified software engineering goal needs task decomposition, decision grading, sequencing, validation strategy, or rollback planning
---

# plan

## Purpose

Turn shared understanding into ordered, verifiable work. The failure this prevents is scope drift plus silent decision theft.

## When to Use

- A clarified goal needs multiple steps or files.
- Work has dependencies, rollback concerns, deployment risk, or non-trivial validation.
- The agent must classify decisions before implementation.
- A refactor, dependency upgrade, project structure change, or CI change needs blast-radius control.

## When NOT to Use

- The task is low-risk and can be executed directly after `/clarify`.
- A bug, performance issue, or deployment failure lacks evidence. Use `/investigate`.
- The user is asking to verify completed work. Use `/verify`.

## Risk Gate

| Risk | Planning behavior |
| --- | --- |
| Low | State files to touch and validation command |
| Medium | Create ordered tasks, risks, boundaries, and validation plan |
| High | Add rollback or failure-handling path and stop for User Challenge decisions |

## Workflow

1. Re-read the clarified goal and acceptance criteria.
2. List files or modules likely affected and files that should remain untouched.
3. Grade decisions:
   - Mechanical: choose using project conventions.
   - Taste: batch and present with a recommendation.
   - User Challenge: stop for explicit approval.
4. Decompose work into small tasks with verification after each meaningful change.
5. Define rollback or failure handling when changes affect deploy, data, security, or architecture.
6. End with a plan that can be executed without inventing missing requirements.

## Hard Rules

- Do not plan around missing acceptance criteria.
- Do not convert User Challenge decisions into Mechanical decisions.
- Do not add future-proofing, compatibility layers, or abstractions without current need.
- Do not let the plan include unrelated cleanup.
- Do not proceed if evidence required by the task is missing.

## Rationalization Prevention

| Excuse | Reality |
| --- | --- |
| "I can infer the architecture choice" | Architecture direction belongs to the user |
| "This cleanup is nearby" | Nearby is not in scope |
| "A generic abstraction will help later" | Later is not a requirement |
| "Rollback is obvious" | If failure is expensive, rollback must be explicit |

## Outputs

- Ordered tasks.
- Affected and protected files/modules.
- Decision grades and unresolved approvals.
- Validation strategy.
- Rollback or failure-handling notes when relevant.

## Handoff

- Use `/execute` when the plan is complete.
- Use `/clarify` when goals or decisions are unresolved.
- Use `/investigate` when facts or baselines are missing.
