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
- GSD provides context-rot prevention, fresh-context execution, persistent artifacts for cross-session continuity, and the need to promote verified experience into reusable rules.

The system intentionally avoids the heavier parts of the references:

- no large role catalog
- no mandatory browser dependency
- no telemetry layer
- no large shared preamble template
- no top-level skill for every sub-process
- no workflow ceremony for tasks whose risk does not justify it

## Source Failure Model

The source frameworks should not be copied by feature list. Their real value is the failure model each one exposes.

| Source | Core failure model | qingshan adaptation |
| --- | --- | --- |
| gstack | AI steals user decisions by either asking about trivial choices or silently deciding important ones | `/plan` and the root router must grade decisions as Mechanical, Taste, or User Challenge |
| Superpowers | Agents invent excuses to skip discipline when work feels simple, urgent, or obvious | The root `SKILL.md` must enforce routing before action; every workflow skill must include hard rules, rationalization prevention, and pressure tests |
| GSD | Long sessions silently degrade reasoning quality, and useful experience is lost or over-generalized between projects | `/execute` must include a Context Gate, and `/reflect` must include a Memory Promotion Gate |
| Grill Me | The agent and user often believe they share understanding before they actually do | `/clarify` must produce shared understanding before downstream planning or execution |

This turns the design from "a smaller bundle of four frameworks" into a failure-driven methodology:

- consensus layer: force out what is actually being done
- orchestration layer: protect decisions and sequence work
- discipline layer: prevent shortcuts
- context layer: preserve reasoning quality over time

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

This keeps the top-level vocabulary small while preserving the important disciplines. The skills are organized by failure mode, not by source framework.

The root `SKILL.md` is not a seventh workflow skill. It is the session-bootstrap enforcement layer that makes the six workflows fire: on each software engineering request, it classifies the request shape, selects the lightest safe workflow, and blocks common rationalizations for skipping the methodology wholesale.

## Task Taxonomy

The root skill should run before task work, route by task type, then select the necessary workflow weight.

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

The root `SKILL.md` has a different job from the six workflow skills. It should include routing, risk-weighted entry, and a meta rationalization table for bypassing the whole methodology. It should not duplicate each workflow's detailed procedure.

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

Large work should be decomposed. Complex execution should use fresh context or subagents. Critical state and decisions should be written to artifacts when they will matter across sessions. Verified experience should be promoted only when it is reusable, conditional, and unlikely to pollute future work.

## Context and Learning Lifecycle

GSD's `STATE.md` and `CONTEXT.md` solve project-local continuity, but qingshan-skills also needs cross-project learning. The system should treat context as a promotion pipeline, not as one unbounded memory bucket.

```text
task state -> project context -> project learning -> global memory -> skill rule
```

Each layer has a different purpose:

| Layer | Purpose | Typical artifact |
| --- | --- | --- |
| Task state | Preserve temporary progress for a long task | task artifact, plan, or `STATE.md` only when needed |
| Project context | Preserve stable repo-specific facts and constraints | existing `AGENTS.md` / `CLAUDE.md` section, or `CONTEXT.md` when the project needs one |
| Project learning | Preserve lessons that matter inside this repo but are not yet safely global | `LEARNINGS.md` or an existing project retrospective document |
| Global memory | Preserve conditional, cross-project engineering lessons | user-level memory such as `~/.qingshan-skills/memory/learnings.jsonl` |
| Skill rule | Turn repeated or high-risk lessons into default behavior | the relevant `SKILL.md` body |

Do not create every artifact by default. Low-risk work usually needs none of them. Use the smallest existing artifact that preserves the future behavior.

### Memory Promotion Gate

`/reflect` is the only workflow that may promote experience between layers. Other skills may propose candidate lessons, but they should not directly write durable memory.

Before writing durable memory, the agent must answer:

1. Is this only temporary task state?
2. Is this a stable project fact or constraint?
3. Is this a project-specific lesson that may recur in the same repo?
4. Can this be generalized across projects with a clear trigger condition?
5. Could the lesson be wrong in a different environment?
6. Is there evidence, verification output, or repeated experience behind it?
7. Is this high-frequency or high-risk enough to update a skill rule instead of leaving it in memory?

Global memory entries must be conditional rules, not chronological summaries. Preferred shape:

```json
{
  "type": "technical_pattern",
  "tags": ["electron", "intranet", "auto-update"],
  "trigger": "When designing Electron auto-update for intranet or offline deployments",
  "recommendation": "Use a server-hosted update manifest, package integrity checks, staged rollout, and rollback path.",
  "avoid": ["public update channel assumptions", "updates without rollback", "missing package verification"],
  "evidence": "Derived from a verified intranet deployment constraint.",
  "confidence": "high",
  "status": "active"
}
```

The trigger is mandatory. Without a trigger, the lesson is too vague to reuse safely.

### Context Read Rules

Durable context should reduce context rot, not cause it. Skills should load only the smallest relevant context:

- `/clarify` reads project context and relevant global lessons when they can affect goals, constraints, or hidden decisions.
- `/plan` reads lessons that affect architecture, risk, validation, rollback, or user decision boundaries.
- `/execute` receives only lessons directly relevant to the scoped change.
- Fresh workers receive a compact context excerpt, never a full memory dump.
- `/verify` checks whether relevant lessons were honored and whether new candidate lessons emerged.
- `/reflect` decides whether candidates stay local, become global, or sharpen a skill.

Global memory must not duplicate user-level `AGENTS.md` or `CLAUDE.md` instructions. User instructions are behavioral defaults. User memory is reusable experience. Project context is repository-specific truth. Task state is temporary continuity.

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

Before editing, `/execute` must pass a Context Gate:

- Can the task be completed accurately in the current context?
- Does the task touch multiple modules, runtimes, or ownership boundaries?
- Is the plan long enough that execution details may crowd out the original intent?
- Is the work independent enough to delegate safely?
- Has the conversation been compressed, interrupted, or filled with unrelated exploration?
- Would a fresh worker reduce risk more than it adds coordination cost?

If the answer indicates context risk, `/execute` should use fresh context or subagents. The main session keeps the plan, constraints, and review responsibility; workers receive only the task, relevant context, boundaries, and verification requirements. Fresh context is a reliability tool, not an excuse to fragment simple work.

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

`/reflect` captures durable learning after work is complete. It must be selective. Its main job is not summarization; it is deciding whether verified experience should remain task-local, become project context, become project learning, become global memory, or sharpen a skill rule.

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
- target layer: task state, project context, project learning, global memory, skill rule, or no write
- trigger condition for any global memory
- evidence or reason for confidence
- target artifact to update, if any
- reason the learning is reusable

Handoff:

- update project context, documentation, global memory, or skill content only when the learning passes the Memory Promotion Gate
- keep lessons local when they are repo-specific and cannot be safely generalized
- reject or defer lessons whose trigger is vague, evidence is weak, or risk of wrong generalization is high

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

- root `SKILL.md` as session-bootstrap enforcement skill with routing table, risk-weighted entry, and meta anti-bypass rationalization table
- `ETHOS.md`
- six skill files under `skills/`
- prompt templates only where fresh-context execution or review requires them
- docs for philosophy and installation
- context and memory promotion rules inside `/reflect`, with read rules referenced by `/clarify`, `/plan`, `/execute`, and `/verify`
- structure checks for required skill sections
- pressure tests for agent behavior under realistic failure scenarios

## Skill Pressure Tests

Skills should be tested like code. A useful test starts with a scenario where an agent would naturally take the wrong shortcut, then verifies that the skill prevents it.

Required pressure scenarios:

- Simple task over-processing: a typo or small docs fix should not trigger a heavyweight plan.
- Feature ambiguity: a vague feature request should enter `/clarify` instead of direct implementation.
- User decision theft: an architecture or product trade-off should be classified as Taste or User Challenge, not silently decided.
- Bug guesswork: a bug report should enter `/investigate` and collect evidence before editing.
- Performance guesswork: a performance request should establish a baseline before optimization.
- Context rot: a large cross-module task should trigger the `/execute` Context Gate and consider fresh context.
- Memory pollution: a one-off project fact should not be promoted into global memory without a reusable trigger.
- Wrong generalization: an environment-specific lesson should be rewritten as a conditional rule or kept project-local.
- Skill reinforcement: a repeated or high-risk lesson should be proposed as a skill-rule update instead of staying only in memory.
- Verification shortcut: an agent should not claim completion without command output or task-specific proof.
- Scope creep: an agent should reject unrelated cleanup during a focused change.
- Methodology bypass: an apparently simple, urgent, or obvious task should still enter the lightest applicable workflow instead of skipping the root routing check.

These tests do not need to simulate every runtime. They should verify the methodology's behavioral contract: when the agent is tempted to skip discipline, the skill text pulls it back.

The previous eight-skill outline is superseded by this six-skill structure. A future split requires explicit design review and user approval.
