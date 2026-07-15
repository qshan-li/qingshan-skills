---
name: clarify
description: Use when a software engineering task has unclear goals, scope, constraints, acceptance criteria, tradeoffs, or user-facing decisions
---

# clarify

## Purpose

Create shared understanding before planning or execution. The failure this prevents is acting on a task the agent only thinks it understands.

## Direct Invocation

Direct invocation must still honor root `SKILL.md` and `ETHOS.md`. Apply the
root routing assumptions and shared non-negotiables before continuing; direct
invocation changes the entry point, not the hard rules.

Before continuing from direct invocation, state the entry reason, risk level,
required upstream facts, and fallback route. If the prerequisites for this skill
are missing, use the fallback route before irreversible action.

## When to Use

- New features, refactors, project structure work, deployment changes, docs, or developer-experience work with unclear intent.
- Requests to read or understand a new project, directory, or module and produce
  a structured map, guided reading path, or unknowns.
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

When a task depends on domain terms, read existing `CONTEXT.md` or ADRs if they exist. Challenge overloaded or conflicting terms, propose precise canonical vocabulary, and cross-check user claims against code or docs when possible.

Read `CONTEXT.md` when terminology, naming, domain boundaries, or user wording
can change the goal, acceptance criteria, file ownership, or fresh-context
manifest. Do not read it for unrelated tasks just because it exists.

Treat `CONTEXT.md` as a glossary only: stable domain terms and resolved ambiguities. It is not a spec, scratch pad, implementation note, or decision log.

When the user confirms stable canonical vocabulary or a resolved ambiguity that future agents should reuse, update the project root `CONTEXT.md` before handoff. If `CONTEXT.md` does not exist and the repository needs shared vocabulary, create it using `docs/templates/context-glossary.md`. Do not persist candidate terms, unresolved disagreements, implementation details, task plans, decision rationale, or session summaries.

## Unknowns Pass

Run an Unknowns Pass for medium/high-risk work, unfamiliar programming
languages, frameworks, build systems, business domains, or user-visible behavior
where the user may only know the right answer after seeing an option.

Separate the result into:

- Known facts: evidence anchored in the request, code, docs, tests, or durable
  context.
- Known unknowns: missing facts or decisions that can be named now.
- Likely unknown unknowns: unfamiliar stack conventions, hidden lifecycle hooks,
  generated files, business invariants, external-service contracts, implicit
  permissions, or product behavior that the current context may not reveal.
- Discovery probes: the smallest read-only inspection, spike, prototype,
  question, or smoke check that can expose the risk before implementation.

Ask the user only when a probe cannot answer the question and the answer can
change the goal, acceptance criteria, protected boundaries, validation path, or
a User Challenge decision. Route to `/plan` when the probes affect sequencing,
risk, rollout, or decision grading; route to `/investigate` when the missing fact
is failure evidence or root cause.

## Project/Module Orientation

Use Project/Module Orientation when the user asks `/clarify` to read a project,
directory, or module and return a structured map and unknowns. The goal is a
teaching graph in prose: explain how the scoped parts fit together and in what
order to read them, not to impress with graph complexity.

First bound the scope. If the requested scope is too broad for the current
context, choose the smallest useful module slice and state what remains unread.
Read only evidence that helps map that scope: README or docs, package and build
files, route or command registries, entry points, nearby implementations, tests,
fixtures, generated-code markers, configuration, and external-service contracts.

Separate facts from interpretation:

- Evidence-backed facts: paths, symbols, imports, calls, registrations,
  configuration, tests, docs, and observed relationships.
- Inferences: module purpose, architectural layer, business meaning, likely
  ownership, hidden rule candidates, and recommended reading order.

Return a compact orientation with:

- Scope: included and excluded paths or modules.
- Evidence read: files, commands, docs, or indexes inspected.
- Module purpose: what problem this scope appears to solve.
- Structural map: nodes, edges, and layers. Nodes can be files, functions,
  classes, commands, routes, configs, tests, docs, or external services. Edges
  can be imports, calls, configures, triggers, owns data, tested by, documents,
  or depends on.
