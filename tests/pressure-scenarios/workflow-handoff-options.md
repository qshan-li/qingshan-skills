# Workflow Handoff Options

## Trigger

A workflow finishes and root `Workflow Continuation` requires returning control
while one or more valid next workflows are known.

## Expected route

Keep automatic continuation unchanged. For a stopping handoff, present the
recommended valid route first through the strongest native interactive channel,
or fall back to numbered or labeled conversational choices that do not require
typing a skill command.

## Shortcut risk

The agent either prints bare `/skill` names that the user must manually invoke,
opens a prompt during an authorized automatic handoff, offers a blocked route,
or treats navigation selection as approval for an unresolved Taste or User
Challenge decision.

## Pass condition

Stopping handoffs surface only valid next-workflow options, prefer native
selection, provide a no-command fallback, preserve automatic continuation, and
keep decision approval gates intact.

## Required signals

- [workflow-handoff-options-native-channel] A stopping handoff uses the strongest native interactive channel when one is available.
- [workflow-handoff-options-recommended-first] The recommended valid next workflow appears first and blocked routes are omitted.
- [workflow-handoff-options-no-manual-command] A runtime without native selection offers numbered or labeled choices that do not require typing a skill command.
- [workflow-handoff-options-continuation-boundary] An authorized automatic handoff continues without opening a selection prompt.
- [workflow-handoff-options-approval-boundary] Selecting a next workflow does not approve an unresolved Taste or User Challenge decision.
