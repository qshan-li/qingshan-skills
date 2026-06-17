# Behavior Transcript: Reflect Promotion Artifact Map

## Scenario

reflect-promotion-artifact-map

## Runner

manual-transcript

## Date

2026-06-16

## Transcript

```text
User: Verified work revealed a recurring project pitfall and a separate durable
architecture decision.
Agent: Routes /verify -> /reflect and applies the Promotion Decision Matrix
first: the pitfall is not temporary task state or glossary context; it is a
recurring repo-specific pitfall with a trigger, so the promotion layer is
project learning.
Agent: /reflect applies the Promotion Artifact Map before writing anything.
Agent: The project pitfall goes to LEARNINGS.md because it is recurring inside
this repo; the durable decision goes to DECISIONS.md because it preserves chosen
direction; CONTEXT.md is left untouched because there is no glossary term.
Agent: The agent does not mix task state, glossary terms, project learning,
global memory, skill rules, or durable decisions in one generic notes file.
```

## Signal evidence

- [reflect-promotion-decision-matrix] The transcript applies the Promotion Decision Matrix before choosing the write target.
- [reflect-promotion-map-used] The transcript applies the Promotion Artifact Map before writing memory.
- [reflect-promotion-target-specific] The transcript selects specific artifacts for project learning and durable decision layers.
- [reflect-promotion-no-pollution] The transcript avoids mixing task state, glossary, learning, global memory, skill rules, and durable decisions in one artifact.

## Forbidden evidence

- none

## Verdict

PASS
