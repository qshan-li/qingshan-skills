---
name: execute
description: Use when implementing a planned software engineering change, refactor, configuration update, documentation change, or fresh-context task
---

# execute

## Purpose

Make scoped changes without drifting from the plan, over-engineering, or letting context quality decay.

## Direct Invocation

Direct invocation must still honor root `SKILL.md` and `ETHOS.md`. Apply the
root routing assumptions and shared non-negotiables before continuing; direct
invocation changes the entry point, not the hard rules.

Before continuing from direct invocation, state the entry reason, risk level,
required upstream facts, and fallback route. If the prerequisites for this skill
are missing, use the fallback route before irreversible action.

## When to Use

- A task has a clear target, boundaries, and validation path.
- Code, configuration, documentation, tooling, or project structure must change.
- A high-risk code change needs TDD.
- A large task may need fresh context or worker prompts.

## When NOT to Use

- The goal, acceptance criteria, or user decision boundary is unclear. Use `/clarify`.
- The task is a bug, performance issue, or failure without evidence. Use `/investigate`.
- The task is already implemented and needs proof. Use `/verify`.

## Risk Gate

| Risk | Execution behavior |
| --- | --- |
| Low | Make the smallest edit and verify locally |
| Medium | Follow the plan step-by-step and verify at meaningful checkpoints |
| High | Run the Context Gate; use TDD for code; use fresh context when risk justifies it |

## TDD Slice Discipline

For required TDD, work one behavior at a time: one failing test, one minimal implementation, then the next behavior. Tests should verify observable behavior through public interfaces, not private implementation details.

Do not write all tests first and then all implementation. That horizontal pattern locks in imagined behavior before feedback from the code exists.

## Handoff and Context Inputs

Before editing, read the scoped input that matches the task risk:

- Low risk: the task statement or lightweight target statement, touched files,
  validation path, protected boundaries, and any Referenced Memory section on
  that target.
- Medium or high risk: the plan plus any Task Handoff artifact produced from
  `docs/templates/task-handoff.md`, or root `STATE.md` when no project task
  artifact exists.

The inputs must name the goal, owned files or touched surface, protected
boundaries, acceptance criteria, required proof, and the status of every Taste
or User Challenge decision. If direct `/execute` entry lacks those inputs,
return to `/clarify` or `/plan` before editing.

A lightweight target is a valid named-memory container. When root bootstrap or
an upstream workflow retrieves matching memory for low-risk work, record it in
the lightweight target's Referenced Memory section using the same field shape as
`docs/templates/task-handoff.md`. Do not invent a formal Task Handoff only to
carry memory for low-risk direct execution.

Do not edit while a Taste decision is `open` or `changed`, or while a User
Challenge decision is unresolved. A direct `/execute` invocation is not approval.
Accept explicit approval already present in the user's request, plan, or Task
Handoff; preserve the selected options during implementation and do not ask
again unless a material decision changes.

Apply only the scoped glossary terms, durable decisions, project lessons, or
trigger-matched global memory named by the plan, Task Handoff, lightweight
target, or context manifest. If execution needs an unlisted lesson, decision,
file, or boundary to proceed safely, stop and return to `/plan` instead of
widening scope.

When context risk justifies a fresh worker, create a packet with
`docs/templates/fresh-context-packet.md` and pair it with `prompts/fresh-worker.md`.
The packet must include owned files, protected files, a context manifest with
access mode for every referenced artifact, stop conditions, and required proof.

## Context Gate Scoring

Count one context-risk signal for each true condition:

- The current context cannot complete the task accurately.
- The task touches multiple modules, runtimes, or ownership boundaries.
- The task uses an unfamiliar language, framework, build system, runtime, or
  business domain whose local conventions have not been inspected.
- The task may depend on generated code, framework lifecycle hooks, hidden
  configuration, external-service contracts, permissions, or business invariants
  not represented in the current context.
- The conversation has been compressed or polluted by unrelated exploration.
- A context manifest would make owned files, reference files, or proof clearer.
- A fresh worker would reduce risk more than it adds coordination cost.

If the current context cannot complete the task accurately, stop editing: gather
the missing context, narrow the slice, or use fresh context. Do not treat that
signal as a one-point concern with mitigation-only continuation.

If two or more of the remaining context-risk signals are present, split the work
into a narrower slice or use fresh context before editing. If exactly one
non-blocking signal is present, record the concern and mitigation before
editing. If no signals are present, proceed locally.

## Unknown-Unknowns Probe

Before editing in an unfamiliar language, framework, build system, runtime, or
business domain, run the smallest read-only probe that can expose local
conventions and hidden constraints. Prefer existing project evidence: package or
build files, nearby implementations, tests, docs, generated-code markers,
framework lifecycle entry points, configuration, fixtures, logs, and accepted
business-rule examples.

