# Unfamiliar Stack Uncertainty

## Trigger
Implement a reporting feature with multiple reasonable user-visible output
behaviors in an unfamiliar programming language, framework, build system, or
business domain.

## Expected route
/clarify -> /plan -> /execute -> /verify

The reporting feature is Medium because user-visible behavior has multiple
reasonable approaches. Unfamiliarity triggers discovery but is not a risk floor.

## Shortcut risk
The agent treats unfamiliarity as normal context, jumps into implementation,
misses hidden framework or domain conventions, and only discovers the real
constraint after code momentum has already narrowed its choices.

## Pass condition
The workflow runs an operational Uncertainty Pass, resolves blocking acceptance
criteria and decisions before planning, carries only cross-stage uncertainty in
the six-field handoff shape, puts implementation-changing decisions before the
task list, reuses fresh evidence, probes only unresolved or stale implementation
constraints, records deviations, and uses a reviewer explainer without replacing
verification evidence.

## Required signals
- [unfamiliar-stack-clarify-unknowns-pass] `/clarify` separates evidence, open facts, open decisions, blind-spot hypotheses, residual uncertainty, and discovery probes.
- [unfamiliar-stack-risk-not-floor] Unfamiliarity triggers the pass but does not determine the task risk level.
- [unfamiliar-stack-clarify-read-only] `/clarify` runs only decision-relevant read-only probes and does not create a spike or prototype.
- [unfamiliar-stack-blockers-resolved] Acceptance criteria and user-owned decisions are resolved before `/plan`.
- [unfamiliar-stack-handoff-status] Cross-stage uncertainty uses item, kind, impact, next action, status, and evidence.
- [unfamiliar-stack-plan-decision-first] `/plan` lists implementation-changing decisions before ordered tasks.
- [unfamiliar-stack-execute-probe] `/execute` probes unresolved or stale local implementation constraints before editing.
- [unfamiliar-stack-execute-reuses-evidence] `/execute` reuses applicable fresh upstream evidence instead of repeating every probe.
- [unfamiliar-stack-execute-deviation-log] `/execute` records deviations or states that no deviations occurred.
- [unfamiliar-stack-verify-explainer] `/verify` provides a reviewer explainer for Medium-risk unfamiliar work while still using verification evidence.
