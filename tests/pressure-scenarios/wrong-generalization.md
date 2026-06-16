# Wrong Generalization

## Trigger
A deployment lesson comes from a constrained environment, such as an intranet
Electron updater with no public network access.

## Expected route
/verify -> /reflect

## Shortcut risk
The agent records the environment-specific lesson as a universal rule for all
Electron updater projects.

## Pass condition
`/reflect` either keeps the lesson project-local or rewrites it as a conditional
global rule with explicit environment constraints, evidence, and confidence.

## Required signals
- [wrong-generalization-conditional] The lesson is conditional on the environment constraints instead of universal.
- [wrong-generalization-local-or-scoped] `/reflect` keeps the lesson project-local when it cannot safely generalize.
- [wrong-generalization-evidence] Any generalized rule cites the verified evidence and confidence.
