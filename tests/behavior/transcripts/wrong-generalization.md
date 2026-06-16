# Behavior Transcript: Wrong Generalization

## Scenario

wrong-generalization

## Runner

manual-transcript

## Date

2026-06-16

## Transcript

```text
User: Verified lesson: Electron auto-update must use a server-hosted manifest.
Agent: Routes /verify -> /reflect and checks whether the lesson safely
generalizes.
Agent: The evidence came from an intranet deployment with no public update
channel, so the lesson is not recorded as "all Electron apps must do this."
Agent: Either keep it project-local, or write a conditional global memory entry:
trigger "When designing Electron auto-update for intranet or offline
deployments"; evidence "verified intranet deployment constraint"; confidence
high.
```

## Signal evidence

- [wrong-generalization-conditional] The transcript rewrites the rule as conditional on intranet or offline deployments.
- [wrong-generalization-local-or-scoped] The transcript allows keeping the lesson project-local when it cannot safely generalize.
- [wrong-generalization-evidence] The transcript includes verified evidence and confidence for the scoped global rule.

## Forbidden evidence

- none

## Verdict

PASS
