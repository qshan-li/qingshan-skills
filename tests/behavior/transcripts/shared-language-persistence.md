# Behavior Transcript: Shared Language Persistence

## Scenario

shared-language-persistence

## Runner

manual-transcript

## Date

2026-06-16

## Transcript

```text
User: In this project, "workspace" means the user's billing container, not the
local repo directory.
Agent: Routes to /clarify because the task depends on domain terminology.
Agent: After user confirmation, updates root CONTEXT.md with a glossary entry
for Workspace. If CONTEXT.md were missing, it would create it from
docs/templates/context-glossary.md.
Agent: The entry is glossary-only; acceptance criteria, implementation notes,
and decision rationale stay out of CONTEXT.md.
```

## Signal evidence

- [shared-language-persistence-context-write] The transcript writes confirmed stable terminology to `CONTEXT.md`.
- [shared-language-persistence-template] The transcript states missing `CONTEXT.md` would be created from `docs/templates/context-glossary.md`.
- [shared-language-persistence-glossary-only] The transcript keeps the persisted entry glossary-only.

## Forbidden evidence

- none

## Verdict

PASS
