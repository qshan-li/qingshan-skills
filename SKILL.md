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
3. Set the lightest risk level that still protects the work.
4. Apply the selected workflow before clarifying, investigating, planning, editing, verifying, or claiming completion.

If no workflow skill applies, answer directly. If a workflow skill might apply, route first. Low risk reduces ceremony; it does not bypass routing or hard rules.

## Routing

| Request shape | Entry skill | Reason |
| --- | --- | --- |
| New feature, product change, refactor, project structure work, deployment improvement, documentation workflow | `/clarify` | Goal, scope, constraints, and acceptance criteria must be explicit |
| Bug, failing test, performance issue, deployment failure, security or stability concern | `/investigate` | Evidence must exist before fixes |
| Clarified goal that needs decomposition, sequencing, rollback, or validation strategy | `/plan` | Hidden decisions and scope drift need control |
| Dependency or toolchain upgrade | `/plan` | Blast radius, compatibility impact, and verification paths must be controlled |
| Test-system improvement with unclear coverage gap, flaky signal, or failing behavior | `/investigate` | Improve a real signal instead of manufacturing tests for metrics |
| Planned code, config, docs, or tooling change | `/execute` | Edits must stay scoped and context-safe |
| Code review, PR or diff review, implementation or spec review | `/verify` | Review requests need fresh proof, scope review, and residual-risk reporting |
| Any completion, fixed, passing, optimized, or ready claim | `/verify` | Claims require fresh proof |
| Ship, deploy, publish, PR, merge, release | `/verify` | Release requests need fresh proof, scope review, and rollback or recovery notes before handoff |
| Completed work with reusable learning | `/reflect` | Durable lessons should update future behavior |

## Risk Gate

| Risk | Use |
| --- | --- |
| Low | Lightweight `/clarify -> /execute -> /verify` |
| Medium | `/clarify -> /plan -> /execute -> /verify` |
| High | Full relevant flow, with `/investigate` first when evidence is required |

Risk increases when work is cross-module, irreversible, user-facing, security-sensitive, deployment-related, performance-related, or poorly understood.

Risk controls workflow weight, not whether the methodology applies.

## Decision Grading

| Grade | Handling |
| --- | --- |
| Mechanical | Decide silently using project conventions |
| Taste | Batch and present with a recommendation |
| User Challenge | Stop and ask before proceeding |

Do not steal User Challenge decisions. Architecture direction, product behavior, irreversible data changes, and release risk belong to the user.

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

Record any memory that affects the task in the next handoff, plan, context
manifest, or verification report. Do not dump whole memory files into context
when a matching excerpt or artifact reference is enough.

## Temporary State Lifecycle

`STATE.md`, Task Handoff artifacts, and fresh-context packets are current-task
continuity artifacts, not durable memory. Any workflow that creates or consumes
one must give it a terminal path before the task is finally closed.

`/execute` may dispose of simple completed-task state after local verification
when no downstream handoff or `/reflect` needs it. `/verify` owns the cleanup
gate: it confirms prior cleanup, cleans pending completed-task state before the
final completion claim, or hands the state to `/reflect` only through a
structured reflection handoff when durable promotion must consume it first. If
`/reflect` receives cleanup ownership, it must dispose of the named completed
task state before ending the loop, even when the promotion gate rejects every
durable write.

Never delete unrelated active task state.

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
  no User Challenge decision remains open.

Use soft dependencies to reduce risk without forcing ceremony:

- `/execute` benefits from `/investigate` when the task starts from a bug, incident, performance issue, deployment failure, or security concern.
- `/verify` benefits from `/plan` when acceptance criteria, task boundaries, rollback, or release risk exist.
- `/reflect` benefits from `/verify` because only verified outcomes should become durable learning or durable decisions.

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
| "This is too simple to route." | Simple work still needs the lightest valid route; skip heavyweight planning, not the root check. |
| "The user wants speed, so skip process." | Speed changes workflow weight. It does not remove understanding, scope control, evidence, or verification. |
| "I need to inspect files before choosing." | Choose the entry skill first; that skill tells you how much inspection is justified. |
| "The fix is obvious." | Obvious fixes still need the correct entry: `/investigate` for failures, `/clarify` for ambiguous work, `/execute` for scoped edits. |
| "I'll edit now and verify later." | Planned code, config, docs, or tooling changes enter `/execute` before edits and `/verify` before completion claims. |
| "The user named a downstream skill, so prerequisites do not matter." | Follow explicit user direction, but surface missing upstream facts or decisions before irreversible work. |
| "Hooks or runtime rules will enforce this." | Hooks may harden mechanical checks. The portable enforcement layer is this root skill. |
