---
name: qingshan-skills
description: Use when coordinating software engineering work through qingshan-skills, routing tasks by risk, evidence, scope, and completion proof
---

# qingshan-skills

## Purpose

Act as the session bootstrap for qingshan-skills: route software engineering work through the smallest workflow that can still protect correctness, user decisions, and verification quality.

Read `ETHOS.md` before applying any core skill. Its non-negotiables override convenience.

## Bootstrap Enforcement

Apply this root skill before responding to or acting on any software engineering request.

Respond in the same natural language the user is using in the current conversation, unless they explicitly request another language. This governs output, not source: skill documents stay English by convention; replies follow the user.

1. Classify the request shape.
2. Select the entry skill from Routing.
3. Set risk using Risk Classification Floors: the minimum level that still
   protects the work, never below a matching floor.
4. Name the loop contract when work is recurring, automation-backed,
   fresh-context, multi-agent, broad, or repetitive.
5. Apply the selected workflow before clarifying, investigating, planning, editing, verifying, or claiming completion.

If no workflow skill applies, answer directly. If a workflow skill might apply, route first. Low risk reduces ceremony; it does not bypass routing, floors, or hard rules.

## Loop Contract

Treat recurring, automation-backed, fresh-context, multi-agent, migration, and
broad repetitive work as a bounded loop. Before starting one, name the lightest
contract that prevents drift:

- trigger: what starts this loop now
- stop condition: what ends it, including the maximum turn, attempt, interval,
  or slice boundary when one is needed
- proof: the command, check, artifact, or observation that decides whether the
  stop condition is met
- usage boundary: what limits token, time, agent, model, or external-system
  cost

Ordinary finite engineering work does not need a separate Loop Contract. Its
goal, acceptance criteria, boundaries, and required proof already define the
stop condition. When a Loop Contract is required, preserve it in the plan, Task
Handoff, fresh-context packet, or verification report. Prefer deterministic
proof over subjective judgment.

## Decision Approval Gate

Mechanical decisions do not need approval. Resolve them from project
conventions without interrupting the user.

Batch Taste decisions into Decision Briefs and stop once before execution for
explicit approval. The user may approve all recommendations, select named
alternatives, or explicitly delegate the listed Taste decisions. A general
request to complete the task, silence, lack of objection, or a workflow
invocation alone is not approval. A direct `/execute` invocation does not approve open Taste decisions.

Preserve the selected option and approval evidence in the plan or Task Handoff.
If the recommendation, alternatives, scope or coverage difference, or
reversibility changes materially, mark the decision changed and require
approval again.

User Challenge decisions stop immediately for explicit approval instead of
waiting for the Taste batch. Architecture direction, product behavior, public
contracts, decision-rights policy, irreversible data changes, and release risk
normally belong here.

## Workflow Continuation

Continue across a workflow handoff when the original request asks for the complete outcome,
acceptance criteria and boundaries are user-supplied, repository-derived with
cited evidence, or already user-confirmed, risk is controlled, the next workflow
stays inside the approved scope, and no open Taste or User Challenge decision remains.

Stop and return control to the user when:

- the user invoked only the current workflow stage
- a Taste decision is open or changed and needs batch approval
- a User Challenge decision needs immediate explicit approval
- required evidence, authority, acceptance criteria, or context is missing
- an agent-proposed goal, acceptance criterion, non-goal, success definition, or
  protected boundary that changes outcome, scope, or user-visible behavior still
  needs explicit confirmation
- the next workflow would expand scope, ownership, external-state impact, or
  release exposure
- the current workflow reports a blocker or an unresolved high-risk concern

Approved Taste decisions do not cause another stop unless they change
materially. Mechanical decisions never require approval. Workflow continuation
preserves the original task boundary; it does not authorize unrelated work or
release actions.

## Routing