Use a throwaway spike or prototype only when read-only inspection cannot expose a
user-visible behavior, API shape, or domain rule. Keep it outside the final
change unless the task explicitly asks for it.

If the probe reveals missing acceptance criteria, protected boundaries,
ownership, validation, sequencing, an open Taste decision, or a User Challenge
decision, stop and return to `/clarify` or `/plan`. If it reveals unexplained
failure evidence or root-cause uncertainty, route to `/investigate`. Do not
continue by guessing around a newly discovered unknown.

## Deviation Log

For medium/high-risk execution, record plan deviations in the task artifact or
final execution report. A deviation entry should state:

- what changed from the plan
- what evidence or probe caused the change
- why the new path still satisfies the goal and protected boundaries
- whether `/clarify`, `/plan`, `/investigate`, or user approval is required

If no deviations occurred, state that. Do not create a standalone
implementation-notes file unless the project already has that convention or a
task-local artifact is required for handoff.

## Fresh Worker Recovery

When a fresh worker returns `DONE` or `DONE_WITH_CONCERNS`, `/verify` must still
check the referenced diff, command, or artifact before any completion claim.
`DONE_WITH_CONCERNS` is not complete until the concerns are resolved, accepted as
residual risk, or routed to the right workflow.

When a fresh worker returns `NEEDS_CONTEXT`, inspect the missing context. If it
is inside the approved target and protected boundaries, update the context
manifest and retry with the added artifact. If the missing context changes the
target, ownership, protected files, acceptance criteria, or proof, return to
`/plan` instead of widening scope inside execution.

When a fresh worker returns `BLOCKED`, preserve the blocking evidence and route
to `/investigate` for unexplained failures or `/plan` for boundary, sequencing,
or scope problems. Do not continue locally by guessing around the blocker.

## Temporary State Handoff

`/execute` does not delete or trim root `STATE.md`, Task Handoff artifacts, or
fresh-context packets. Report their status to `/verify`, which owns terminal
cleanup after checking the final evidence and any Reflection Handoff needs.

Report one explicit state outcome:

```text
Temporary state: not used | pending for /verify | preserved active state
Path: <artifact path or none>
Reason: <why that outcome is correct>
```

## Workflow

1. Re-read the lightweight target or plan, any Task Handoff artifact, referenced memory, scoped lessons or durable decisions, constraints, protected files, validation requirements, and decision approval evidence.
2. Stop before editing if any Taste decision is open or changed, any User Challenge decision is unresolved, or a direct workflow invocation is the only claimed approval.
3. Run the Context Gate and count context-risk signals:
   - Can the task be completed accurately in the current context?
   - Does it touch multiple modules, runtimes, or ownership boundaries?
   - Is the language, framework, build system, runtime, or business domain
     unfamiliar or locally uninspected?
   - Could generated code, lifecycle hooks, hidden configuration,
     external-service contracts, permissions, or business invariants change the
     implementation?
   - Has the conversation been compressed or polluted by unrelated exploration?
   - Would a context manifest make owned files, reference files, and proof clearer?
   - Would a fresh worker reduce risk more than it adds coordination cost?
4. If the current context cannot complete the task accurately, stop and gather
   context, narrow the slice, or use fresh context before any edit.
5. If two or more of the remaining context-risk signals are present, split the work into a narrower slice or use `docs/templates/fresh-context-packet.md` and `prompts/fresh-worker.md` with explicit file ownership, protected boundaries, and a context manifest with read-only or owned-edit access modes.
6. Run the Unknown-Unknowns Probe before editing when unfamiliarity or hidden
   constraints are context-risk signals.
7. For high-risk code changes, write one behavior-focused failing test before production code.
8. Make the smallest change that satisfies the current task. Every changed line should trace to the task, required proof, or cleanup caused by this change.
9. Stop and reopen approval if implementation materially changes an approved Taste decision.
10. Record deviations from the plan as they occur, or state that none occurred.
11. Run the specified verification.
12. Report temporary task artifacts to `/verify` without deleting or trimming them.
13. Report changed files, verification result, temporary state status, and unresolved concerns.

## Hard Rules

