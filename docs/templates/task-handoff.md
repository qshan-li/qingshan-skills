# Task Handoff Template

Use when `/clarify` or `/investigate` results must survive context compression,
agent handoff, fresh-context execution, or a handoff into `/plan` or `/execute`.
Keep the artifact current-task scoped.

## Task Type And Risk

<Feature, refactor, docs, bug, performance, deployment, security, or other task
type. Include Low, Medium, or High risk.>

## Goal

<The outcome the next workflow should preserve.> — provenance: `user-supplied` |
`repository-derived` with cited evidence | `agent-proposed`

## Non-Goals

- <Out-of-scope item> — provenance: `user-supplied` | `repository-derived` with
  cited evidence | `agent-proposed`

## Constraints

- <Constraint or protected boundary> — provenance: `user-supplied` |
  `repository-derived` with cited evidence | `agent-proposed`

## Acceptance Criteria

- <Observable condition that proves the task is done. Prefer deterministic
  checks, thresholds, or artifacts over subjective judgment. Label each item
  `user-supplied`, `repository-derived` with cited evidence, or
  `agent-proposed`.>

## Loop Contract (When Required)

<Required only for recurring, automation-backed, fresh-context, multi-agent,
migration, or broad repetitive work. Use `not applicable` for ordinary finite
engineering work.>

- Trigger:
- Stop condition:
- Proof:
- Usage boundary:

## Shared Language Status

<CONTEXT.md updated, no glossary update needed, or unresolved terminology.>

## Referenced Memory

- `CONTEXT.md` or glossary term: <trigger and excerpt, or not used>
- `LEARNINGS.md` or project retrospective: <trigger and excerpt, or not used>
- ADR, `DECISIONS.md`, or decision artifact: <trigger and excerpt, or not used>
- Global memory excerpt: <trigger and excerpt, or not used>

Reference only memory that affects this task. Do not paste whole memory files
when a targeted excerpt or artifact path is enough.

## Investigation Evidence

- Symptom:
- Expected behavior:
- Reproduction or observation method:
- Feedback loop quality and limits:
- Facts collected:
- Narrowed failing surface:
- Root-cause hypotheses and confidence:
- Recommended fix path:

## Uncertainty Status (When Needed)

Record only items that must cross a workflow boundary because they remain open
or deferred, were accepted as residual, or rely on evidence that may become
stale. Resolved items stay temporary unless downstream work needs their evidence.

- Item:
- Kind: <open fact | blind-spot hypothesis | residual uncertainty | open decision reference>
- Impact: <goal, acceptance criteria, protected boundary, implementation, validation, or residual risk>
- Next action: <read-only probe, decision brief, investigation, scheduled plan step, or verification>
- Status: <open | resolved | deferred | accepted-residual | stale>
- Evidence: <path, symbol, command output, approval reference, or none yet>

Open decisions use `Open Decisions` and their Decision Brief as the authoritative
approval state. If referenced here, do not duplicate or reinterpret that status.

## Open Decisions

- <Decision, Mechanical | Taste | User Challenge, open | approved | changed,
  selected option, owner, and approval evidence>

Taste decisions must be approved before `/execute`. User Challenge decisions
stop immediately. A workflow invocation alone is not approval.

## Next Workflow

`/plan` | `/execute` | `/investigate` | `/verify`

## Required Proof

- <Command, check, artifact, or manual proof>

## Lifecycle

<Temporary current-task state. `/verify` owns the cleanup gate: delete, trim,
close, or name the project convention that keeps this artifact after the current
task is closed.>

## Stop Conditions

- Stop if acceptance criteria or required evidence is missing, a Taste decision
  is open or changed, or a User Challenge decision is unresolved.
- Stop if the next workflow would need files, referenced memory, or context not named here.
- Stop if an open or stale uncertainty can change a dependent task and its next
  action is not scheduled before that task.
- Stop if a required loop contract lacks a trigger, stop condition, proof, or
  usage boundary.