| Request shape | Entry skill | Reason |
| --- | --- | --- |
| New feature, product change, refactor, project structure work, deployment improvement, documentation workflow | `/clarify` | Goal, scope, constraints, and acceptance criteria must be explicit |
| Read or understand a new project, directory, or module; produce a structured map and unknowns | `/clarify` | Shared context must be built before decisions, plans, edits, or investigations |
| Bug, failing test, performance issue, deployment failure, security or stability concern | `/investigate` | Evidence must exist before fixes |
| Clarified goal that needs decomposition, sequencing, rollback, or validation strategy | `/plan` | Hidden decisions and scope drift need control |
| Dependency or toolchain upgrade | `/plan` | Blast radius, compatibility impact, and verification paths must be controlled |
| Test-system improvement with unclear coverage gap, flaky signal, or failing behavior | `/investigate` | Improve a real signal instead of manufacturing tests for metrics |
| Planned code, config, docs, or tooling change | `/execute` | Edits must stay scoped and context-safe |
| Code review, PR or diff review, implementation or spec review | `/verify` | Review requests need fresh proof, scope review, and residual-risk reporting |
| Any completion, fixed, passing, optimized, or ready claim | `/verify` | Claims require fresh proof |
| Ship, deploy, publish, PR, merge, release | `/verify` | Release requests need fresh proof, scope review, and rollback or recovery notes before handoff |
| Completed work with reusable learning | `/reflect` | Durable lessons should update future behavior |

## Routing Tie-breakers

When multiple routing rows apply, choose the entry skill by the primary failure
the workflow must prevent:

- Failure, regression, flaky behavior, deployment breakage, security concern, or
  unknown root cause with missing evidence: use `/investigate`.
- Review, readiness, completion, PR, diff, merge, release, publish, ship, or
  handoff claim: use `/verify` before edits or release action.
- Missing goal, acceptance criteria, protected boundaries, validation path, or
  user decision boundary: use `/clarify`.
- Clear goal with sequencing, rollback, blast-radius, dependency, or validation
  strategy risk: use `/plan`.
- Planned change with target, boundaries, acceptance criteria, and proof already
  present: use `/execute`.

If a failure has already been reproduced, the root cause is known with causal
evidence, the fix re-grades to Low, execution inputs are complete, no Taste or
User Challenge decision remains, and no rollout, rollback, or sequencing risk
exists, `/execute` may be the entry skill. Otherwise non-trivial fixes enter
`/plan`. If the tie-breaker still cannot select a route, stop and ask for the
smallest missing fact that changes the route.

## Risk Gate

| Risk | Use |
| --- | --- |
| Low | Lightweight `/clarify -> /execute -> /verify` |
| Medium | `/clarify -> /plan -> /execute -> /verify` |
| High | Full relevant flow, with `/investigate` first when evidence is required |

Risk controls workflow weight, not whether the methodology applies.

## Risk Classification Floors

Choose the minimum sufficient risk level, never below a matching floor. Do not
use open-ended point scoring.

**High floor** when any of these are true:

- security, authentication, authorization, secrets, or compliance exposure
- irreversible data change, migration, or destructive external-state change
- real ship, deploy, publish, merge, or production release action
- architecture direction that redefines system boundaries or primary data flow
- public contract change (API, CLI, schema, or shared type surface)
- unclear product behavior that defines user-visible success for the task
- performance work without an established baseline when optimization is the goal

**Medium floor** when any of these are true and no High floor applies:

- any open or approved User Challenge decision on the task
- reversible data-persistence change that is not irreversible migration
- cross-module or multi-ownership change
- user-facing behavior change with more than one reasonable approach
- dependency, toolchain, CI, or single-service deployment pipeline change
- non-trivial validation, rollback, or sequencing risk
- root cause known but the fix path still needs decomposition

**Low** only when none of the floors above apply and the change is narrow,
reversible, and has a clear validation path.

When new evidence changes scope, failing surface, irreversibility, security or
data or deploy exposure, user-visible behavior, or decision grade, re-state risk
and the next skill before the next handoff. If nothing material changed, keep
the current risk.

## Decision Grading

| Grade | Classify when | Handling |
| --- | --- | --- |
| Mechanical | Project conventions already decide it; reversible; does not change user-visible behavior, public contracts, data durability, architecture direction, or release risk | Decide silently using project conventions |
| Taste | Reversible choice that still affects user-facing behavior, documentation shape, workflow ergonomics, or implementation style where more than one reasonable option exists | Batch with recommendations, then stop once for explicit approval before execution |
| User Challenge | Architecture direction, product behavior, public contracts, decision-rights policy, irreversible data changes, or release risk | Stop immediately and ask before proceeding |

When uncertainty affects user-visible behavior, public contracts, data,
architecture, or release risk, upgrade the grade. Do not upgrade for pure
implementation uncertainty that project conventions already settle.

Do not steal Taste or User Challenge decisions. Taste preserves a low-noise
single approval gate; User Challenge protects high-impact decisions that cannot
wait for batching.

## Memory Retrieval Gate