- Domain map: business domain, flows, steps, invariants, permissions, external
  contracts, and hidden rule candidates when the module has domain behavior.
- Guided tour: the recommended reading order and why each stop matters.
- Unknowns: known unknowns, likely unknown unknowns, and the smallest discovery
  probes that would resolve them.
- Next questions and next route: continue `/clarify`, move to `/plan`, route to
  `/investigate`, or proceed to `/execute` only when a scoped change is clear.

Do not create a new top-level command, persistent graph file, dashboard,
whole-repository summary, or multi-agent scan by default. Those are product
features, not the lightweight `/clarify` orientation path.

## Task Handoff

Use `docs/templates/task-handoff.md` when clarification results must survive
context compression, agent handoff, fresh-context execution, or a medium/high
risk `/plan` handoff.

Write the handoff to the project's existing task artifact when one exists. If
there is no project convention and the handoff is needed for the current task,
create or update root `STATE.md`. Keep `STATE.md` temporary task state; do not
turn it into a diary, glossary, decision log, or reusable learning file.

## Taste Decision Handoff

Do not interrupt the user for each reversible Taste decision. Collect them with
recommendations and pass them to `/plan` as open Decision Briefs. When a
low-risk path goes directly from `/clarify` to `/execute`, `/clarify` owns the
single Taste Approval Gate and must record the selected options and approval
evidence before handoff.

A direct `/execute` invocation does not resolve open Taste decisions. If a
clarified recommendation changes materially before execution, mark it changed
and require approval again.

## Acceptance Package Provenance

Label the goal, each acceptance criterion, success definition, non-goal, and
protected boundary with one provenance:

- `user-supplied`: stated by the user in the request or an explicit reply
- `repository-derived`: taken from code, tests, docs, or durable project
  artifacts with a cited path or symbol
- `agent-proposed`: invented or inferred by the agent without being stated by the
  user and without a citable repository source

Only a claim labeled `repository-derived` that cannot cite a path or symbol is
downgraded to `agent-proposed`. User-supplied wording stays `user-supplied`
even when it has no repository citation.
Stop for explicit confirmation before `/plan` or `/execute` when an
`agent-proposed` goal, acceptance criterion, success definition, non-goal, or
protected boundary changes outcome, scope, user-visible behavior, or success
definition. User-supplied and properly cited repository-derived items do not
require a confirmation stop.

## Workflow

1. Read relevant files, docs, and recent state before asking.
2. Select mode: `goal-clarify` or `orientation`. Orientation requests take the
   Project/Module Orientation branch and must not invent implementation
   acceptance criteria.
3. State the task type and risk level using root Risk Classification Floors.
4. For orientation mode, run Project/Module Orientation and stop with a
   structured map, unknowns, and next route.
5. For goal-clarify mode, identify goal, non-goals, constraints, and acceptance
   criteria with provenance labels on the full acceptance package, including goal.
6. Run the Unknowns Pass when risk, unfamiliarity, or user-visible uncertainty
   makes hidden assumptions likely.
7. Ask only one question at a time when code cannot answer it.
8. Provide a recommended answer with each question.
9. Resolve terminology ambiguities before turning them into requirements.
10. Persist confirmed stable shared language in `CONTEXT.md`, or state why no glossary update is warranted.
11. For medium/high risk, present two or three approaches with tradeoffs and a recommendation.
12. Stop for confirmation when an agent-proposed goal, acceptance criterion,
    non-goal, success definition, or protected boundary changes outcome, scope,
    or user-visible behavior.
13. Pass Taste decisions to `/plan` as open Decision Briefs, or run the single Taste Approval Gate before a direct `/execute` handoff.
14. Persist a Task Handoff when the clarified goal, non-goals, constraints, acceptance criteria, provenance, referenced memory, decision approval status, unknowns, discovery probes, or next proof must survive outside the conversation. For low-risk direct `/execute`, a lightweight target with Referenced Memory is enough.
15. End with either a lightweight target statement, a Project/Module Orientation, or an approved design.

