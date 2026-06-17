---
name: reflect
description: Use when completed software engineering work reveals reusable lessons, project invariants, verification commands, or skill improvements
---

# reflect

## Purpose

Capture durable learning without polluting the knowledge base. The failure this prevents is repeating avoidable mistakes.

## Direct Invocation

Direct invocation must still honor root `SKILL.md` and `ETHOS.md`. Apply the
root routing assumptions and shared non-negotiables before continuing; direct
invocation changes the entry point, not the hard rules.

## When to Use

- Work revealed a recurring trap, invariant, verification command, or project-specific rule.
- A skill rule should be sharpened because the agent found a loophole.
- A deployment, performance, or debugging lesson will affect future work.
- `/verify` assigned cleanup ownership in a structured Reflection Handoff.
- The user asks for retrospective learning.

## When NOT to Use

- The work produced no reusable lesson and no `/verify` handoff assigned
  temporary-state disposal.
- The note would be a chronological summary.
- The fact is already obvious from the code.
- Verification has not passed. Use `/verify`.

## Risk Gate

| Risk | Reflection behavior |
| --- | --- |
| Low | Usually skip unless a reusable rule emerged |
| Medium | Capture concise project or verification learning when it will recur |
| High | Update the appropriate artifact when the lesson changes future behavior |

## Memory Promotion Gate

Promote learning only as far as the evidence supports:

- Task state: temporary progress for the current task.
- Project context: stable repo-specific facts or commands.
- Project learning: recurring project pattern or pitfall.
- Global memory: repeated cross-project lesson with clear trigger conditions.
- Skill rule: verified behavior change that should guide future agents.

Do not promote one-off project facts into global rules.

## Promotion Artifact Map

Choose the smallest existing artifact that preserves the future behavior:

| Layer | Use for | Target artifact |
| --- | --- | --- |
| Task state | Temporary progress for the current task | Existing task artifact, plan, or root `STATE.md` only when needed |
| Project context | Stable repo-specific facts or commands | Existing `AGENTS.md` or `CLAUDE.md` section, or `CONTEXT.md` only for glossary terms |
| Project learning | Recurring project pattern or pitfall | `LEARNINGS.md` or an existing project retrospective document |
| Global memory | Repeated cross-project lesson with clear trigger conditions | `~/.qingshan-skills/memory/learnings.jsonl` |
| Skill rule | Verified behavior change that should guide future agents | The relevant `skills/<name>/SKILL.md` body |
| Durable decision | Settled architecture, scope, tool, vendor, release, or reversal choice | Existing ADR or decision artifact, or root `DECISIONS.md` when no convention exists |

Do not create every artifact by default. Use `STATE.md` only for temporary task
continuity, `CONTEXT.md` only for glossary entries, and durable decision
artifacts only for decisions that pass the three-gate rule.

## Consumption Contract

Every promoted artifact must have a future reader and trigger:

| Artifact | Reader | Trigger |
| --- | --- | --- |
| `skills/<name>/SKILL.md` | The runtime or agent when the skill is invoked | The task routes to that skill |
| Task artifact or `STATE.md` | `/plan`, `/execute`, and `/verify` | Current task state must survive context compression, handoff, fresh context, or multi-step execution |
| `CONTEXT.md` | `/clarify`, `/plan`, `/execute`, `/verify`, and fresh-context packets | Terminology, naming, domain boundaries, or shared language can affect the task |
| `LEARNINGS.md` or project retrospective | `/plan`, `/execute`, and `/verify` | The task touches a recurring project pitfall, project convention, verification command, or known trap |
| ADRs, `DECISIONS.md`, or decision artifact | `/plan` and `/verify` | Architecture, toolchain, release, data, scope, or reversal choices can affect the work |
| `~/.qingshan-skills/memory/learnings.jsonl` | Root bootstrap or the active workflow | A global memory entry trigger matches the task type, stack, risk, artifact, or failure mode |

Do not write a lesson if no future reader and retrieval trigger can be stated.
When a task depends on memory, record the referenced memory in the Task Handoff,
plan, context manifest, or verification report rather than relying on raw
conversation history.

When `/verify` creates a structured Reflection Handoff, read its candidate type,
evidence source, future behavior, temporary state needed, and cleanup owner
before using raw conversation history. If the Memory Promotion Gate rejects the
candidate, still dispose of any completed task state whose cleanup owner is
`/reflect`.

Global memory entries must include at least: `trigger`, `lesson`, `scope`,
`evidence`, `date`, and `source`. Without a clear trigger, keep the learning
project-local or do not persist it.

Project learning entries should state a trigger, scope, evidence, date, and
invalidation condition when the target artifact supports that structure. When an
existing learning no longer applies, supersede or mark it stale instead of
appending a contradictory lesson.

## Temporary State Disposal

