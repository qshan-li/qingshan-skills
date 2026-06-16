---
name: verify
description: Use when about to claim software engineering work is complete, fixed, passing, shipped, optimized, documented, or ready for review
---

# verify

## Purpose

Prove the work before making claims. The failure this prevents is saying work is done because it looks right.

## When to Use

- Before saying complete, fixed, passing, shipped, optimized, documented, or ready.
- After code, config, docs, tests, dependency, performance, deployment, or security changes.
- When reviewing whether implementation matches a plan or spec.
- When deciding whether remaining risk is acceptable.

## When NOT to Use

- The goal is unclear. Use `/clarify`.
- The failure is unexplained. Use `/investigate`.
- The plan has not been executed. Use `/execute`.

## Risk Gate

| Risk | Verification behavior |
| --- | --- |
| Low | Run the smallest proof that checks the touched surface |
| Medium | Run tests, type/build checks, and acceptance checks relevant to the change |
| High | Add task-specific proof such as regression tests, performance comparison, dry run, rollback review, or security residual risk |

## Workflow

1. Identify what claim is about to be made.
2. Identify the command, check, or artifact that proves it.
3. Run fresh verification or state why it cannot be run.
4. Read the output and exit code.
5. Compare results against acceptance criteria.
6. Review scope, quality, and unexpected diff.
7. State actual status with evidence and residual risk.

## Hard Rules

- Do not claim success without fresh evidence.
- Do not treat partial verification as full proof.
- Do not trust an implementer report without checking artifacts.
- Do not ignore warnings that affect the changed surface.
- Do not say "should", "probably", or "looks good" as completion proof.

## Rationalization Prevention

| Excuse | Reality |
| --- | --- |
| "The change is tiny" | Tiny changes still need targeted proof |
| "Tests passed earlier" | Earlier is not fresh verification |
| "The agent said it worked" | Reports are not evidence |
| "Build passed, so requirements are met" | Build is not acceptance |

## Outputs

- Commands or checks run.
- Relevant output and exit status.
- Acceptance criteria status.
- Scope and quality review notes.
- Residual risks or unverified items.

## Handoff

- Use `/reflect` when reusable learning should be captured.
- Use `/investigate` if verification fails unexpectedly.
- Use `/execute` for small fixes with clear cause.
