# gstack Absorption Design

Date: 2026-06-16

## Purpose

This addendum records the approved direction for absorbing more gstack ideas into qingshan-skills without expanding the six-skill top-level structure.

The core decision is:

- keep `/clarify`, `/plan`, `/execute`, `/investigate`, `/verify`, and `/reflect` as the only top-level workflow skills
- strengthen `/plan`, `/verify`, and `/reflect` with selected gstack patterns
- reject gstack mechanisms that add role catalog size, runtime preamble weight, telemetry, or release automation that does not serve this project

## Problem

qingshan-skills already absorbs major ideas from Superpowers and GSD:

- Superpowers contributes mandatory workflow discipline, rationalization prevention, TDD, and verification pressure.
- GSD contributes context-rot awareness, fresh-context execution, and continuity artifacts.

The current design mentions gstack, but its absorption is still thinner. Decision grading and multi-perspective review are present, yet several useful gstack patterns are not explicit enough in the actual skill contracts:

- decisions should be presented as structured decision briefs, not vague questions
- verification should check for scope drift, not only correctness
- high-risk work should receive adversarial review, not only friendly review
- release readiness should be visible as a dashboard of gates and stale evidence
- durable decisions should be recorded separately from reusable lessons

## Accepted Patterns

### Decision Briefs

`/plan` should upgrade its decision classification into a concrete decision brief format.

Each non-mechanical decision should state:

- the decision being made
- why the decision matters
- the recommended option
- alternatives with trade-offs
- whether the choice is reversible
- the completeness or coverage difference when options differ by scope

This preserves gstack's useful decision quality without importing its full AskUserQuestion machinery.

### Scope Drift Detection

`/verify` should compare intent against actual changes.

The verifier should inspect the plan, task statement, commit messages, and diff when available, then classify:

- delivered as requested
- missing required work
- extra work outside scope
- changed approach that still satisfies the goal
- unverifiable external state

This prevents a common false success mode: tests pass, but the work is not the work that was requested.

### Review Readiness Dashboard

`/verify` should report evidence as a small readiness dashboard.

The dashboard should include task-relevant rows such as:

- tests
- type check
- build
- lint
- manual smoke check
- scope drift review
- adversarial review
- release or rollback readiness
- residual risk

Each row should show fresh evidence, stale evidence, skipped with reason, blocked, or not applicable. This makes verification auditable instead of prose-only.

### Adversarial Review

`/verify` should include an adversarial review branch for high-risk work.

Triggers include:

- authentication, authorization, or secret handling
- data migration or irreversible data changes
- concurrency, queueing, retries, or distributed state
- payment, billing, or compliance paths
- deployment, CI/CD, or rollback behavior
- LLM output trust boundaries
- large or cross-module diffs

The review stance should look for production failure modes: silent data corruption, privilege bypass, race conditions, swallowed errors, resource leaks, unsafe external state assumptions, and incomplete rollback paths.

### Durable Decision Log

`/reflect` should distinguish durable decisions from reusable lessons.

A durable decision is a settled architecture, scope, tool, vendor, release, or reversal choice that future sessions should not silently re-litigate. It should record:

- the decision
- date
- scope
- rationale
- alternatives rejected
- reversal conditions

A lesson is a reusable pattern or pitfall. Durable decisions may stay project-local; lessons require promotion through the existing Memory Promotion Gate.

### Release Gate Inside `/verify`

Shipping should remain a release path, not a top-level skill.

When the user asks to ship, publish, create a PR, merge, or deploy, the root router should enter `/verify` with release risk enabled. `/verify` should require:

- fresh verification evidence
- scope drift review
- review status and staleness check
- rollback or recovery note when relevant
- commit or PR hygiene checks when the repository supports them

This absorbs gstack's release discipline without copying its version bump, changelog, and PR automation as mandatory behavior.

### Soft Dependencies

The root `SKILL.md` and individual skill handoffs should use gstack's soft dependency idea in prose.

