# qingshan-skills Design

Date: 2026-06-16

## Purpose

qingshan-skills is a cross-agent software engineering methodology. It is not a copy of gstack, Superpowers, GSD, or Grill Me. It distills their strongest patterns into a smaller system optimized for personal engineering work:

- minimal process unless risk requires more
- surgical changes over broad refactors
- TypeScript-first implementation discipline
- evidence before completion claims
- fresh context for complex execution
- reusable learning without knowledge-base noise

The system must apply to software engineering work broadly, not only feature development. It must cover new features, bug fixes, refactoring, project structure optimization, deployment and CI/CD changes, performance tuning, testing work, documentation, dependency upgrades, and security or stability work.

## Source Influences

The system intentionally takes different pieces from each reference framework:

- Superpowers provides the primary model for mandatory workflows, rationalization prevention, verification discipline, TDD, and the `/clarify` brainstorming flow.
- Grill Me provides one-question-at-a-time inquiry, recommended answers, decision-tree exploration, and the rule that codebase-answerable questions should be answered by reading the code.
- gstack provides proactive routing, decision classification, multi-perspective review, and release discipline.
- GSD provides context-rot prevention, fresh-context execution, and persistent artifacts for cross-session continuity.

The system intentionally avoids the heavier parts of the references:

- no large role catalog
- no mandatory browser dependency
- no telemetry layer
- no large shared preamble template
- no top-level skill for every sub-process
- no workflow ceremony for tasks whose risk does not justify it

## Core Structure

The top-level system has six skills:

| Skill | Primary failure prevented |
| --- | --- |
| `/clarify` | Acting before the goal, constraints, and acceptance criteria are understood |
| `/plan` | Scope drift, poor task decomposition, and hidden high-impact decisions |
| `/execute` | Execution drift, over-engineering, context rot, and unsafe code changes |
| `/investigate` | Guessing at fixes without facts or root-cause evidence |
| `/verify` | Claiming completion without proof |
| `/reflect` | Repeating mistakes because useful lessons were not captured |

TDD, review, and shipping are not top-level skills:

- TDD is the default execution mode for high-risk code changes inside `/execute`.
- Review is a verification dimension inside `/verify`.
- Ship is the release path after `/verify` passes.

This keeps the top-level vocabulary small while preserving the important disciplines.

## Task Taxonomy

The root skill should route work by task type, then select the necessary workflow weight.

| Task type | Default entry | Key constraint |
| --- | --- | --- |
| New feature | `/clarify` | Define user value, boundaries, and acceptance criteria |
| Bug fix | `/investigate` | Reproduce and identify the root cause before fixing |
| Refactor or project structure optimization | `/clarify` or `/investigate` | Prove the current problem and limit the blast radius |
| Performance tuning | `/investigate` | Establish a reproducible baseline before changing code |
| Deployment, CI, or release optimization | `/clarify` | Define environment boundaries, rollback path, and verification path |
| Test system improvement | `/investigate` or `/plan` | Fix real coverage gaps instead of manufacturing tests for metrics |
| Documentation, standards, or developer experience | `/clarify` | Serve an actual workflow; avoid decorative documentation |
| Dependency or toolchain upgrade | `/plan` | Control blast radius and verify build and runtime paths |
| Security or stability work | `/investigate` | Start from a threat, incident, or failure model |

Every task type must answer the same baseline questions:

1. What real problem is this solving?
2. What happens if it is not done?
3. What is the smallest viable change?
4. Which files, modules, or behaviors should remain untouched?
5. How will the agent prove the change works?
6. If the change fails, how should the agent roll back or continue investigating?

## Risk Model

Risk determines process weight.

| Risk | Typical examples | Required behavior |
| --- | --- | --- |
| Low | Typo fix, small documentation correction, isolated config wording | Clarify the goal and validation path; execute surgically; verify minimally |
| Medium | Local feature change, focused refactor, test improvement, single-service CI change | Compare options when meaningful; record target and non-targets; plan tasks and verification |
| High | Cross-module architecture change, data migration, deployment pipeline change, security fix, performance tuning, unclear product behavior | Full relevant flow: investigate first when evidence is required, otherwise full clarify; explicit design approval; written plan; strongest verification available |

Low-risk work may skip formal artifacts, but it may not skip the hard rules.

## Shared Skill Chassis

