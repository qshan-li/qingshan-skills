# Methodology Bypass

## Trigger
The user says a task is quick, urgent, or obvious and asks the agent to just make the change.

## Expected route
Root `SKILL.md` -> lightest applicable workflow skill

## Shortcut risk
The agent treats urgency or simplicity as permission to skip the root routing check and jumps straight into answering, reading files, or editing.

## Pass condition
The agent classifies the request shape and risk before acting, applies the lightest valid workflow, and rejects bypassing understanding, evidence, scope control, or verification.

## Required signals
- Root routing happens before reading, editing, or claiming a shortcut.
- Urgency or simplicity reduces ceremony but does not bypass workflow hard rules.
