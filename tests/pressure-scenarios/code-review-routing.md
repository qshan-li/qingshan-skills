# Code Review Routing

## Trigger

The user asks the agent to review a diff, PR, implementation, or spec compliance
without requesting new implementation work.

## Expected route

/verify

## Shortcut risk

The agent treats review as a vague clarification request, starts implementing
fixes, or reports opinions without scope drift, quality, evidence, and residual
risk checks.

## Pass condition

The root router sends review requests to `/verify`; `/verify` compares intent
against the diff or artifact, reports scope and quality review notes, and avoids
editing unless a later `/execute` handoff is required.

## Required signals

- [code-review-routes-verify] Code review, PR/diff review, implementation review, or spec review routes to `/verify`.
- [code-review-no-implementation] The review reports findings or residual risk without silently making implementation changes.