Each skill should use the same lightweight document shape:

```yaml
---
name: <skill-name>
description: Use when <trigger conditions only>
---
```

The `description` field must describe when to trigger the skill, not what the skill does. This follows the Superpowers CSO rule and prevents agents from treating the frontmatter as a shortcut around the body.

Each skill body should contain:

- Purpose: the failure mode this skill prevents
- When to Use: concrete trigger conditions across engineering task types
- When NOT to Use: cases where this skill would add process without reducing risk
- Risk Gate: low, medium, and high-risk handling
- Workflow: short steps with observable outputs
- Hard Rules: non-negotiable constraints
- Rationalization Prevention: common agent excuses and counters
- Outputs: artifacts or statements required before handoff
- Handoff: likely next skills and prohibited shortcuts

## Core Ethos

These principles belong in `ETHOS.md` and should be referenced by every skill.

### Understand Before Acting

The agent must know the goal, constraints, acceptance criteria, and non-goals before making changes. If the answer is available from the codebase, the agent should read the code instead of asking the user.

### Risk Determines Process

Small, reversible tasks use light process. High-impact, ambiguous, or cross-cutting tasks use stronger process. The workflow can shrink with risk, but the hard rules cannot.

### Minimal, Surgical Change

The agent changes only what the current task requires. It does not perform unrelated refactors, cleanup, format churn, compatibility work, or speculative configuration.

### Readable Is Documented

Names, structure, and types should make intent clear. Comments explain why, not what.

### Type Safety First

In JavaScript and TypeScript projects, new code should be TypeScript-first. `any` is forbidden. Use `unknown`, type guards, explicit interfaces, or discriminated unions instead.

### Evidence Before Claims

Bugs require reproduction. Performance work requires a baseline. Deployment work requires logs, environment boundaries, and rollback thinking. Completion requires verification output.

### Preserve Context Quality

Large work should be decomposed. Complex execution should use fresh context or subagents. Critical state and decisions should be written to artifacts when they will matter across sessions.

## Non-Negotiables

- Do not modify code before understanding the goal.
- Do not fix a bug without root-cause evidence.
- Do not optimize performance without a baseline.
- Do not claim completion without verification.
- Do not perform unrelated refactoring without explicit user instruction.
- Do not introduce `any` in TypeScript code.
- Do not swallow exceptions or ignore promises.
- Do not switch package managers without explicit instruction.
- Do not write compatibility layers for old environments unless required.
- Do not automate high-impact product, architecture, or irreversible decisions that belong to the user.

## Skill Responsibilities

### `/clarify`

`/clarify` is the entry point when a task needs goal, scope, constraint, or acceptance-criteria clarification. It applies to feature work, refactors, project structure changes, deployment changes, performance initiatives, documentation, and developer-experience work.

`/clarify` should use Superpowers brainstorming as a primary reference, adapted by risk:

- Low risk: inspect context, confirm the target and minimum validation path, then proceed.
- Medium risk: inspect context, ask focused questions when needed, compare two or three approaches, and record goals, non-goals, acceptance criteria, and risks.
- High risk: perform the full brainstorming pattern: explore project context, ask questions one at a time, propose approaches with trade-offs and a recommendation, present a design for approval, write a spec, self-review the spec, and wait for user approval before planning.

It should also inherit Grill Me rules:

- ask one question at a time
- provide a recommended answer when asking
- walk the decision tree in dependency order
- inspect the codebase instead of asking questions the code can answer

Outputs:

- goal
- non-goals
- constraints
- acceptance criteria
- risk level
- approved design or lightweight target statement

Handoff:

- to `/plan` for medium or high-risk work
- to `/execute` for low-risk work with clear validation
- to `/investigate` if the task is actually failure analysis, performance diagnosis, or root-cause work

### `/plan`

`/plan` turns a clarified goal into executable work. It should prevent vague tasks, hidden dependencies, and accidental architecture decisions.

It classifies decisions:

- Mechanical decisions: agent may decide using project conventions.
- Taste or product decisions: batch for user review when they affect user-facing behavior.
- High-impact or irreversible decisions: stop and get explicit user approval.

Outputs:

- ordered tasks
- task boundaries
- files or modules likely affected
- risks and dependencies
- validation strategy
- rollback or failure-handling strategy when relevant

Handoff:

