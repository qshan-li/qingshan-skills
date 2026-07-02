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

## Trust the Contract

When the type system, function signatures, upstream flow, or runtime-invariant configuration already guarantees a condition, do not add redundant runtime checks. Contracts come in three forms:

- **Type contracts**: TypeScript types, interfaces, required fields — do not re-check what the compiler enforces.
- **Flow contracts**: upstream pages, middleware, or sequential steps that already validated or blocked a condition — do not re-verify what the entry point guarantees.
- **Invariant contracts**: configuration, environment, or state that cannot change at runtime — do not watch or guard against impossible transitions.

Defensive code that guards against scenarios any of these contracts make impossible is over-engineering, not safety. Prefer letting violations surface as loud failures over silently handling them with fallback logic.

## Defense Belongs at Boundaries

The value of defensive code is at trust boundaries: IPC, network, hardware, user input, external APIs. Inside the type-safe interior, redundant defense is noise that makes real boundary defense harder to spot.

Do not layer the same protection at multiple levels. If a value is defaulted at assignment, do not re-default at every use site. If a type guarantees non-null, do not add `?? ''` at every consumption point. Defense should happen once, at the boundary, not in an onion of redundant wrappers.

Do not use `||` fallback to silence data integrity problems. `|| ''` conflates `null`, `undefined`, empty string, and zero into one undifferentiated value. Use `??` for nullish coalescing when a default is genuinely needed, and let missing required data surface as an error rather than silently producing a degraded result.

When the same defensive pattern is copied across files, extract it to a shared location so the defense strategy can be reviewed and improved once.

Not all runtime checks are over-defensive. Type narrowing on discriminated unions (`'key' in obj`, `if (obj.kind === 'a')`) is the type system working correctly, not redundancy. Judge checks by whether the type system already covers the case, not by whether a runtime check exists.

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
