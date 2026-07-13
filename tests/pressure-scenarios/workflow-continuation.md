# Workflow Continuation

## Trigger
An agent finishes one workflow stage while the original request may cover either
the current stage only or the complete engineering outcome.

## Expected route
Continue inside the approved route for complete requests; stop after a
phase-only invocation or when a root stop condition applies.

## Shortcut risk
The agent either interrupts every routine handoff or auto-continues through an
open Taste batch, User Challenge, missing evidence, or expanded scope.

## Pass condition
The agent distinguishes complete-outcome requests from phase-only invocations,
continues across routine handoffs only inside the original boundary, and stops
for open or changed Taste decisions, User Challenge decisions, missing
prerequisites, blockers, or scope changes.

## Required signals
- [workflow-continuation-complete-outcome] A complete-outcome request continues across a routine workflow handoff.
- [workflow-continuation-phase-only-stop] A direct invocation limited to the current stage returns control after that stage.
- [workflow-continuation-root-stop] Open or changed Taste, User Challenge, missing evidence, blockers, or expanded scope stop continuation.
