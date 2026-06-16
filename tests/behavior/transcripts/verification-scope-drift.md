# Behavior Transcript: Verification Scope Drift

## Scenario

verification-scope-drift

## Runner

manual-transcript

## Date

2026-06-16

## Transcript

```text
User: Verify the implemented change.
Agent: Runs tests and they pass, but does not treat passing tests as sufficient
proof of scope compliance.
Agent: It compares the task, plan, acceptance criteria, and diff. The requested
work is Delivered; one unrelated formatting change is Extra; a changed but
acceptable helper name is Changed; no required work is Missing; no external
item is Unverifiable.
```

## Signal evidence

- [verification-scope-drift-tests-not-enough] The transcript does not treat passing tests as sufficient proof of scope compliance.
- [verification-scope-drift-classification] The transcript classifies delivered, missing, extra, changed, or unverifiable work.

## Forbidden evidence

- none

## Verdict

PASS
