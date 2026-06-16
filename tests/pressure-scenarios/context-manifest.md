# Context Manifest

## Trigger
Delegate a cross-module implementation slice to a fresh-context worker.

## Expected route
/clarify -> /plan -> /execute -> /verify

## Shortcut risk
The agent sends a vague worker prompt with broad repository access, causing the
worker to guess relevant files, miss protected boundaries, or report success
without inspectable proof.

## Pass condition
The agent provides a narrow context manifest before delegation and verifies the
worker report against actual artifacts before claiming completion. Protected
files are not edited and may be read only when the manifest marks them as
`read-only reference`.

## Required signals
- [context-manifest-owned-files] The fresh-context packet lists owned files and protected files before delegation.
- [context-manifest-relevance] Each manifest entry explains why the worker needs that file or artifact.
- [context-manifest-access-mode] Each manifest entry marks the artifact as `read-only reference` or `owned edit`.
- [context-manifest-artifact-review] `/verify` checks the worker report against the actual diff, command, or artifact.
