---
name: investigate
description: Use when diagnosing bugs, failing tests, deployment failures, performance issues, security concerns, stability problems, or unknown root causes
---

# investigate

## Purpose

Establish facts before fixes. The failure this prevents is changing code based on guesses.

## When to Use

- Bug reports, failing tests, regressions, intermittent failures, or unclear symptoms.
- Performance tuning requests.
- Deployment, CI, release, security, or stability failures.
- Any work where the root cause or baseline is unknown.

## When NOT to Use

- The issue is already reproduced, root cause is known, and the fix is low-risk. Use `/execute`.
- The task is a new feature or planned refactor with no failure signal. Use `/clarify`.
- Completed work needs proof. Use `/verify`.

## Risk Gate

| Risk | Investigation behavior |
| --- | --- |
| Low | Reproduce or observe once and identify the likely failing surface |
| Medium | Collect logs, tests, traces, or code-path evidence before planning |
| High | Build a repeatable reproduction or baseline and state confidence before fixes |

## Feedback Loop

The first investigation task is to build or identify a pass/fail signal the agent can run. Prefer a fast, deterministic loop that reproduces the user's symptom, not a nearby failure.

When the loop is weak, improve it before hypothesizing:

- make it faster by narrowing setup or scope
- make the signal sharper by asserting the exact symptom
- make it more deterministic by controlling time, randomness, filesystem, or network inputs

For medium or high-risk failures, form 3-5 ranked, falsifiable hypotheses before probing. Each probe should test one prediction and change one variable at a time.

## Investigation Handoff

Use `docs/templates/task-handoff.md` when investigation results must survive
context compression, agent handoff, fresh-context execution, or a `/plan` or
`/execute` handoff.

Write the handoff to the project's existing task artifact when one exists. If
there is no project convention and the handoff is needed for the current task,
create or update root `STATE.md`. Persist only current-task evidence: symptom,
expected behavior, reproduction or observation method, feedback loop limits,
facts, narrowed surface, hypotheses with confidence, and recommended fix path.

## Workflow

1. State the symptom and expected behavior.
2. Build or identify the fastest reliable feedback loop available.
3. Reproduce or observe the failure through that loop.
4. Collect facts from tests, logs, metrics, traces, configuration, or code paths.
5. Narrow the failing surface.
6. Form ranked falsifiable root-cause hypotheses and test the strongest one.
7. Persist an Investigation Handoff when the evidence or fix path must survive outside the conversation.
8. Recommend the smallest fix path.

Performance work must establish a baseline and repeatable measurement method. Deployment work must identify environment boundaries and failure evidence. Security and stability work must include a threat or failure model.

## Hard Rules

- No facts, no fix.
- Do not edit code while still collecting basic evidence.
- Do not optimize without a baseline.
- Do not call a symptom the root cause.
- Do not ignore failed verification; it is new evidence.
- Do not proceed from a weak or unrelated feedback loop as if it reproduced the user's failure.
- Do not test multiple variables in one probe when isolating root cause.
- Do not leave medium/high-risk investigation evidence only in the conversation when handing off to `/plan`, `/execute`, or fresh context.

## Rationalization Prevention

| Excuse | Reality |
| --- | --- |
| "This is probably cache" | Probably is not evidence |
| "The fix is obvious" | Obvious fixes still need reproduction |
| "Benchmarks take too long" | Performance work without baselines is guessing |
| "Logs are noisy" | Find the signal before editing |
| "One plausible hypothesis is enough" | Single-hypothesis debugging anchors too early |

## Outputs

- Reproduction or observation method.
- Feedback loop quality and limits.
- Facts collected.
- Narrowed failing surface.
- Root-cause hypotheses and confidence.
- Recommended fix path.
- Investigation Handoff artifact path when one was needed, or the reason no handoff artifact was needed.

## Handoff

- Use `/plan` for non-trivial fixes.
- Use `/execute` for small fixes after evidence exists.
- Continue `/investigate` when confidence is too low.
