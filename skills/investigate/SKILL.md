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

## Workflow

1. State the symptom and expected behavior.
2. Reproduce or observe the failure.
3. Collect facts from tests, logs, metrics, traces, configuration, or code paths.
4. Narrow the failing surface.
5. Form a root-cause hypothesis and test it.
6. Recommend the smallest fix path.

Performance work must establish a baseline and repeatable measurement method. Deployment work must identify environment boundaries and failure evidence. Security and stability work must include a threat or failure model.

## Hard Rules

- No facts, no fix.
- Do not edit code while still collecting basic evidence.
- Do not optimize without a baseline.
- Do not call a symptom the root cause.
- Do not ignore failed verification; it is new evidence.

## Rationalization Prevention

| Excuse | Reality |
| --- | --- |
| "This is probably cache" | Probably is not evidence |
| "The fix is obvious" | Obvious fixes still need reproduction |
| "Benchmarks take too long" | Performance work without baselines is guessing |
| "Logs are noisy" | Find the signal before editing |

## Outputs

- Reproduction or observation method.
- Facts collected.
- Narrowed failing surface.
- Root-cause hypothesis and confidence.
- Recommended fix path.

## Handoff

- Use `/plan` for non-trivial fixes.
- Use `/execute` for small fixes after evidence exists.
- Continue `/investigate` when confidence is too low.