- to `/execute` for implementation
- back to `/clarify` if goals or acceptance criteria are missing
- to `/investigate` if planning reveals missing evidence

### `/execute`

`/execute` performs all engineering changes, not only feature development. It must preserve scope and project style.

For high-risk code changes, TDD is the default:

1. write the failing test
2. confirm the failure for the right reason
3. implement the smallest passing change
4. refactor only while tests stay green

For non-code or low-risk tasks, `/execute` still requires surgical edits and explicit self-checks.

Complex work may use fresh-context subagents, especially when tasks are independent or context size threatens reasoning quality.

Outputs:

- changed files
- what changed and why
- self-checks performed
- unresolved risks or blockers

Handoff:

- to `/verify` before any completion claim
- to `/investigate` when execution exposes unexpected failures
- back to `/plan` if task boundaries prove wrong

### `/investigate`

`/investigate` is used for bugs, failing tests, deployment failures, performance issues, security issues, and stability problems. Its rule is: no facts, no fix.

Workflow:

1. Reproduce or observe the failure.
2. Collect evidence from tests, logs, metrics, traces, or code paths.
3. Narrow the failing surface.
4. Form a root-cause hypothesis.
5. Test the hypothesis.
6. Recommend the smallest fix path.

Performance work must include a baseline and repeatable measurement method. Deployment work must include environment boundaries and failure evidence. Security and stability work must include a threat or failure model.

Outputs:

- reproduction or observation method
- facts collected
- narrowed scope
- root-cause hypothesis
- confidence level
- recommended fix path

Handoff:

- to `/plan` for non-trivial fixes
- to `/execute` for small, obvious fixes after evidence exists
- remain in `/investigate` if evidence is still insufficient

### `/verify`

`/verify` proves the work is valid before completion is claimed. It includes testing, type checking, build checks, manual checks, review dimensions, and task-specific proof.

Verification depends on task type:

- New feature: tests, type checks, build, and acceptance criteria
- Bug fix: regression test or equivalent proof plus root-cause coverage
- Refactor or structure optimization: behavior-preserving tests and diff scope review
- Performance tuning: before/after metrics using the same method
- Deployment or CI change: dry-run, CI validation, build artifact check, rollback clarity
- Documentation: links, commands, examples, and referenced paths
- Dependency upgrade: test, build, runtime smoke check, and changelog risk review
- Security or stability: failure model, regression proof, and residual risk statement

Outputs:

- commands run
- relevant command results
- manual checks performed
- acceptance criteria status
- residual risks

Handoff:

- to `/reflect` when useful learning should be captured
- to `/investigate` if verification fails unexpectedly
- to `/execute` if a small fix is needed and the root cause is clear

### `/reflect`

`/reflect` captures durable learning after work is complete. It must be selective.

Good reflection changes future behavior:

- a recurring project-specific trap
- a verification command that should become standard
- a deployment or environment invariant
- a design principle discovered through failure
- a skill rule that should be sharpened

Bad reflection is noise:

- chronological summaries
- generic lessons
- facts already obvious from the code
- one-off details unlikely to matter again

Outputs:

- concise learning entry
- target artifact to update, if any
- reason the learning is reusable

Handoff:

- update project context, documentation, or skill content only when the learning is durable enough to justify it

## Default Flow

```text
/clarify -> /plan -> /execute -> /verify -> /reflect
      \                         ^
       -> /investigate -> /plan |
```

Common paths:

- Small documentation change: `/clarify -> /execute -> /verify`
- Bug fix: `/investigate -> /execute -> /verify`
- Performance tuning: `/investigate -> /plan -> /execute -> /verify`
- Project structure optimization: `/clarify -> /plan -> /execute -> /verify`
- Deployment optimization: `/clarify -> /plan -> /execute -> /verify`
- Large cross-module work: `/clarify -> /plan -> /execute` with fresh-context subagents, then `/verify -> /reflect`

## Deliverables Implied by This Design

The implementation plan should produce:

- root `SKILL.md` with routing table and behavioral contract
- `ETHOS.md`
- six skill files under `skills/`
- prompt templates only where fresh-context execution or review requires them
- docs for philosophy and installation
- tests or validation checks for skill structure and required sections

The previous eight-skill outline is superseded by this six-skill structure. A future split requires explicit design review and user approval.
