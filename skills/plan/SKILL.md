---
name: plan
description: Use when a clarified software engineering goal needs task decomposition, decision grading, sequencing, validation strategy, or rollback planning
---

# plan

## Purpose

Turn shared understanding into ordered, verifiable work. The failure this prevents is scope drift plus silent decision theft.

## Direct Invocation

Direct invocation must still honor root `SKILL.md` and `ETHOS.md`. Apply the
root routing assumptions and shared non-negotiables before continuing; direct
invocation changes the entry point, not the hard rules.

Before continuing from direct invocation, state the entry reason, risk level,
required upstream facts, and fallback route. If the prerequisites for this skill
are missing, use the fallback route before irreversible action.

## When to Use

- A clarified goal needs multiple steps or files.
- Work has dependencies, rollback concerns, deployment risk, or non-trivial validation.
- The agent must classify decisions before implementation.
- A refactor, dependency upgrade, project structure change, or CI change needs blast-radius control.

## When NOT to Use

- The task is low-risk and can be executed directly after `/clarify`.
- The target, acceptance criteria, protected boundaries, or validation path
  cannot be established from the request, codebase, docs, or task artifacts. Use
  `/clarify`.
- A bug, performance issue, or deployment failure lacks evidence. Use `/investigate`.
- The user is asking to verify completed work. Use `/verify`.

## Risk Gate

| Risk | Planning behavior |
| --- | --- |
| Low | State files to touch and validation command |
| Medium | Create ordered tasks, risks, boundaries, and validation plan |
| High | Add rollback or failure-handling path, batch Taste approval, and stop immediately for User Challenge decisions |

## Direct Entry Preconditions

Direct `/plan` entry is valid when the task already has a clear target or when
the root router sends dependency upgrades, toolchain upgrades, CI changes, or
other blast-radius work here first.

Before planning implementation, establish a lightweight target statement,
acceptance criteria, protected boundaries, and validation path. If those cannot
be established from the request, codebase, docs, or existing task artifacts,
return to `/clarify`. If the plan depends on failure evidence, a performance
baseline, deployment logs, or root-cause facts, return to `/investigate`.

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
- approval status, selected option, and approval evidence

Stop immediately on User Challenge decisions. Send Taste decisions to the
single Taste Approval Gate before execution.

## Taste Approval Gate

After decision grading is complete, batch every open Taste Decision Brief into
one approval request. Recommend an option for each decision and let the user
approve all recommendations or select named alternatives. Do not ask about each
Taste decision separately unless an answer changes the remaining decision set.

Do not continue to `/execute` while any Taste decision is `open` or `changed`.
A later `/execute` invocation, a complete-outcome request, silence, or lack of
objection is not approval. Record the approved option and approval evidence in
the plan or Task Handoff so execution does not ask again.

If a recommendation, alternative, scope or coverage difference, or
reversibility assessment changes materially after approval, set its status to
`changed` and run the approval gate again. Mechanical implementation details do
not reopen approval.

## Decision-First Planning

For medium/high-risk work, list the decisions most likely to change the
implementation before listing ordered tasks. Prioritize user-visible behavior,
data model or schema shape, API or type contracts, ownership boundaries,
validation strategy, rollout, rollback, and any unknowns carried forward from
`/clarify`.

Classify each as Mechanical, Taste, or User Challenge using root Decision
Grading criteria:

- Mechanical: project conventions already decide it; reversible; no change to
  user-visible behavior, public contracts, data durability, architecture, or
  release risk.
- Taste: reversible choice that still affects user-facing behavior, documentation
  shape, workflow ergonomics, or implementation style with more than one
  reasonable option.
- User Challenge: architecture direction, product behavior, public contracts,
  decision-rights policy, irreversible data, or release risk.

When uncertainty affects user-visible behavior, public contracts, data,
architecture, or release risk, upgrade the grade. If no Taste or User Challenge
decisions remain, state that explicitly before the task list. Do not hide a
decision inside a task description just because a default implementation is
available.

Before continuing past planning, confirm agent-proposed goals or acceptance
package items from upstream work that change outcome, scope, success
definitions, non-goals, protected boundaries, or user-visible behavior.
Repository-derived items need cited evidence.

## Vertical Slices and Durable Decisions

Prefer thin vertical slices: each task should deliver a narrow, end-to-end path that is independently verifiable. Avoid horizontal plans that split work by layer unless the work is truly infrastructure-only.

Only record an ADR or durable decision when all three are true:

- the decision is hard to reverse
- the choice would be surprising without context
- the outcome came from a real trade-off

When a user-approved decision passes this gate, record it before execution in
the project's existing ADR or decision artifact. If the project has no existing
convention, create or update root `DECISIONS.md`. Use the fields in
`docs/templates/durable-decision.md`: decision, date, scope, rationale,
alternatives rejected, and reversal conditions.

When reading durable decisions, check scope and reversal conditions before
relying on them. If the trigger no longer matches or reversal conditions may now
apply, mark the entry stale, superseded, or unresolved in the plan instead of
silently using it.

