---
name: execute
description: Use when implementing a planned software engineering change, refactor, configuration update, documentation change, or fresh-context task
---

# execute

## Purpose

Make scoped changes without drifting from the plan, over-engineering, or letting context quality decay.

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

## Workflow

1. Re-read the plan, constraints, protected files, and validation requirements.
2. Run the Context Gate:
   - Can the task be completed accurately in the current context?
   - Does it touch multiple modules, runtimes, or ownership boundaries?
   - Has the conversation been compressed or polluted by unrelated exploration?
   - Would a fresh worker reduce risk more than it adds coordination cost?
3. If context risk is high, use `prompts/fresh-worker.md` with a narrow task and explicit file ownership.
4. For high-risk code changes, write the failing test before production code.
5. Make the smallest change that satisfies the current task.
6. Run the specified verification.
7. Report changed files, verification result, and unresolved concerns.

## Hard Rules

- Do not edit outside the planned scope.
- Do not introduce `any` in TypeScript code.
- Do not swallow errors, ignore promises, or hide failures.
- Do not refactor adjacent code unless the plan requires it.
- Do not keep code written before a required failing test.
- Do not use fresh context for vague work; narrow the task first.

## Rationalization Prevention

| Excuse | Reality |
| --- | --- |
| "This helper should be cleaned too" | That is scope creep unless required |
| "Tests after are enough" | Tests after prove less than tests first |
| "The current context is fine" | Context risk is silent; run the gate |
| "A broader abstraction is cleaner" | Cleaner is not a requirement |

## Outputs

- Changed files.
- What changed and why.
- Verification commands and results.
- Any concerns, blockers, or deviations from plan.

## Handoff

- Use `/verify` before any completion claim.
- Use `/investigate` if execution reveals unexpected failure.
- Use `/plan` if task boundaries prove wrong.
