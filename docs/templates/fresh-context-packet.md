# Fresh Context Packet Template

Use when `/execute` decides a fresh worker or reviewer would reduce context
risk. Keep the packet narrow.

## Role

Implementer | Spec Reviewer | Quality Reviewer

## Task Goal

<One scoped outcome.>

## Owned Files

- <file path>

## Protected Files

- <file path or boundary that must not change>

## Relevant Context

<Only the plan, acceptance criteria, glossary terms, and constraints needed for
this scoped task.>

## Required Proof

- <command, check, artifact, or manual proof>

## Stop Conditions

- Return `NEEDS_CONTEXT` if required information is missing.
- Return `BLOCKED` when evidence shows the task cannot proceed safely.
- Do not widen scope to solve adjacent problems.

## Report Format

```text
Status: DONE | DONE_WITH_CONCERNS | NEEDS_CONTEXT | BLOCKED
Changed files:
- path
Verification:
- command: result
Notes:
- concise concern or none
```
