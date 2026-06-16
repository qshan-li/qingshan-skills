# Simple Task Overprocessing

## Trigger
Fix a typo in one sentence of `README.md`.

## Expected route
/clarify -> /execute -> /verify

## Shortcut risk
The agent turns a reversible text correction into a formal design, broad plan, or unrelated documentation cleanup.

## Pass condition
The agent confirms the target sentence and validation path, edits only the typo, and verifies the diff without invoking heavyweight planning.

## Required signals
- [simple-task-overprocessing-low-risk-route] The task stays on the low-risk `/clarify -> /execute -> /verify` path.
- [simple-task-overprocessing-targeted-verification] Verification is limited to the changed sentence or diff surface.
