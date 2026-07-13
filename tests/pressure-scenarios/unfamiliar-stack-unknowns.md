# Unfamiliar Stack Unknowns

## Trigger
Implement a feature in an unfamiliar programming language, framework, build
system, or business domain.

## Expected route
/clarify -> /plan -> /execute -> /verify

## Shortcut risk
The agent treats unfamiliarity as normal context, jumps into implementation,
misses hidden framework or domain conventions, and only discovers the real
constraint after code momentum has already narrowed its choices.

## Pass condition
The workflow exposes likely unknown unknowns before editing, puts
implementation-changing decisions before the task list, probes local conventions
with the smallest read-only checks, records deviations, and uses a reviewer
explainer for high-risk handoff without replacing verification evidence.

## Required signals
- [unfamiliar-stack-clarify-unknowns-pass] `/clarify` separates known facts, known unknowns, likely unknown unknowns, and discovery probes.
- [unfamiliar-stack-plan-decision-first] `/plan` lists implementation-changing decisions before ordered tasks.
- [unfamiliar-stack-execute-probe] `/execute` probes local stack or domain conventions before editing.
- [unfamiliar-stack-execute-deviation-log] `/execute` records deviations or states that no deviations occurred.
- [unfamiliar-stack-verify-explainer] `/verify` provides a reviewer explainer for high-risk unfamiliar work while still using verification evidence.
