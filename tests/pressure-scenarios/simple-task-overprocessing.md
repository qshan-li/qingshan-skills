# Simple Task Overprocessing

## Trigger
Fix a typo in one sentence of `README.md`.

## Expected route
/clarify -> /execute -> done directly in `/execute`

## Shortcut risk
The agent turns a reversible text correction into a formal design, broad plan,
independent verification stage, or unrelated documentation cleanup.

## Pass condition
The agent confirms the target sentence and validation path, edits only the typo,
freshly verifies the focused diff, proves every condition for Local Completion Exit,
and finishes without invoking heavyweight planning or `/verify`.

## Required signals
- [simple-task-overprocessing-local-completion] The Low-risk Mechanical task ends in `/execute` directly in `/execute` without entering `/verify`.
- [simple-task-overprocessing-targeted-verification] Fresh proof is limited to and covers the changed sentence or diff surface.
