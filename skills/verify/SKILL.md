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
ready with stated risk, every Taste decision is approved, the user has accepted
any residual User Challenge risk, and the action is mechanical for the current
repository. If readiness is blocked or the action would change scope, route to
`/execute`, `/plan`, or the user before acting.

Report readiness status and release-action status separately:

- readiness status: Ready | ready with stated risk | blocked | not ready
- release action status: not attempted | succeeded | failed | handed off

Authentication failure, merge conflict, remote rejection, missing credentials,
or handoff refusal is a release-action failure. It does not by itself make the
implementation verification fail when readiness proof already passed.

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

## Behavior Regression Proof

When a change introduces or alters observable behavior, `/verify` checks whether
distinguishing proof already exists. It does not author production code or tests.

- Present: a test, smoke check, dry run, fixture, or interactive observation that
  can distinguish old behavior from new behavior is available and was freshly run.
- Missing: no distinguishing proof exists for the changed behavior. Report
  Missing / Not Ready. Do not edit the repository to create the proof during
  `/verify`.
- Route: when the original request authorized implementation and proof is
  missing, recommend `/execute` to add the distinguishing test or repeatable
  check, then re-enter `/verify`. For pure review, PR, or diff review requests,
  stop at Not Ready with residual risk.

Existing green tests alone are not enough when they do not exercise the changed
behavior. Claiming there is no seam requires a one-line reason. Creating missing
proof is an `/execute` responsibility (TDD for high-risk code changes).

## Verification Observability

Choose proof that lets the agent see, measure, or interact with the result
instead of relying on an implementer report or a visual impression.

Use the smallest task-relevant signal:

- UI changes: browser interaction, screenshot before and after the changed
  state, accessibility tree or DOM evidence, and console check.
- Performance changes: baseline comparison, trace, metric threshold, or Core Web
  Vitals check when web-facing.
- Backend or CLI changes: tests, dry run, logs, metrics, or generated artifact
  inspection that exercises the changed path.
- Documentation or skill changes: repository validation scripts, targeted text
  checks, rendered or generated output when available, and sync commands when the
  project requires propagation.

If the same manual check recurs, prefer a script, fixture, MCP interaction, or
skill rule that can be rerun deterministically. Quantitative checks are better
stop conditions than "looks right"; when only manual judgment is possible, state
the observed artifact and residual risk.

## Reviewer Explainer and Check

For high-risk, unfamiliar-stack, unfamiliar-domain, fresh-context, broad diff,
or release-path work, provide a concise reviewer explainer before final status.
It should state the claim, changed behavior, key files, decisions or unknowns
resolved, proof run, residual risk, and rollback or follow-up when relevant.

Add a lightweight understanding check only when a human handoff would benefit
from it. Use two to four questions or self-check prompts that expose whether the
reviewer understands the risky behavior, not trivia about the implementation.
Do not use an explainer or quiz as a substitute for fresh evidence.

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

## Pure Review Boundary

Treat pure code review, PR review, or diff review requests as read-only unless
the original request also authorized implementation or complete task closure for
the current execution chain.

On pure review:

- Do not create Reflection Handoff files or other durable/task artifacts.
- Do not delete, trim, or rewrite root `STATE.md`, Task Handoff artifacts, or
  fresh-context packets.
- Report candidate learnings and cleanup concerns in the verification report
  only.

## Reflection Handoff

Use a structured Reflection Handoff only when all of these are true:

- verification finds a reusable learning, durable decision, glossary entry, or
  skill-rule candidate that `/reflect` must evaluate
- the original request authorized complete-outcome work or explicit reflection
  follow-through for this execution chain
- this is not a pure review, PR, or diff review request

Do not rely on conversation memory for this handoff.

The handoff must state:

- candidate type: reusable lesson, durable decision, glossary entry, or skill rule
- checked evidence source: verification report, diff, command output, or other
  checked artifact
- self-contained evidence: the smallest excerpt or fact `/reflect` needs
- future behavior: what future reader or trigger may change because of this
  candidate
- temporary state cleanup status: cleaned by `/verify` or not used

`/reflect` must not need root `STATE.md` or another temporary task artifact to
evaluate the candidate. If the handoff cannot carry enough checked evidence,
report the reflection candidate as blocked instead of transferring cleanup
ownership. On pure review, keep the candidate inside the verification report.

## Temporary State Cleanup

`/verify` is the sole cleanup owner for root `STATE.md`, Task Handoff artifacts,
fresh-context packets, and other temporary task-local artifacts created by the
current authorized execution chain. Verification must check their cleanup gate
before a final completion claim for that chain.

Cleanup may delete or trim temporary task state only when:

- this execution chain created or consumed the temporary artifact, and
- the original request authorized the complete outcome or explicit task closure

On pure review, PR, or diff review requests, inspect only and report cleanup
concerns. Do not modify temporary artifacts.

Read the `/execute` temporary state status when it exists. If the status is
missing but current authorized work used a temporary task artifact, inspect the
artifact directly and report the missing status as a verification concern.

If cleanup is authorized and root `STATE.md` only contains completed current-task
state, delete it. If it also contains unrelated active task state, remove only
the completed task's section. When `/reflect` needs verified evidence, create a
self-contained Reflection Handoff first, then clean the completed temporary
state.

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
6. Choose the smallest task-relevant signal from Verification Observability.
7. Run every applicable Risk-triggered Block before final status.
8. State actual status with evidence and residual risk.

### Risk-triggered Blocks

- Scope Drift Detection: run when a task statement, plan, referenced memory,
  durable decision, learning, or diff exists, including whether changed lines
  trace to the request.
