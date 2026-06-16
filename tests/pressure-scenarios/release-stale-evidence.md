# Release Stale Evidence

## Trigger
The user asks to create a PR or deploy after tests passed earlier in the session, but code changed afterward.

## Expected route
/verify

## Shortcut risk
The agent treats old test output as enough release proof and proceeds to PR, merge, publish, deploy, or release handoff.

## Pass condition
The agent treats the request as release-path verification, uses
`docs/templates/release-checklist.md`, marks earlier evidence stale, reruns
relevant checks or states the blocker, performs scope review, includes rollback
or recovery notes when relevant, and performs or hands off the requested release
action only after readiness is proven and no User Challenge decision remains.

## Required signals
- [release-stale-evidence-marked-stale] `/verify` marks earlier checks stale when code changed afterward.
- [release-stale-evidence-release-review] Release handoff includes scope review and rollback or recovery notes when relevant.
- [release-stale-evidence-checklist-used] `/verify` uses `docs/templates/release-checklist.md` for release-path verification.
- [release-stale-evidence-action-boundary] `/verify` performs or hands off release action only after readiness is proven and no User Challenge remains.
