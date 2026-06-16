# Behavior Transcript: Memory Consumption Contract

## Scenario

memory-consumption-contract

## Runner

manual-transcript

## Date

2026-06-16

## Transcript

```text
User: Verified work revealed a recurring project pitfall: release checks fail
when behavior transcripts are added without updating validator coverage.
Agent: Routes /verify -> /reflect. It applies the Promotion Artifact Map and
Consumption Contract before writing memory.
Agent: The project learning goes to LEARNINGS.md. Future reader: /plan and
/verify. Trigger: tasks that add or change behavior transcripts, pressure
scenarios, or behavior validator coverage.
Agent: A separate cross-project lesson is only eligible for
~/.qingshan-skills/memory/learnings.jsonl because it has trigger "When a skill
repository stores behavior contracts as transcript artifacts"; lesson, scope,
evidence, date, and source are included.

User: Now plan a task that adds another behavior transcript.
Agent: Root bootstrap applies trigger-based retrieval. It reads the matching
LEARNINGS.md entry and the matching global memory excerpt, records both under
Referenced Memory in the task handoff, and does not dump all of LEARNINGS.md or
the full global jsonl file.
Agent: /plan uses the referenced learning to add validator coverage before
execution. /verify later checks that the relevant learning was honored.
```

## Signal evidence

- [memory-consumption-contract-used] The transcript names future readers and triggers for the project learning and global memory.
- [global-memory-trigger-required] The transcript writes or reads global memory only because a clear trigger matches the task.
- [project-learning-read-when-relevant] The transcript reads `LEARNINGS.md` when planning another behavior transcript task.
- [no-unbounded-memory-dump] The transcript records targeted excerpts and explicitly avoids full `LEARNINGS.md` or global jsonl dumps.

## Forbidden evidence

- none

## Verdict

PASS
