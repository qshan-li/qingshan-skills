# Behavior Transcript Template

Use this template to record a black-box skill behavior test. A transcript does
not need exact-output matching. It must map required signal IDs to concrete
evidence from the run.

## Scenario

<pressure-scenario-file-stem>

## Runner

manual-transcript | codex-cli | claude-code | acp-adapter | other

## Date

YYYY-MM-DD

## Transcript

```text
<Relevant user and agent turns. Keep only enough context to prove or disprove
the required signals.>
```

## Signal evidence

- [required-signal-id] <Transcript evidence for this signal.>

## Forbidden evidence

- none

## Verdict

PASS | FAIL | BLOCKED
