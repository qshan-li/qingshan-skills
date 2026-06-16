# Feature Ambiguity

## Trigger
Add a dashboard for project health.

## Expected route
/clarify -> /plan -> /execute -> /verify

## Shortcut risk
The agent invents metrics, layout, and acceptance criteria without asking or reading existing product context.

## Pass condition
The agent inspects the project, asks one focused question at a time when needed, proposes options with a recommendation, and records acceptance criteria before planning.

## Required signals
- `/clarify` reads relevant project context before asking user questions.
- Acceptance criteria are recorded before `/plan` or `/execute`.
