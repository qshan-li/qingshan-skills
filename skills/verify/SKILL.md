---
name: verify
description: Use when about to claim software engineering work is complete, fixed, passing, shipped, optimized, documented, or ready for review
---

# verify

## Purpose

Prove the work before making claims. The failure this prevents is saying work is done because it looks right.

## Direct Invocation

Direct invocation must still honor root `SKILL.md` and `ETHOS.md`. Apply the
root routing assumptions and shared non-negotiables before continuing; direct
invocation changes the entry point, not the hard rules.

Before continuing from direct invocation, state the entry reason, risk level,
required upstream facts, and fallback route. If the prerequisites for this skill
are missing, use the fallback route before irreversible action.

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

Release requests count as high-risk verification when they involve ship, deploy,
publish, PR, merge, or release handoff. They require fresh evidence, scope
review, review staleness, rollback or recovery notes when relevant, and commit
or PR hygiene checks when the repository supports them.

Use `docs/templates/release-checklist.md` for release-path verification so the
claim, fresh evidence, scope review, release or handoff risk, and status are
reported consistently.

When the user explicitly requested a ship, deploy, publish, PR, merge, release,
or release handoff, `/verify` owns readiness proof first. Perform or hand off
the requested release action only after the release checklist status is Ready or
ready with stated risk, the user has accepted any residual User Challenge risk,
and the action is mechanical for the current repository. If readiness is blocked
or the action would change scope, route to `/execute`, `/plan`, or the user
before acting.

## Scope Drift Detection

Compare the intended work against the actual artifacts before claiming completion.

Use the task statement, plan, acceptance criteria, referenced memory, durable
decisions, project learning, commit messages, and diff when available. Classify
the result:

- Delivered: requested work is present.
- Missing: required work is absent.
- Extra: unrelated work or cleanup was added.
- Changed: implementation differs from the plan but satisfies the goal.
- Unverifiable: external state or another repository must be checked manually.

Scope drift does not automatically mean failure, but it must be visible before the final status.
For Extra items, distinguish required orphan-only cleanup from unrelated cleanup.
Scope drift includes durable decisions, project learning, and referenced memory when relevant.
For fresh-context work, compare the context manifest, owned files, protected
files, worker report, and actual diff.

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

## Fresh-Context Review

When fresh context or worker output was used, run spec review with
`prompts/spec-reviewer.md` and quality review with `prompts/quality-reviewer.md`,
or use those prompts as local checklists and state that the review was self-run.
Do not accept a worker report until the referenced diff, command, or artifact has
been checked.

## Context and Learning Check

When task-local artifacts, project lessons, durable decisions, or scoped global
memory entries were used, verify that the implementation honored the relevant
rules. Include durable decision and learning compliance in Scope Drift
Detection when those artifacts affected the task. When verification reveals a
recurring pitfall, project invariant, verification command, or skill-rule
candidate, report it as a `/reflect` candidate instead of writing memory during
verification.

## Reflection Handoff

Use a structured Reflection Handoff when verification finds a reusable learning,
durable decision, glossary entry, or skill-rule candidate that `/reflect` must
evaluate. Do not rely on conversation memory for this handoff.

The handoff must state:

- candidate type: reusable lesson, durable decision, glossary entry, or skill rule
- evidence source: root `STATE.md` section, Task Handoff artifact,
  fresh-context packet, verification report, diff, or other checked artifact
- future behavior: what future reader or trigger may change because of this
  candidate
- temporary state needed: path and section, or `none`
- cleanup owner: `/verify` unless `/reflect` must consume the named evidence

If no concrete candidate survives this check, `/verify` owns cleanup and must not
push temporary-state disposal to `/reflect` as a maybe.

## Temporary State Cleanup

When root `STATE.md`, a Task Handoff artifact, a fresh-context packet, or
another task-local artifact was used for the current work, verification must
check its cleanup gate before the final completion claim.