## Question Stop Rule

Keep asking only while an unresolved answer can change the goal, non-goals, constraints, acceptance criteria, shared language, or a high-impact user decision.

Stop asking one question at a time when the remaining choices are mechanical,
reversible Taste decisions that can be batched, or facts the codebase and docs
can answer. Batching postpones Taste approval to the single approval gate; it
does not authorize execution or discard the decisions.

## User Input Channel

Use the strongest interactive channel available in the current runtime: a native user-input action when one exists, otherwise a normal conversational question. Do not hard-code platform-specific tool names into this skill contract.

If the runtime cannot surface interactive input, stop with the single blocking question and a recommended answer instead of guessing.

## Hard Rules

- Do not implement before the target and validation path are clear.
- Do not ask questions the codebase can answer.
- Do not ask multiple questions at once.
- Do not hide high-impact decisions inside implementation details.
- Do not continue on an agent-proposed goal, acceptance criterion, non-goal,
  success definition, or protected boundary that changes outcome, scope, or
  user-visible behavior without explicit confirmation.
- Do not label agent-invented criteria as repository-derived without a cited path
  or symbol.
- Do not downgrade user-supplied criteria to agent-proposed for lack of a
  repository citation.
- Do not let batched Taste decisions disappear before explicit approval.
- Do not create a formal spec for low-risk work unless risk increases.
- Do not run goal-clarify outputs for an orientation-mode request.
- Do not treat fuzzy domain language as harmless when it affects behavior, naming, or acceptance criteria.
- Do not treat unfamiliar languages, frameworks, build systems, or business
  domains as normal context when an Unknowns Pass would expose hidden risk.
- Do not invent a new top-level command for project or module orientation.
- Do not present inferred purpose, layer, ownership, or business meaning as fact.
- Do not replace scoped orientation with an unbounded whole-repository summary.
- Do not create persistent graph files, dashboards, or multi-agent scans unless
  the user explicitly asks for that product surface.
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
| "I inferred the AC from context, so continue" | Agent-proposed goals or success criteria that change outcome or behavior need confirmation |
| "Call it repository-derived" | Repository-derived requires a cited path or symbol |
| "I'll discover the stack while coding" | Unknowns should be exposed with cheap probes before edits create momentum |
| "A directory tree is enough" | Orientation needs relationships, layers, flows, and a guided reading path |
| "The graph should be generated and saved" | The lightweight path teaches the scoped module without adding product machinery |

## Outputs

### Always

- Mode: goal-clarify or orientation.
- Task type and risk level.
- Goal and non-goals with provenance, or the scoped orientation outcome.
- Constraints and acceptance criteria with provenance, or the evidence boundary for orientation.
- Open decisions classified by importance.
- Taste approval owner, status, selected options, and approval evidence when applicable.
- Approved design, lightweight target statement, or Project/Module Orientation.

### When Applicable

- Project/Module Orientation when requested, including scope, evidence read,
  structural map, domain map, guided tour, unknowns, next questions, and next
  route.
- Unknowns Pass result, or why no Unknowns Pass was needed.
- Shared-language terms or ambiguities captured in `CONTEXT.md`, or the reason no glossary update was needed.
- Referenced memory used, or the reason no memory retrieval was needed.
- Task Handoff artifact path when one was needed, or the reason no handoff artifact was needed.

## Handoff

Apply root `Workflow Continuation`. Continue to the appropriate next workflow
when the original request authorizes the complete outcome, no open Taste
decision would cross into execution, and no other stop condition applies;
otherwise return control with the recommended next route.

Apply root `Workflow Handoff Selection` when returning control. Use only the
valid routes below as options, with the recommended route first.

Recommended next steps for the user:

- `/plan` for medium/high-risk work or tasks needing decomposition.
- `/execute` for low-risk work with clear validation.
- `/investigate` when evidence is required before design.
