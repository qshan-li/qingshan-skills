# Release Verification Checklist Template

Use inside `/verify` for ship, deploy, publish, PR, merge, release, or handoff
requests. This is not a separate `/ship` workflow.

## Claim

<What release or handoff claim is about to be made?>

## Fresh Evidence

- tests: fresh evidence | stale evidence | skipped with reason | blocked | not applicable
- type check: fresh evidence | stale evidence | skipped with reason | blocked | not applicable
- build: fresh evidence | stale evidence | skipped with reason | blocked | not applicable
- manual smoke check: fresh evidence | stale evidence | skipped with reason | blocked | not applicable

## Review Staleness

- implementation review: fresh evidence | stale evidence | skipped with reason | blocked | not applicable
- scope review: fresh evidence | stale evidence | skipped with reason | blocked | not applicable
- release approval or handoff owner: fresh evidence | stale evidence | skipped with reason | blocked | not applicable

## Scope Review

- Delivered:
- Missing:
- Extra:
- Changed:
- Unverifiable:

## Commit Or PR Hygiene

- branch status:
- uncommitted changes:
- commit range or PR diff:
- linked issue, changelog, or release note:

## Release Or Handoff Risk

<Rollback, recovery, environment boundary, or residual risk.>

## Release Action Boundary

- requested action:
- readiness status: Ready | ready with stated risk | blocked | not ready
- Taste approval status: approved | blocked | not applicable
- residual User Challenge risk: accepted | blocked | not applicable
- release action status: not attempted | succeeded | failed | handed off
- action result or handoff detail:

Release-action failure (auth, credentials, merge conflict, remote rejection, or
handoff refusal) is separate from implementation verification failure when
readiness already passed.

## Status

<Ready, ready with stated risk, blocked, or not ready. When a release action was
requested, also report release action status.>
