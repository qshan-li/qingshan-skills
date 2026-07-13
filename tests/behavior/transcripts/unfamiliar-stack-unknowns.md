# Behavior Transcript: Unfamiliar Stack Unknowns

## Scenario

unfamiliar-stack-unknowns

## Runner

manual-transcript

## Date

2026-07-07

## Transcript

```text
User: Add this reporting feature in a codebase whose language and business
domain are new to me.
Agent: Routes through /clarify and runs an Unknowns Pass. It separates known
facts from the request and docs, known unknowns about report ownership and
acceptance criteria, likely unknown unknowns around framework lifecycle hooks,
generated files, and domain-specific reporting rules, then names discovery
probes that can answer them before implementation.
Agent: In /plan, it lists implementation-changing decisions first: the
user-visible report behavior, data contract, owned modules, validation command,
and rollback path. Only after grading those decisions does it create ordered
vertical slices.
Agent: In /execute, it runs the Context Gate and performs read-only probes of
the package files, nearby report implementation, tests, generated-code markers,
framework entry points, and domain fixtures before editing.
Agent: Execution records a Deviation Log entry: one generated file must remain
read-only, so the implementation moves to the existing extension point. The
entry states the probe evidence and why this stays within protected boundaries.
Agent: In /verify, it runs the specified tests and build, compares the diff
against the plan, and provides a reviewer explainer covering the changed
behavior, key files, resolved unknowns, proof, residual risk, and follow-up.
```

## Signal evidence

- [unfamiliar-stack-clarify-unknowns-pass] The transcript separates known facts, known unknowns, likely unknown unknowns, and discovery probes.
- [unfamiliar-stack-plan-decision-first] The transcript lists implementation-changing decisions before ordered tasks.
- [unfamiliar-stack-execute-probe] The transcript probes local stack and domain conventions before editing.
- [unfamiliar-stack-execute-deviation-log] The transcript records a Deviation Log entry with evidence and boundary impact.
- [unfamiliar-stack-verify-explainer] The transcript uses verification evidence and provides a reviewer explainer for high-risk unfamiliar work.

## Forbidden evidence

- none

## Verdict

PASS