If planning identifies a possible durable decision but approval, evidence, or one of the three gates is missing, do not record it as durable. State the deferral reason in the plan.

## Handoff Input

When planning follows `/clarify` or `/investigate`, read the current task
artifact produced from `docs/templates/task-handoff.md`, or root `STATE.md` when
no project task artifact exists. Treat missing acceptance criteria, required
evidence, open or changed Taste decisions, or unresolved User Challenge
decisions as stop conditions before execution.

Read only durable context that can affect architecture, risk, validation,
rollback, or user decision boundaries. Prefer existing ADRs or `DECISIONS.md`
for settled durable decisions and `LEARNINGS.md` or the relevant project
retrospective for recurring project pitfalls, verification commands, and known
traps. Retrieve global memory only when an entry's trigger matches the current
task shape, stack, risk, or artifact. Do not load unbounded memory dumps.
When a learning or durable decision is relevant but stale, superseded, or missing
an invalidation or reversal condition, report that status in the plan and avoid
turning it into an implicit requirement.

## Workflow

1. Re-read the clarified goal, or establish a direct-entry lightweight target, acceptance criteria, protected boundaries, validation path, and any Task Handoff artifact.
2. Read relevant durable decisions, project learnings, and trigger-matched global memory that can change architecture, risk, validation, rollback, or user decision boundaries.
3. List files or modules likely affected and files that should remain untouched.
4. For medium/high risk, run Decision-First Planning before ordered tasks.
5. Grade decisions:
   - Mechanical: choose using project conventions.
   - Taste: batch Decision Briefs and run the Taste Approval Gate once before execution.
   - User Challenge: stop immediately for explicit approval using a Decision Brief based on `docs/templates/decision-brief.md`.
6. Record selected Taste options and approval evidence, or stop with the open batch.
7. Place discovery probes early when carried-forward unknowns could change scope,
   sequencing, boundaries, or verification.
8. Decompose work into vertical slices with verification after each meaningful change.
9. Record approved durable decisions that pass the three-gate rule, or explicitly defer them with a reason.
10. Define rollback or failure handling when changes affect deploy, data, security, or architecture.
11. End with a plan that can be executed without inventing missing requirements.

## Hard Rules

- Do not plan around missing acceptance criteria.
- Do not convert User Challenge decisions into Mechanical decisions.
- Do not convert Taste recommendations into implicit approval.
- Do not leave agent-proposed acceptance criteria that decide success,
  non-goals, protected boundaries, or user-visible behavior unconfirmed.
- Do not ask vague open-ended questions when a Decision Brief is required.
- Do not put ordered tasks before decision grading for medium/high-risk work.
- Do not add future-proofing, compatibility layers, or abstractions without current need.
- Do not let the plan include unrelated cleanup.
- Do not proceed if evidence required by the task is missing.
- Do not ignore a relevant durable decision, project learning, or trigger-matched global memory entry that can affect the plan.
- Do not split by technical layer when a thin end-to-end slice can be verified independently.
- Do not leave approved durable decisions only in the conversation or plan text.
- Do not create a durable decision record when any gate is missing.

## Rationalization Prevention

| Excuse | Reality |
| --- | --- |
| "I can infer the architecture choice" | Architecture direction belongs to the user |
| "If unsure, keep it Mechanical" | Uncertainty that affects behavior, contracts, data, architecture, or release upgrades the grade |
| "This cleanup is nearby" | Nearby is not in scope |
| "A generic abstraction will help later" | Later is not a requirement |
| "Rollback is obvious" | If failure is expensive, rollback must be explicit |
| "The user can just choose a direction" | Taste and User Challenge decisions need a recommendation, trade-offs, and reversibility |
| "The task list makes the decisions obvious" | Hidden decisions still need grades before execution |
| "They invoked /execute, so the recommendations are approved" | Workflow selection is not consent to unresolved Taste decisions |

## Outputs

### Always

- Ordered tasks.
- Direct-entry target statement when planning did not follow `/clarify`.
- Affected and protected files/modules.
- Decision-first summary for medium/high-risk work.
- Decision grades, Decision Briefs, approval status, selected options, approval evidence, and unresolved approvals.
- Vertical slices and dependencies.
- Validation strategy.

### When Applicable

- Referenced memory and the trigger that made it relevant.
- Durable decision artifact path and entry, or deferral reason.
- Stale, superseded, or unresolved durable context that affected planning.
- Rollback or failure-handling notes when relevant.

## Handoff

Apply root `Workflow Continuation`. Continue to `/execute` when the original
request authorizes implementation, every Taste decision is approved, and no
other stop condition applies; otherwise return control with the recommended
next route.

Apply root `Workflow Handoff Selection` when returning control. Use only the
valid routes below as options, with the recommended route first.

Recommended next steps for the user:

- `/execute` when the plan is complete and approved.
- `/clarify` when goals or decisions are unresolved.
- `/investigate` when facts or baselines are missing.