When reflection receives cleanup ownership or reads root `STATE.md` as evidence
for promotion, consume only the details needed to evaluate the durable lesson,
decision, glossary entry, or skill rule. Before ending the loop, dispose of the
completed task state: delete root `STATE.md` if it contains only that completed
task, or trim only the completed task's section when unrelated active task state
remains.

Do this even when reflection writes no durable artifact because the candidate
fails the promotion gate. Do not preserve `STATE.md` as a diary, retrospective,
or evidence archive after the evidence has been evaluated. Do not delete
unrelated active task state.

## Session History Retrieval

Raw session history can be used as a read-only retrieval source when it helps
recover a prior decision, constraint, verification command, or repeated lesson.
Retrieval does not decide the write-back destination. Any lesson, decision,
glossary entry, or skill rule still must pass the Memory Promotion Gate.

## Durable Decision Log

Treat durable decisions separately from reusable lessons.

A durable decision is a settled architecture, scope, tool, vendor, release, or reversal choice that future sessions should not silently re-litigate. Record:

- decision
- date
- scope
- rationale
- alternatives rejected
- reversal conditions

When a durable decision reverses an earlier one, supersede the earlier decision
instead of creating contradictory memory. When an existing decision's reversal
conditions now apply, mark it stale or superseded before relying on a replacement
decision.

Use this section when reflection discovers a durable decision that was not already recorded during planning. `/plan` records user-approved durable decisions before execution when they pass the three-gate rule.

## Glossary and ADR Gate

Capture glossary entries only for stable domain terms or resolved ambiguities that future agents will reuse. Glossary entries must not include implementation details, task plans, scratch notes, or decision rationale.

`/clarify` owns persistence of user-confirmed shared language during clarification. Use reflection for glossary entries only when verified work reveals a stable term or ambiguity that was not resolved earlier.

Record an ADR or durable decision only when all three are true:

- the decision is hard to reverse
- the choice would be surprising without context
- the outcome came from a real trade-off

## Workflow

1. Identify whether `/verify` provided a structured Reflection Handoff and whether cleanup ownership is assigned to `/reflect`.
2. Identify whether the outcome is a reusable lesson, a durable decision, both, or neither.
3. For a reusable lesson, state the future trigger and apply the Memory Promotion Gate.
4. For a durable decision, record the decision, scope, rationale, rejected alternatives, and reversal conditions.
5. For glossary entries or ADRs, apply the Glossary and ADR Gate.
6. Choose the smallest durable artifact from the Promotion Artifact Map.
7. Confirm the future reader and retrieval trigger from the Consumption Contract.
8. Avoid duplicating facts already present in code or docs.
9. Record the lesson or decision concisely, or state why no durable artifact was written.
10. Dispose of consumed root `STATE.md` task state when reflection used it or cleanup ownership was assigned to `/reflect`.
11. Verify the artifact still reads as a rule, glossary entry, or decision record, not a diary.

## Hard Rules

- Do not write session journals.
- Do not automatically promote raw session history into specs, journals, memory, or skill rules.
- Do not store one-off observations.
- Do not update skills without a concrete behavior to change.
- Do not persist learning without a future reader and retrieval trigger.
- Do not write global memory without `trigger`, `lesson`, `scope`, `evidence`, `date`, and `source`.
- Do not let reflection replace verification.
- Do not create knowledge-base noise.
- Do not mix durable decisions with reusable lessons.
- Do not create contradictory decision records; supersede reversals explicitly.
- Do not put implementation details or plans into glossary entries.
- Do not create ADRs for reversible, unsurprising, or no-trade-off choices.
- Do not leave consumed root `STATE.md` task state behind after durable promotion.
- Do not skip temporary-state disposal just because the promotion gate rejected the durable memory candidate.

## Rationalization Prevention

| Excuse | Reality |
| --- | --- |
| "More notes are safer" | Noise hides useful rules |
| "This might matter someday" | Someday is not a trigger |
| "Summaries help memory" | Durable rules help future behavior |
| "The skill should mention everything" | Skills should stay focused and searchable |
| "This decision is also a lesson" | Decisions preserve chosen direction; lessons preserve reusable behavior |
| "This term might be useful" | Glossary entries need stable reuse, not possible future relevance |

## Outputs

- Reusable lesson.
- Future trigger.
- Future reader and consumption artifact.
- Retrieval source used, if raw session history affected the reflection.
- Glossary entry when stable shared language was captured.
- Durable Decision Log entry when a durable decision was made.
- Artifact updated or reason no update was needed.
- Reflection Handoff consumed when `/verify` provided one.
- Temporary state disposal status when root `STATE.md` was consumed.
- Any skill improvement required.

## Handoff

- Update project context, docs, or skills only when the lesson is reusable.
- End the loop when there is no durable learning to capture.
