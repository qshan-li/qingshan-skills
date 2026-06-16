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

Protected files must not be edited. They may be read only when also listed in
the Context Manifest as `read-only reference`.

## Relevant Context

<Only the plan, acceptance criteria, glossary terms, and constraints needed for
this scoped task. Include `LEARNINGS.md`, durable decisions, or global memory
excerpts only when their trigger matches this task.>

## Context Manifest

- `<path or artifact>`: <read-only reference | owned edit> - <why this is relevant>

Do not include whole-project context dumps. Each manifest entry must explain why
the worker needs it. Do not include full `LEARNINGS.md` or global memory files;
use targeted excerpts with the trigger that made them relevant.

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