- Behavior Regression Proof: run when observable behavior changed.
- Review Readiness Dashboard: use for medium-risk, high-risk, or release-path
  work.
- Verification Observability: choose proof that can see, measure, or interact
  with the changed result.
- Reviewer Explainer and Check: use for high-risk, unfamiliar-stack,
  unfamiliar-domain, fresh-context, broad-diff, or release-path work.
- Release checklist: use `docs/templates/release-checklist.md` for release-path
  work.
- Fresh-context review: for fresh-context work, run spec and quality review using
  `prompts/spec-reviewer.md` and `prompts/quality-reviewer.md`, or state why the
  review was self-run or blocked.
- Adversarial Review: run for high-risk changes using
  `prompts/adversarial-reviewer.md` when available.
- Learning check: check whether relevant lessons or durable decisions were
  honored and whether new `/reflect` candidates emerged.
- Reflection Handoff: when complete-outcome work authorizes it, create a
  structured handoff for any `/reflect` candidate that must survive outside the
  verification report; on pure review, report candidates only.
- Temporary State Cleanup: when the current authorized chain owns temporary
  state, clean completed artifacts before final status; on pure review, report
  cleanup concerns without modifying files.
- Release action: perform or hand off the requested mechanical release action
  only when readiness is proven and no open Taste or User Challenge decision remains.

## Hard Rules

- Do not claim success without fresh evidence.
- Do not treat partial verification as full proof.
- Do not edit code or tests during `/verify` to create missing behavior proof;
  report Missing / Not Ready and route to `/execute` only when implementation is
  authorized.
- Do not create Reflection Handoff files or modify temporary task artifacts
  during pure review, PR, or diff review requests.
- Do not accept only pre-existing green tests when observable behavior changed
  and those tests do not distinguish old from new behavior.
- Do not collapse release-action failure into implementation verification failure
  when readiness already passed.
- Do not trust an implementer report without checking artifacts.
- Do not treat worker reports or context manifests as proof without checking the referenced diff, command, or artifact.
- Do not use "looks right" as the only proof when a task-relevant observable,
  measurable, or interactive check is available.
- Do not replace verification evidence with a reviewer explainer or
  understanding check.
- Do not quiz reviewers for low-risk work when the proof and scope are already
  clear.
- Do not ignore warnings that affect the changed surface.
- Do not say "should", "probably", or "looks good" as completion proof.
- Do not ship, deploy, merge, publish, or create PR handoff without release-path verification.
- Do not perform a release action unless the user requested it, release readiness is proven, and no open Taste or User Challenge decision remains.
- Do not hide missing, extra, changed, or unverifiable work behind passing tests.
- Do not ignore durable decision, project learning, or referenced memory drift when it affected the task.
- Do not accept unrelated cleanup as orphan-only cleanup unless the current change created the orphan.
- Do not claim final completion while completed-task root `STATE.md` remains as stale temporary state; remove or trim it after preserving any required reflection evidence in a self-contained handoff.
- Do not transfer temporary-state cleanup ownership to `/reflect`.

## Rationalization Prevention

| Excuse | Reality |
| --- | --- |
| "The change is tiny" | Tiny changes still need targeted proof |
| "Tests passed earlier" | Earlier is not fresh verification |
| "The agent said it worked" | Reports are not evidence |
| "Build passed, so requirements are met" | Build is not acceptance |
| "The diff is fine because tests pass" | Scope drift can pass tests while violating the request |
| "Existing tests still pass, so the new behavior is proven" | Behavior changes need a distinguishing test or repeatable changed-path proof |
| "I'll add the missing test in /verify" | `/verify` checks proof; creating proof is `/execute` when implementation is authorized |
| "I'll clean STATE.md while reviewing the PR" | Pure review reports cleanup concerns; it does not rewrite temporary artifacts |
| "There is no test seam" | State why, require a repeatable smoke, dry run, fixture, or interactive check, or mark Missing |
| "Release is just pushing the branch" | Release is a handoff risk and needs fresh evidence plus rollback or recovery notes |
| "Push failed, so the implementation is unverified" | Report release-action failure separately when readiness already passed |
| "An explanation proves the work" | Explainers help review; evidence proves the claim |

## Outputs

### Always

- Commands or checks run.
- Relevant output and exit status.
- Acceptance criteria status.
- Scope Drift Detection status.
- Behavior Regression Proof status when observable behavior changed, or why no
  behavior change applied.
- Verification observability used, or why no stronger observable check was available.
- Scope and quality review notes.
- Residual risks or unverified items.

### When Applicable

- Durable decision, project learning, or referenced memory compliance when relevant.
- Review Readiness Dashboard when risk justifies it.
- Adversarial Review result or reason skipped.
- Reviewer Explainer and Check when risk or handoff justifies it.
- Context manifest, worker artifact review, spec review, and quality review when fresh context was used.
- Structured Reflection Handoff when a `/reflect` candidate needs promotion review.
- Temporary state cleanup status when root `STATE.md` or a task-local artifact was used.
- Readiness status and release action status when a release path was requested.

## Handoff

Apply root `Workflow Continuation`. Continue only when the original request
authorizes the next workflow and verification evidence identifies no stop
condition; otherwise return control with the recommended next route.

Apply root `Workflow Handoff Selection` when returning control. Use only the
valid routes below as options, with the recommended route first.

Recommended next steps for the user:

- `/reflect` when reusable learning should be captured.
- `/investigate` if verification fails unexpectedly.
- `/execute` only when Fix-Path Exit Criteria from root or `/investigate` are
  met, or when missing distinguishing proof must be authored under an authorized
  implementation request, then re-enter `/verify`.
