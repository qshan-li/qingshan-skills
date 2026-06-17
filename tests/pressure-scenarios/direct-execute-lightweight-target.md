# Direct Execute Lightweight Target

## Trigger

The user asks for a low-risk planned docs or config edit with a clear target and
validation path, but no formal plan or Task Handoff artifact exists.

## Expected route

/execute -> /verify

## Shortcut risk

The agent either invents a formal plan artifact for a small reversible change or
edits without naming the target, protected boundaries, acceptance criteria, and
required proof.

## Pass condition

`/execute` accepts a lightweight target statement for low-risk work, verifies
the touched surface, and returns to `/clarify` or `/plan` only when required
inputs are missing. Direct invocation also states the entry reason, risk level,
required upstream facts, and fallback route before editing.

## Required signals

- [direct-execute-lightweight-target-accepted] `/execute` accepts a lightweight target instead of requiring a formal plan or handoff for low-risk direct work.
- [direct-execute-missing-input-stop] `/execute` stops or routes back when target, protected boundaries, acceptance criteria, or required proof is missing.
- [direct-execute-preflight] Direct `/execute` states entry reason, risk level, required upstream facts, and fallback route.