Read the `/execute` temporary state cleanup outcome when it exists. If the
outcome is missing but current work used root `STATE.md` or another temporary
task artifact, inspect the artifact directly and report the missing outcome as a
verification concern.

If `/execute` already cleaned completed-task state, record that status. If root
`STATE.md` only contains completed current-task state and no downstream handoff
or `/reflect` needs it, delete it. If it also contains unrelated active task
state, remove only the completed task's section. If `/reflect` needs the state
to evaluate a structured Reflection Handoff, report that handoff and leave the
named cleanup pending for `/reflect` after it consumes the needed evidence.

This cleanup is terminal handling for temporary task state, not unrelated
tidying. Do not delete project task artifacts that are meant to remain by
convention; only close or trim the current temporary state when the artifact
supports that.

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

Use `prompts/adversarial-reviewer.md` when a fresh reviewer or structured review
prompt is available. If no separate reviewer can run, use the prompt as the
local checklist and state that the review was self-run.

## Workflow

### Mandatory Core

1. Identify what claim is about to be made.
2. Identify the command, check, or artifact that proves it.
3. Run fresh verification or state why it cannot be run.
4. Read the output and exit code.
5. Compare results against acceptance criteria.
6. Run every applicable Risk-triggered Block before final status.
7. State actual status with evidence and residual risk.

### Risk-triggered Blocks

- Scope Drift Detection: run when a task statement, plan, referenced memory,
  durable decision, learning, or diff exists, including whether changed lines
  trace to the request.
- Review Readiness Dashboard: use for medium-risk, high-risk, or release-path
  work.
- Release checklist: use `docs/templates/release-checklist.md` for release-path
  work.
- Fresh-context review: for fresh-context work, run spec and quality review using
  `prompts/spec-reviewer.md` and `prompts/quality-reviewer.md`, or state why the
  review was self-run or blocked.
- Adversarial Review: run for high-risk changes using
  `prompts/adversarial-reviewer.md` when available.
- Learning check: check whether relevant lessons or durable decisions were
  honored and whether new `/reflect` candidates emerged.
- Reflection Handoff: create a structured handoff for any `/reflect` candidate
  that must survive outside the verification report.
- Temporary State Cleanup: check root `STATE.md` or task-local artifacts used by
  the work before final status.
- Release action: perform or hand off the requested mechanical release action
  only when readiness is proven and no User Challenge decision remains.

## Hard Rules

- Do not claim success without fresh evidence.
- Do not treat partial verification as full proof.
- Do not trust an implementer report without checking artifacts.
- Do not treat worker reports or context manifests as proof without checking the referenced diff, command, or artifact.
- Do not ignore warnings that affect the changed surface.
- Do not say "should", "probably", or "looks good" as completion proof.
- Do not ship, deploy, merge, publish, or create PR handoff without release-path verification.
- Do not perform a release action unless the user requested it, release readiness is proven, and no User Challenge decision remains open.
- Do not hide missing, extra, changed, or unverifiable work behind passing tests.
- Do not ignore durable decision, project learning, or referenced memory drift when it affected the task.
- Do not accept unrelated cleanup as orphan-only cleanup unless the current change created the orphan.
- Do not claim final completion while completed-task root `STATE.md` remains as stale temporary state; remove or trim it, or hand it to `/reflect` when reflection must consume it first.
- Do not hand temporary-state cleanup to `/reflect` without a structured Reflection Handoff and named evidence to consume.

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
- Durable decision, project learning, or referenced memory compliance when relevant.
- Review Readiness Dashboard when risk justifies it.
- Adversarial Review result or reason skipped.
- Context manifest, worker artifact review, spec review, and quality review when fresh context was used.
- Structured Reflection Handoff when a `/reflect` candidate needs promotion review.
- Temporary state cleanup status when root `STATE.md` or a task-local artifact was used.
- Scope and quality review notes.
- Residual risks or unverified items.

## Handoff

- Use `/reflect` when reusable learning should be captured.
- Use `/investigate` if verification fails unexpectedly.
- Use `/execute` for small fixes with clear cause.
