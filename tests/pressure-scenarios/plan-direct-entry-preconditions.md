# Plan Direct Entry Preconditions

## Trigger

The root router sends a dependency upgrade, toolchain upgrade, CI change, or
other blast-radius task directly to `/plan`.

## Expected route

/plan -> /execute -> /verify

## Shortcut risk

The agent assumes `/clarify` already produced acceptance criteria and plans
implementation around missing target, boundaries, or validation details.

## Pass condition

`/plan` establishes a direct-entry lightweight target, acceptance criteria,
protected boundaries, and validation path before decomposing work; it routes to
`/clarify` or `/investigate` when those prerequisites cannot be established.

## Required signals

- [plan-direct-entry-target] `/plan` creates or reuses a lightweight target statement for direct entry.
- [plan-direct-entry-prerequisite-route] `/plan` routes to `/clarify` or `/investigate` when acceptance criteria or required evidence is missing.
