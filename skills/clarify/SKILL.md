---
name: clarify
description: Use when a software engineering task has unclear goals, scope, constraints, acceptance criteria, tradeoffs, or user-facing decisions
---

# clarify

## Purpose

Create shared understanding before planning or execution. The failure this prevents is acting on a task the agent only thinks it understands.

## When to Use

- New features, refactors, project structure work, deployment changes, docs, or developer-experience work with unclear intent.
- Requests with missing acceptance criteria, non-goals, constraints, or user-facing tradeoffs.
- Medium or high-risk work where multiple reasonable approaches exist.
- Any task where the codebase cannot answer a necessary decision.

## When NOT to Use

- A low-risk task already has a clear target and validation path.
- The task is a bug, failing test, performance issue, security issue, or deployment failure that needs evidence first. Use `/investigate`.
- The user is asking for a code review or completion proof. Use `/verify`.

## Risk Gate

| Risk | Clarify behavior |
| --- | --- |
| Low | Inspect context, confirm target and validation path, proceed |
| Medium | Compare options, recommend one, record goal, non-goals, risks, acceptance criteria |
| High | Use full brainstorming: explore context, ask one question at a time, compare approaches, present design, write spec, wait for approval |

## Shared Language

When a task depends on domain terms, read existing `CONTEXT.md`, `CONTEXT-MAP.md`, or ADRs if they exist. Challenge overloaded or conflicting terms, propose precise canonical vocabulary, and cross-check user claims against code or docs when possible.

Treat `CONTEXT.md` as a glossary only: stable domain terms and resolved ambiguities. It is not a spec, scratch pad, implementation note, or decision log.

When the user confirms stable canonical vocabulary or a resolved ambiguity that future agents should reuse, update the project root `CONTEXT.md` before handoff. If `CONTEXT.md` does not exist and the repository needs shared vocabulary, create it using `docs/templates/context-glossary.md`. Do not persist candidate terms, unresolved disagreements, implementation details, task plans, decision rationale, or session summaries.

## Task Handoff

Use `docs/templates/task-handoff.md` when clarification results must survive
context compression, agent handoff, fresh-context execution, or a medium/high
risk `/plan` handoff.

Write the handoff to the project's existing task artifact when one exists. If
there is no project convention and the handoff is needed for the current task,
create or update root `STATE.md`. Keep `STATE.md` temporary task state; do not
turn it into a diary, glossary, decision log, or reusable learning file.

## Workflow

1. Read relevant files, docs, and recent state before asking.
2. State the task type and risk level.
3. Identify goal, non-goals, constraints, and acceptance criteria.
4. Ask only one question at a time when code cannot answer it.
5. Provide a recommended answer with each question.
6. Resolve terminology ambiguities before turning them into requirements.
7. Persist confirmed stable shared language in `CONTEXT.md`, or state why no glossary update is warranted.
8. For medium/high risk, present two or three approaches with tradeoffs and a recommendation.
9. Persist a Task Handoff when the clarified goal, non-goals, constraints, acceptance criteria, open decisions, or next proof must survive outside the conversation.
10. End with either a lightweight target statement or an approved design.

## Question Stop Rule

Keep asking only while an unresolved answer can change the goal, non-goals, constraints, acceptance criteria, shared language, or a high-impact user decision.

Stop asking and move to the next workflow when the remaining choices are mechanical, reversible, taste-level decisions that can be batched, or facts the codebase and docs can answer.

## User Input Channel

Use the strongest interactive channel available in the current runtime: a native user-input action when one exists, otherwise a normal conversational question. Do not hard-code platform-specific tool names into this skill contract.

If the runtime cannot surface interactive input, stop with the single blocking question and a recommended answer instead of guessing.

## Hard Rules

- Do not implement before the target and validation path are clear.
- Do not ask questions the codebase can answer.
- Do not ask multiple questions at once.
- Do not hide high-impact decisions inside implementation details.
- Do not create a formal spec for low-risk work unless risk increases.
- Do not treat fuzzy domain language as harmless when it affects behavior, naming, or acceptance criteria.
- Do not leave confirmed stable shared language only in the conversation.
- Do not write unconfirmed or speculative vocabulary into `CONTEXT.md`.
- Do not put task state, acceptance criteria, plans, or decision rationale into `CONTEXT.md`; use the Task Handoff path when that state must persist.

## Rationalization Prevention

| Excuse | Reality |
| --- | --- |
| "This is obvious" | Obvious to the agent is not shared understanding |
| "I can decide later" | Hidden decisions become scope drift |
| "Asking slows us down" | One precise question is cheaper than rework |
| "I read enough" | If acceptance criteria are missing, understanding is incomplete |

## Outputs

- Task type and risk level.
- Goal and non-goals.
- Constraints and acceptance criteria.
- Shared-language terms or ambiguities captured in `CONTEXT.md`, or the reason no glossary update was needed.
- Open decisions classified by importance.
- Task Handoff artifact path when one was needed, or the reason no handoff artifact was needed.
- Approved design or lightweight target statement.

## Handoff

- Use `/plan` for medium/high-risk work or tasks needing decomposition.
- Use `/execute` for low-risk work with clear validation.
- Use `/investigate` when evidence is required before design.
