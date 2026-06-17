# Testing qingshan-skills

qingshan-skills tests the methodology in layers. Use the lightest layer that can
prove the contract being changed.

## Layer 1: Structure Checks

Structure checks verify the repository shape, skill frontmatter, required
sections, templates, prompt guardrails, and pressure scenario format.

Run:

```bash
bash scripts/validate-skills.sh
```

This layer is deterministic and should run after every change.

## Layer 2: Pressure Scenario Contracts

Pressure scenarios describe where an agent is likely to take a shortcut. Each
scenario must define stable `Required signals` with IDs:

```markdown
- [example-signal-id] Observable behavior that must appear.
```

These contracts are not transcripts. They define what a later behavior run must
prove.

## Layer 3: Transcript Behavior Tests

Transcript tests record a manual or runtime agent run and map required signal
IDs to evidence. They are behavior contracts, not black-box runtime proof.

Run:

```bash
bash scripts/validate-behavior-tests.sh
```

The validator checks artifact completeness and required scenario coverage:

- the referenced pressure scenario exists
- the verdict is `PASS`, `FAIL`, or `BLOCKED`
- every required signal has evidence
- no transcript references unknown signal IDs
- every pressure scenario has at least one `PASS` transcript

`FAIL` and `BLOCKED` transcripts may be kept as historical evidence, but they do
not satisfy pressure scenario coverage.

It does not judge prose quality, perform NLP matching, or prove that a hosted
agent runtime will make the same routing choice. That keeps the test stable and
reviewable.

## Layer 4: Runtime Integration Tests

Runtime integration tests verify that a real host loads the root router and
workflow skills correctly. They can use Codex CLI, Claude Code, Cursor wrappers,
or an ACP adapter.

The current smoke wrapper uses Codex CLI as the smallest black-box check. It
runs read-only route-selection prompts against the real host. Each final
response must be exactly one non-empty `ROUTE:` line, and the wrapper checks
only that route line across the route shapes covered by root `SKILL.md`:

- new feature work routes through `/clarify`
- bug reports route through `/investigate`
- clarified work needing sequencing routes through `/plan`
- dependency or toolchain upgrades route through `/plan`
- unclear test-system improvements route through `/investigate`
- clear planned documentation edits route through `/execute` and `/verify`
- review requests route through `/verify`
- completion claims route through `/verify`
- release requests route through `/verify`
- reusable learning routes through `/reflect`

ACP is a transport and host-integration layer, not the core testing method. Add
an ACP runner only when cross-runtime behavior needs black-box coverage. Keep it
in the adapter layer and reuse the same pressure scenario signal IDs.

Run the optional smoke wrapper when host credentials and runtime cost are
acceptable:

```bash
QINGSHAN_RUNTIME_SMOKE=1 bash scripts/validate-runtime-smoke.sh
```

Without `QINGSHAN_RUNTIME_SMOKE=1`, the script reports `SKIP` and exits
successfully. Runtime smoke tests must stay outside `validate-skills.sh` so core
methodology validation remains deterministic and does not depend on a hosted
agent runtime.

## Test Addition Workflow

1. Add or update a pressure scenario.
2. Give each required behavior a stable signal ID.
3. Add a transcript when a real or manual run should become regression evidence.
4. Run `bash scripts/validate-skills.sh`.
5. Review scope drift: no runtime-specific fields in canonical skill files, no
   plugin manifests unless a distribution decision approved them.