- Do not edit outside the planned scope.
- Do not edit from direct `/execute` entry when the target, protected boundaries, acceptance criteria, or required proof is missing.
- Do not infer approval from a complete-outcome request, silence, lack of objection, or a workflow invocation.
- Do not implement open or changed Taste decisions or unresolved User Challenge decisions.
- Do not keep a changed line that cannot be traced to the current task.
- Follow language-appropriate type-safety rules; do not introduce `any` in TypeScript code.
- Do not swallow errors, ignore promises, or hide failures. Silent `.catch(() => {})` or `.catch(() => null)` is forbidden unless the call is genuinely fire-and-forget and the result is logged elsewhere.
- Do not refactor adjacent code unless the plan requires it.
- Do not clean up pre-existing dead code; only remove orphaned imports, variables, or helpers created by the current change.
- Do not fetch or apply memory that is not named by the plan, Task Handoff, lightweight target, or context manifest unless you return to `/plan`.
- Do not edit when the current context cannot complete the task accurately;
  gather context, narrow the slice, or use fresh context first.
- Do not edit inside an unfamiliar language, framework, runtime, build system, or
  business domain before running the smallest useful Unknown-Unknowns Probe.
- Do not keep code written before a required failing test.
- Do not use fresh context for vague work; narrow the task first.
- Do not keep throwaway spikes or prototypes in the final diff unless they are
  explicitly in scope.
- Do not hide plan deviations; record them or route back before continuing.
- Do not couple tests to private implementation when a public behavior seam exists.
- Do not batch all tests ahead of implementation for multi-behavior work.
- Do not delete or trim temporary task state during execution; `/verify` owns cleanup.
- Do not ignore `NEEDS_CONTEXT` or `BLOCKED` from a fresh worker; recover through the stated route.

## Rationalization Prevention

| Excuse | Reality |
| --- | --- |
| "This helper should be cleaned too" | That is scope creep unless required |
| "This unused code is nearby" | Only orphaned cleanup caused by the current change is in scope |
| "Tests after are enough" | Tests after prove less than tests first |
| "The current context is fine" | Context risk is silent; run the gate |
| "A broader abstraction is cleaner" | Cleaner is not a requirement |
| "A senior engineer would appreciate the abstraction" | If the abstraction is not required by the task, it is over-engineering |
| "Better safe than sorry" | Safe is not a substitute for understanding the contract; type guarantees and validated boundaries already cover the risk |
| "What if the input is null?" | If the type system guarantees non-null, the check is noise, not safety |
| "I should add a try-catch just in case" | Catching errors that should propagate hides bugs; only catch when the caller has a recovery path |
| "I should watch for config changes" | If the config is runtime-invariant, watching for changes guards against an impossible transition |
| "The upstream might not have checked" | If the flow guarantees entry conditions, re-checking is distrust of the architecture, not safety |
| "I'll add a fallback default" | If the type declares a required field, `\|\| []` masks a bug instead of surfacing it |
| "Number(x \|\| 0) is safer" | Triple-wrapping a value that is already `number \| undefined` is checking whether the compiler failed; `?? 0` is the complete contract |
| "I already defaulted at assignment, but let me default again at use" | Defense at two layers means neither layer is clearly responsible; pick one boundary and defend there |
| "\|\| '' handles all edge cases" | `\|\|` conflates null, undefined, empty string, and zero; use `??` for nullish, and let missing required data fail loudly |
| ".catch(() => null) is safe" | Silent catch turns errors into invisible data loss; if the call matters, log or propagate; if it does not matter, do not call it |
| "This defensive function is needed in 5 files" | Copy-pasted defense is a maintenance burden; extract to a shared module so the strategy can be reviewed once |
| "I should write the full test suite first" | TDD needs feedback one behavior at a time |
| "STATE.md is temporary, so delete it now" | Execution cannot prove the final lifecycle; report it to `/verify`, the sole cleanup owner |
| "I'll learn the unfamiliar stack by editing" | Cheap read-only probes should expose local conventions before code momentum starts |
| "The deviation is small enough not to mention" | Small deviations still change what `/verify` must compare against the plan |
| "The user called /execute, so the Taste choices are approved" | A workflow invocation selects a stage; it does not approve unresolved recommendations |

## Outputs

### Always

- Changed files.
- What changed and why.
- Verification commands and results.
- Decision approval evidence used, or confirmation that no Taste or User Challenge decision applied.
- Any concerns, blockers, or deviations from plan.

### When Applicable

- Unknown-Unknowns Probe result, or why no probe was needed.
- Referenced memory applied, or confirmation that no referenced memory affected execution.
- Deviation Log status for medium/high-risk work.
- Temporary state status when root `STATE.md` or another task-local artifact was used.

## Handoff

Apply root `Workflow Continuation`. Continue to `/verify` when the original
request authorizes the complete outcome and no stop condition applies; otherwise
return control with the recommended next route.

Recommended next steps for the user:

- `/verify` before any completion claim.
- `/investigate` if execution reveals unexpected failure.
- `/plan` if task boundaries prove wrong.