Use trigger-based retrieval, not automatic memory loading. After classifying the
request shape and risk, read only memory whose trigger matches the current task
type, domain terms, technical stack, artifact path, failure mode, validation
need, release risk, or decision boundary.

Project memory includes `CONTEXT.md`, `LEARNINGS.md`, ADRs, `DECISIONS.md`, and
current task artifacts such as `STATE.md`. Global memory entries such as
`~/.qingshan-skills/memory/learnings.jsonl` may be retrieved by trigger when
they are relevant. A missing global memory file is not a blocker; failing to
read a relevant available memory entry is a workflow gap.

Record any memory that affects the task in a named-memory container the next
workflow may read: plan, Task Handoff, lightweight target statement, context
manifest, or verification report. For low-risk direct `/execute`, write matching
memory into the lightweight target's Referenced Memory section so execution does
not need a formal handoff. Do not dump whole memory files into context when a
matching excerpt or artifact reference is enough.

## Temporary State Lifecycle

`STATE.md`, Task Handoff artifacts, and fresh-context packets are current-task
continuity artifacts, not durable memory. Any workflow that creates or consumes
one must give it a terminal path before the task is finally closed.

`/verify` is the only workflow that deletes or trims temporary task state. Other
workflows report which task-local artifacts were used and leave cleanup pending
for `/verify`. When durable promotion is needed, `/verify` creates a
self-contained Reflection Handoff with the evidence `/reflect` needs, then
cleans the completed temporary state before the final completion claim.

Never delete unrelated active task state.

## Workflow Loop Escape

Track workflow transitions during a task. If the same transition repeats three
times without new evidence, a narrower scope, a completed slice, or a user
decision, stop the loop and report:

- the route chain
- the repeated transition
- the evidence or decision that is missing
- the next smallest unblocker

Do not keep bouncing between skills to avoid naming the blocker.

## Pipeline

```text
/clarify -> /plan -> /execute -> /verify -> /reflect (when durable learning or decisions exist)
      \                         ^
       -> /investigate -> /plan |
```

TDD, review, and ship are embedded disciplines:

- TDD is the default for high-risk code changes inside `/execute`.
- Review is part of `/verify`.
- Ship happens only after `/verify` passes. The requested release action may be
  performed or handed off only when fresh release-path verification is ready and
  no open Taste or User Challenge decision remains.

Use soft dependencies to reduce risk without forcing ceremony:

- `/execute` benefits from `/investigate` when the task starts from a bug, incident, performance issue, deployment failure, or security concern.
- `/verify` benefits from `/plan` when acceptance criteria, task boundaries, rollback, or release risk exist.
- `/reflect` benefits from `/verify` because only verified outcomes should become durable learning or durable decisions.

Runtime loop primitives such as goal, interval, schedule, auto mode, or dynamic
workflows must still enter through this router. The primitive may own the
trigger or repetition, but qingshan-skills owns task boundaries, user decisions,
proof, and completion claims.

## Hard Rules

- Keep changes surgical.
- Prefer existing project patterns.
- Use language-appropriate type safety; in JS/TS projects, use TypeScript for new code.
- Do not introduce `any` in TypeScript code.
- Do not swallow errors or ignore promises.
- Do not claim completion without verification output.
- Do not use fresh context as a substitute for clear task boundaries.

## Rationalization Prevention

| Excuse | Reality |
| --- | --- |
| "This is too simple to route." | Simple work still needs the minimum valid route under Risk Classification Floors; skip heavyweight planning, not the root check. |
| "The user wants speed, so skip process." | Speed changes workflow weight. It does not remove understanding, scope control, evidence, floors, or verification. |
| "I need to inspect files before choosing." | Choose the entry skill first; that skill tells you how much inspection is justified. |
| "The fix is obvious." | Obvious fixes still need the correct entry: `/investigate` for failures, `/clarify` for ambiguous work, `/execute` for scoped edits. |
| "Security is a small patch, so keep Low." | Security, secrets, auth, irreversible data, and real release actions have High floors. |
| "I'll edit now and verify later." | Planned code, config, docs, or tooling changes enter `/execute` before edits and `/verify` before completion claims. |
| "The user named a downstream skill, so prerequisites do not matter." | Follow explicit user direction, but surface missing upstream facts or decisions before irreversible work. |
| "Hooks or runtime rules will enforce this." | Hooks may harden mechanical checks. The portable enforcement layer is this root skill. |
