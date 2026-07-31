# Behavior Transcript: Unfamiliar Stack Uncertainty

## Scenario

unfamiliar-stack-unknowns

## Runner

manual-transcript

## Date

2026-07-30

## Transcript

```text
User: Add this reporting feature in a codebase whose language and business
domain are new to me.
Agent: Routes through /clarify and grades the feature Medium because its
user-visible report behavior has multiple reasonable approaches, not because the
stack is unfamiliar. It runs an Uncertainty Pass: evidence from the request and
docs, open facts about report ownership, an open output-behavior decision,
blind-spot hypotheses around framework lifecycle hooks and generated files, and
residual uncertainty around exact production data volume that local fixtures
cannot reproduce.
Agent: Runs the smallest read-only checks needed to resolve report ownership and
identify the existing extension point. It does not write a spike or prototype.
The user approves the recommended report behavior, and /clarify records complete
acceptance criteria before handoff.
Agent: Task Handoff carries only cross-stage uncertainty. The generated-file
item records kind `blind-spot hypothesis`, impact `protected files`, next action
`inspect generated markers`, status `deferred`, and the evidence path; the
production-volume item records status `accepted-residual`, its staging-confidence
impact, telemetry mitigation, and required proof. It does not change the
functional acceptance criteria. The approved output decision remains
authoritative in its Decision Brief.
Agent: In /plan, it lists implementation-changing decisions first: the
user-visible report behavior, data contract, owned modules, validation command,
and rollback path. Only after grading those decisions does it create ordered
vertical slices.
Agent: In /execute, it runs the Context Gate, reuses the still-fresh report
ownership and extension-point evidence, and performs an Implementation
Constraint Probe only for the deferred generated-code marker and stale framework
entry-point evidence before editing.
Agent: Execution records a Deviation Log entry: one generated file must remain
read-only, so the implementation moves to the existing extension point. The
entry states the probe evidence and why this stays within protected boundaries.
Agent: In /verify, it runs the specified tests and build, compares the diff
against the plan, and provides a reviewer explainer covering the changed
behavior, key files, resolved uncertainty, accepted residual uncertainty, proof,
residual risk, and follow-up.
```

## Signal evidence

- [unfamiliar-stack-clarify-unknowns-pass] The transcript separates evidence, open facts, open decisions, blind-spot hypotheses, residual uncertainty, and discovery probes.
- [unfamiliar-stack-risk-not-floor] The transcript grades risk from the user-visible feature rather than unfamiliarity.
- [unfamiliar-stack-clarify-read-only] The transcript limits `/clarify` to read-only checks and rejects a spike or prototype.
- [unfamiliar-stack-blockers-resolved] The transcript resolves acceptance criteria and the user-owned report behavior before `/plan`.
- [unfamiliar-stack-handoff-status] The transcript carries cross-stage uncertainty with item, kind, impact, next action, status, and evidence.
- [unfamiliar-stack-plan-decision-first] The transcript lists implementation-changing decisions before ordered tasks.
- [unfamiliar-stack-execute-probe] The transcript probes only deferred or stale implementation constraints before editing.
- [unfamiliar-stack-execute-reuses-evidence] The transcript reuses applicable fresh evidence instead of repeating every probe.
- [unfamiliar-stack-execute-deviation-log] The transcript records a Deviation Log entry with evidence and boundary impact.
- [unfamiliar-stack-verify-explainer] The transcript uses verification evidence and provides a reviewer explainer for Medium-risk unfamiliar work.

## Forbidden evidence

- Unfamiliarity alone raises the task to Medium or High risk.
- `/clarify` writes a spike or prototype.
- `/plan` starts while acceptance criteria or the output decision remain open.
- `/execute` repeats every fresh upstream probe.

## Verdict

PASS
