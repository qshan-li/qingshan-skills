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
- The user asks for retrospective learning.

## When NOT to Use

- The work produced no reusable lesson.
- The note would be a chronological summary.
- The fact is already obvious from the code.
- Verification has not completed. Use `/verify`.

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

When a durable decision reverses an earlier one, supersede the earlier decision instead of creating contradictory memory.

Use this section when reflection discovers a durable decision that was not already recorded during planning. `/plan` records user-approved durable decisions before execution when they pass the three-gate rule.

## Glossary and ADR Gate

Capture glossary entries only for stable domain terms or resolved ambiguities that future agents will reuse. Glossary entries must not include implementation details, task plans, scratch notes, or decision rationale.

`/clarify` owns persistence of user-confirmed shared language during clarification. Use reflection for glossary entries only when verified work reveals a stable term or ambiguity that was not resolved earlier.

Record an ADR or durable decision only when all three are true:

- the decision is hard to reverse
- the choice would be surprising without context
- the outcome came from a real trade-off

## Workflow

1. Identify whether the outcome is a reusable lesson, a durable decision, both, or neither.
2. For a reusable lesson, state the future trigger and apply the Memory Promotion Gate.
3. For a durable decision, record the decision, scope, rationale, rejected alternatives, and reversal conditions.
4. For glossary entries or ADRs, apply the Glossary and ADR Gate.
5. Choose the smallest durable artifact from the Promotion Artifact Map.
6. Avoid duplicating facts already present in code or docs.
7. Record the lesson or decision concisely.
8. Verify the artifact still reads as a rule, glossary entry, or decision record, not a diary.

## Hard Rules

- Do not write session journals.
- Do not automatically promote raw session history into specs, journals, memory, or skill rules.
- Do not store one-off observations.
- Do not update skills without a concrete behavior to change.
- Do not let reflection replace verification.
- Do not create knowledge-base noise.
- Do not mix durable decisions with reusable lessons.
- Do not create contradictory decision records; supersede reversals explicitly.
- Do not put implementation details or plans into glossary entries.
- Do not create ADRs for reversible, unsurprising, or no-trade-off choices.

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
- Retrieval source used, if raw session history affected the reflection.
- Glossary entry when stable shared language was captured.
- Durable Decision Log entry when a durable decision was made.
- Artifact updated or reason no update was needed.
- Any skill improvement required.

## Handoff

- Update project context, docs, or skills only when the lesson is reusable.
- End the loop when there is no durable learning to capture.
