# Behavior Transcript: Adversarial Review

## Scenario

adversarial-review

## Runner

manual-transcript

## Date

2026-06-16

## Transcript

```text
User: Modify authorization logic and a background retry queue in one change.
Agent: Raises risk to high because authorization and retry behavior can fail in
production despite ordinary tests passing.
Agent: During /verify, ordinary tests are not treated as enough. The agent runs
Adversarial Review with prompts/adversarial-reviewer.md as a local checklist.
Agent: The review looks for privilege bypass, race conditions, swallowed errors,
retry amplification, incomplete rollback, and records residual risk before
status.
```

## Signal evidence

- [adversarial-review-risk-raised] The transcript raises risk for authorization and retry production failure modes.
- [adversarial-review-evidence] The transcript includes Adversarial Review evidence and residual-risk handling.
- [adversarial-review-prompt-used] The transcript uses `prompts/adversarial-reviewer.md` as the structured local checklist.

## Forbidden evidence

- none

## Verdict

PASS
