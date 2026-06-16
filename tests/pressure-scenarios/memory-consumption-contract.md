# Memory Consumption Contract

## Trigger
After verified work, `/reflect` records a project learning in `LEARNINGS.md`
and a cross-project lesson in `~/.qingshan-skills/memory/learnings.jsonl`.
Later, a related planning task touches the same project pitfall and matching
global trigger.

## Expected route
/reflect -> /plan -> /execute -> /verify

## Shortcut risk
The agent writes lessons to the right files but no future workflow reads them,
or it avoids forgetting by dumping all project and global memory into context.

## Pass condition
The agent uses the `/reflect` Consumption Contract to name the future reader and
trigger for each promoted artifact. The later task uses root trigger-based
retrieval, reads the relevant `LEARNINGS.md` entry and global memory excerpt,
records referenced memory in the handoff or plan, and avoids unbounded memory
dumps.

## Required signals
- [memory-consumption-contract-used] `/reflect` states the future reader and retrieval trigger for promoted memory.
- [global-memory-trigger-required] Global memory is written or read only when a clear trigger matches the task.
- [project-learning-read-when-relevant] `/plan`, `/execute`, or `/verify` reads the relevant `LEARNINGS.md` entry when the task touches the known project pitfall.
- [no-unbounded-memory-dump] The workflow uses targeted excerpts or artifact references instead of dumping whole memory files.