Examples:

- `/verify` benefits from `/plan` when acceptance criteria or task boundaries exist.
- `/reflect` benefits from `/verify` because only verified outcomes should become durable memory.
- `/execute` benefits from `/investigate` when the task starts from a bug, incident, or performance problem.

This keeps the skills composable without forcing every task through a fixed ceremony.

## Rejected Patterns

The following gstack ideas should not be absorbed into qingshan-skills now:

- a large role catalog such as CEO, designer, engineering manager, DX lead, QA, and release manager as separate skills
- a global runtime preamble with update checks, telemetry, configuration discovery, and analytics
- automatic version bumping, changelog generation, PR creation, or push behavior as default methodology
- "Boil the Ocean" as an implementation principle
- persistent global memory without the `/reflect` promotion gate
- automatic WIP checkpoint commits as default behavior

The reason is consistency with qingshan-skills' philosophy: minimal process, surgical changes, and verification proportional to risk.

## Skill-Level Changes

### `/plan`

Add a Decision Brief section to the workflow.

The skill should require decision briefs for Taste and User Challenge decisions, while Mechanical decisions remain agent-owned and should be resolved using project conventions.

Acceptance criteria:

- Mechanical decisions are not escalated unnecessarily.
- Taste decisions are batched when possible.
- User Challenge decisions stop execution until explicitly resolved.
- Each non-mechanical decision includes recommendation, alternatives, reversibility, and trade-offs.

### `/verify`

Add three verification dimensions:

- Scope Drift Detection
- Review Readiness Dashboard
- Adversarial Review for high-risk changes

The dashboard should be short and evidence-oriented. It should not become a bureaucratic template for low-risk documentation changes.

Acceptance criteria:

- Verification reports what was checked and what was not checked.
- Verification distinguishes stale evidence from fresh evidence.
- Verification identifies missing, extra, changed, and unverifiable work.
- High-risk changes receive an adversarial pass or an explicit reason why it could not run.

### `/reflect`

Add Durable Decision Log handling beside the existing Memory Promotion Gate.

Acceptance criteria:

- Durable decisions are not mixed with general lessons.
- Lessons still require promotion discipline.
- Reversals supersede earlier decisions instead of creating contradictory memory.
- Project-local facts do not become global rules without evidence.

### Root `SKILL.md`

Clarify routing for release requests and soft dependencies.

Acceptance criteria:

- Ship, deploy, PR, merge, and release wording routes to `/verify`, not to a new `/ship` skill.
- The router recommends prerequisite skills when they reduce risk, but avoids forcing unnecessary ceremony.
- The six-skill top-level structure remains unchanged.

## Test And Review Updates

Add or update pressure scenarios for:

- a Taste decision that must be presented as a decision brief
- a User Challenge decision that must block execution
- a completed task with passing tests but extra unrelated changes
- a release request with stale verification evidence
- a high-risk security or data change that needs adversarial review
- a durable architecture decision that should not be promoted as a global lesson

Existing structural validation should continue to require the common skill chassis and rationalization prevention sections.

## Non-Goals

This design does not create new top-level skills.

This design does not introduce telemetry, auto-update checks, global config machinery, or gstack's full role catalog.

This design does not require every small task to produce a dashboard, decision brief, or durable decision. Risk still determines process weight.

This design does not implement automatic release tooling. It only defines the methodology gates that should apply when release work is requested.

## Implementation Sequence

1. Update `/plan` with the Decision Brief requirement.
2. Update `/verify` with Scope Drift Detection, Review Readiness Dashboard, Adversarial Review, and release gate wording.
3. Update `/reflect` with Durable Decision Log handling.
4. Update root `SKILL.md` routing and handoff language for release requests and soft dependencies.
5. Update docs to explain the refined gstack absorption.
6. Add or adjust pressure scenarios.
7. Run structural validation.

This is one coherent methodology refinement. It should be implemented surgically inside existing files, not as a directory expansion.
