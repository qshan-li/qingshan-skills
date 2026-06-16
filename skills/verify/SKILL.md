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
| High | Add task-specific proof such as regression tests, performance comparison, dry run, Scope Drift Detection, Adversarial Review, rollback review, or security residual risk |

Release requests count as high-risk verification when they involve ship, deploy, publish, PR, merge, or release handoff. They require fresh evidence, scope review, review staleness check, and rollback or recovery notes when relevant.

## Scope Drift Detection

Compare the intended work against the actual artifacts before claiming completion.

Use the task statement, plan, acceptance criteria, commit messages, and diff when available. Classify the result:

- Delivered: requested work is present.
- Missing: required work is absent.
- Extra: unrelated work or cleanup was added.
- Changed: implementation differs from the plan but satisfies the goal.
- Unverifiable: external state or another repository must be checked manually.

Scope drift does not automatically mean failure, but it must be visible before the final status.

## Review Readiness Dashboard

Report verification as a compact dashboard when risk or release path justifies it.

Use task-relevant rows only:

- tests
- type check
- build
- lint
- manual smoke check
- scope drift review
- adversarial review
- release or rollback readiness
- residual risk

Each row must say one of: fresh evidence, stale evidence, skipped with reason, blocked, or not applicable.

## Adversarial Review

Run an adversarial review for high-risk changes, or state why it could not run.

Trigger it for:

- authentication, authorization, or secret handling
- data migration or irreversible data changes
- concurrency, queueing, retries, or distributed state
- payment, billing, or compliance paths
- deployment, CI/CD, or rollback behavior
- LLM output trust boundaries
- large or cross-module diffs

The stance is production failure analysis: look for silent data corruption, privilege bypass, race conditions, swallowed errors, resource leaks, unsafe external-state assumptions, and incomplete rollback paths.

## Workflow

1. Identify what claim is about to be made.
2. Identify the command, check, or artifact that proves it.
3. Run fresh verification or state why it cannot be run.
4. Read the output and exit code.
5. Compare results against acceptance criteria.
6. Run Scope Drift Detection when a task statement, plan, or diff exists.
7. Use the Review Readiness Dashboard for medium-risk, high-risk, or release-path work.
8. Run Adversarial Review for high-risk changes.
9. State actual status with evidence and residual risk.

## Hard Rules

- Do not claim success without fresh evidence.
- Do not treat partial verification as full proof.
- Do not trust an implementer report without checking artifacts.
- Do not ignore warnings that affect the changed surface.
- Do not say "should", "probably", or "looks good" as completion proof.
- Do not ship, deploy, merge, publish, or create PR handoff without release-path verification.
- Do not hide missing, extra, changed, or unverifiable work behind passing tests.

## Rationalization Prevention

| Excuse | Reality |
| --- | --- |
| "The change is tiny" | Tiny changes still need targeted proof |
| "Tests passed earlier" | Earlier is not fresh verification |
| "The agent said it worked" | Reports are not evidence |
| "Build passed, so requirements are met" | Build is not acceptance |
| "The diff is fine because tests pass" | Scope drift can pass tests while violating the request |
| "Release is just pushing the branch" | Release is a handoff risk and needs fresh evidence plus rollback or recovery notes |

## Outputs

- Commands or checks run.
- Relevant output and exit status.
- Acceptance criteria status.
- Scope Drift Detection status.
- Review Readiness Dashboard when risk justifies it.
- Adversarial Review result or reason skipped.
- Scope and quality review notes.
- Residual risks or unverified items.

## Handoff

- Use `/reflect` when reusable learning should be captured.
- Use `/investigate` if verification fails unexpectedly.
- Use `/execute` for small fixes with clear cause.
