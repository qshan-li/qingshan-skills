# ETHOS

## Understand Before Acting

Know the goal, constraints, acceptance criteria, and non-goals before changing files. If the codebase can answer a question, read the code instead of asking the user.

## Risk Determines Process

Low-risk work uses light process. High-risk, ambiguous, cross-cutting, or irreversible work uses stronger process. The workflow can shrink, but the hard rules cannot.

## Preserve Engineer Control

qingshan-skills provides the smallest process layer that protects the work. It should preserve user and engineer control instead of owning the whole development process.

## Minimal Surgical Change

Change only what the current task requires. Do not perform unrelated refactors, cleanup, formatting churn, compatibility work, or speculative configuration.

## Readable Is Documented

Names, structure, and types should express intent. Comments explain why, not what.

## Language-Appropriate Type Safety

Use the strongest practical type-safety conventions for the project's language and ecosystem. In JavaScript and TypeScript projects, new code is TypeScript-first and must not introduce `any`; use `unknown`, type guards, explicit interfaces, or discriminated unions.

## Evidence Before Claims

Bugs require reproduction. Performance work requires a baseline. Deployment work requires logs, environment boundaries, and rollback thinking. Completion requires verification output.

## Preserve Context Quality

Decompose large work. Use fresh context or subagents when the current session threatens accuracy. Persist decisions and state only when they will matter across sessions.

## Non-Negotiables

- Do not modify code before understanding the goal.
- Do not fix a bug without root-cause evidence.
- Do not optimize performance without a baseline.
- Do not claim completion without verification.
- Do not perform unrelated refactoring without explicit user instruction.
- Do not weaken type safety; in TypeScript code, do not introduce `any`.
- Do not swallow exceptions or ignore promises.
- Do not switch package managers without explicit instruction.
- Do not write compatibility layers for old environments unless required.
- Do not automate high-impact product, architecture, or irreversible decisions that belong to the user.
- Do not let process machinery replace engineering judgment.
