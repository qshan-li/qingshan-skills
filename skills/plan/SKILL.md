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

## Decision Brief

Use a decision brief for every Taste or User Challenge decision. Mechanical decisions do not need a brief; resolve them using project conventions.

Use the structure in `docs/templates/decision-brief.md` so decisions include the
same fields across sessions and handoffs.

Each decision brief must state:

- the decision being made
- why it matters now
- the recommended option
- alternatives with trade-offs
- whether the choice is reversible
- completeness or coverage differences when options differ by scope

Batch Taste decisions when possible. Stop on User Challenge decisions before execution.

## Vertical Slices and Durable Decisions

Prefer thin vertical slices: each task should deliver a narrow, end-to-end path that is independently verifiable. Avoid horizontal plans that split work by layer unless the work is truly infrastructure-only.

Only record an ADR or durable decision when all three are true:

- the decision is hard to reverse
- the choice would be surprising without context
- the outcome came from a real trade-off

When a user-approved decision passes this gate, record it before execution in the project's existing ADR or decision artifact. If the project has no existing convention, create or update root `DECISIONS.md`. Use the fields in `docs/templates/durable-decision.md`: decision, date, scope, rationale, alternatives rejected, and reversal conditions.

If planning identifies a possible durable decision but approval, evidence, or one of the three gates is missing, do not record it as durable. State the deferral reason in the plan.

## Workflow

1. Re-read the clarified goal and acceptance criteria.
2. List files or modules likely affected and files that should remain untouched.
3. Grade decisions:
   - Mechanical: choose using project conventions.
   - Taste: batch and present with a Decision Brief using `docs/templates/decision-brief.md`.
   - User Challenge: stop for explicit approval using a Decision Brief based on `docs/templates/decision-brief.md`.
4. Decompose work into vertical slices with verification after each meaningful change.
5. Record approved durable decisions that pass the three-gate rule, or explicitly defer them with a reason.
6. Define rollback or failure handling when changes affect deploy, data, security, or architecture.
7. End with a plan that can be executed without inventing missing requirements.

## Hard Rules

- Do not plan around missing acceptance criteria.
- Do not convert User Challenge decisions into Mechanical decisions.
- Do not ask vague open-ended questions when a Decision Brief is required.
- Do not add future-proofing, compatibility layers, or abstractions without current need.
- Do not let the plan include unrelated cleanup.
- Do not proceed if evidence required by the task is missing.
- Do not split by technical layer when a thin end-to-end slice can be verified independently.
- Do not leave approved durable decisions only in the conversation or plan text.
- Do not create a durable decision record when any gate is missing.

## Rationalization Prevention

| Excuse | Reality |
| --- | --- |
| "I can infer the architecture choice" | Architecture direction belongs to the user |
| "This cleanup is nearby" | Nearby is not in scope |
| "A generic abstraction will help later" | Later is not a requirement |
| "Rollback is obvious" | If failure is expensive, rollback must be explicit |
| "The user can just choose a direction" | Taste and User Challenge decisions need a recommendation, trade-offs, and reversibility |

## Outputs

- Ordered tasks.
- Affected and protected files/modules.
- Decision grades, Decision Briefs, and unresolved approvals.
- Durable decision artifact path and entry, or deferral reason.
- Vertical slices and dependencies.
- Validation strategy.
- Rollback or failure-handling notes when relevant.

## Handoff

- Use `/execute` when the plan is complete.
- Use `/clarify` when goals or decisions are unresolved.
- Use `/investigate` when facts or baselines are missing.
