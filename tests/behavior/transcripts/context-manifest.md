# Behavior Transcript: Context Manifest

## Scenario

context-manifest

## Runner

manual-transcript

## Date

2026-06-16

## Transcript

```text
User: Delegate one cross-module implementation slice to a fresh-context worker.
Agent: Runs the /execute Context Gate and creates a fresh-context packet from
docs/templates/fresh-context-packet.md before delegation.
Agent: The packet lists owned files under src/search/ and tests/search/, and
protected files under src/auth/ and deployment config.
Agent: The context manifest names each reference file and why it is needed:
plan.md for acceptance criteria, CONTEXT.md for glossary terms, and
src/search/index.ts as the owned implementation surface.
Agent: During /verify, the worker report is checked against the actual diff and
the referenced test command output before any completion claim.
```

## Signal evidence

- [context-manifest-owned-files] The transcript lists owned files and protected files before delegation.
- [context-manifest-relevance] The transcript explains why each manifest entry is relevant.
- [context-manifest-artifact-review] The transcript checks the worker report against the actual diff and command output during `/verify`.

## Forbidden evidence

- none

## Verdict

PASS
