# Behavior Transcript Template

Use this template to record a skill contract artifact. A transcript does not
need exact-output matching. It must map required signal IDs to concrete evidence
from the run; only non-manual runner output counts as black-box runtime evidence.

## Scenario

<pressure-scenario-file-stem>

## Runner

manual-transcript | codex-cli | claude-code | acp-adapter | other

## Command

<Exact runner command for non-manual transcripts, or `not applicable`.>

## Runtime Version

<Host and model/runtime version for non-manual transcripts, or `not applicable`.>

## Date

YYYY-MM-DD

## Transcript

```text
<Raw relevant user and agent turns. Keep only enough context to prove or
disprove the required signals. Do not rewrite runtime output into idealized
behavior.>
```

## Signal evidence

- [required-signal-id] <Transcript evidence for this signal.>

## Forbidden evidence

- none

## Verdict

PASS | FAIL | BLOCKED
