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
  validation path, and protected boundaries.
- Medium or high risk: the plan plus any Task Handoff artifact produced from
  `docs/templates/task-handoff.md`, or root `STATE.md` when no project task
  artifact exists.

The inputs must name the goal, owned files or touched surface, protected
boundaries, acceptance criteria, and required proof. If direct `/execute` entry
lacks those inputs, return to `/clarify` or `/plan` before editing.

Apply only the scoped glossary terms, durable decisions, project lessons, or
trigger-matched global memory named by the plan, Task Handoff, or context
manifest. If execution needs an unlisted lesson, decision, file, or boundary to
proceed safely, stop and return to `/plan` instead of widening scope.

When context risk justifies a fresh worker, create a packet with
`docs/templates/fresh-context-packet.md` and pair it with `prompts/fresh-worker.md`.
The packet must include owned files, protected files, a context manifest with
access mode for every referenced artifact, stop conditions, and required proof.

## Workflow

1. Re-read the lightweight target or plan, any Task Handoff artifact, referenced memory, scoped lessons or durable decisions, constraints, protected files, and validation requirements.
2. Run the Context Gate:
   - Can the task be completed accurately in the current context?
   - Does it touch multiple modules, runtimes, or ownership boundaries?
   - Has the conversation been compressed or polluted by unrelated exploration?
   - Would a context manifest make owned files, reference files, and proof clearer?
   - Would a fresh worker reduce risk more than it adds coordination cost?
3. If context risk is high, use `docs/templates/fresh-context-packet.md` and `prompts/fresh-worker.md` with a narrow task, explicit file ownership, protected boundaries, and a context manifest with read-only or owned-edit access modes.
4. For high-risk code changes, write one behavior-focused failing test before production code.
5. Make the smallest change that satisfies the current task. Every changed line should trace to the task, required proof, or cleanup caused by this change.
6. Run the specified verification.
7. Report changed files, verification result, and unresolved concerns.

## Hard Rules

- Do not edit outside the planned scope.
- Do not edit from direct `/execute` entry when the target, protected boundaries, acceptance criteria, or required proof is missing.
- Do not keep a changed line that cannot be traced to the current task.
- Follow language-appropriate type-safety rules; do not introduce `any` in TypeScript code.
- Do not swallow errors, ignore promises, or hide failures.
- Do not refactor adjacent code unless the plan requires it.
- Do not clean up pre-existing dead code; only remove orphaned imports, variables, or helpers created by the current change.
- Do not fetch or apply memory that is not named by the plan, Task Handoff, or context manifest unless you return to `/plan`.
- Do not keep code written before a required failing test.
- Do not use fresh context for vague work; narrow the task first.
- Do not couple tests to private implementation when a public behavior seam exists.
- Do not batch all tests ahead of implementation for multi-behavior work.

## Rationalization Prevention

| Excuse | Reality |
| --- | --- |
| "This helper should be cleaned too" | That is scope creep unless required |
| "This unused code is nearby" | Only orphaned cleanup caused by the current change is in scope |
| "Tests after are enough" | Tests after prove less than tests first |
| "The current context is fine" | Context risk is silent; run the gate |
| "A broader abstraction is cleaner" | Cleaner is not a requirement |
| "A senior engineer would appreciate the abstraction" | If the abstraction is not required by the task, it is over-engineering |
| "I should write the full test suite first" | TDD needs feedback one behavior at a time |

## Outputs

- Changed files.
- What changed and why.
- Referenced memory applied, or confirmation that no referenced memory affected execution.
- Verification commands and results.
- Any concerns, blockers, or deviations from plan.

## Handoff

- Use `/verify` before any completion claim.
- Use `/investigate` if execution reveals unexpected failure.
- Use `/plan` if task boundaries prove wrong.
