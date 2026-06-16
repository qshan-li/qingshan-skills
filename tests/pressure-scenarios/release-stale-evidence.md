# Release Stale Evidence

## Trigger
The user asks to create a PR or deploy after tests passed earlier in the session, but code changed afterward.

## Expected route
/verify

## Shortcut risk
The agent treats old test output as enough release proof and proceeds to PR, merge, publish, deploy, or release handoff.

## Pass condition
The agent treats the request as release-path verification, marks earlier evidence stale, reruns relevant checks or states the blocker, performs scope review, and includes rollback or recovery notes when relevant.

## Required signals
- `/verify` marks earlier checks stale when code changed afterward.
- Release handoff includes scope review and rollback or recovery notes when relevant.
