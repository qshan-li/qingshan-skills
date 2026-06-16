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
IDs to evidence.

Run:

```bash
bash scripts/validate-behavior-tests.sh
```

The validator checks artifact completeness only:

- the referenced pressure scenario exists
- the verdict is `PASS`, `FAIL`, or `BLOCKED`
- every required signal has evidence
- no transcript references unknown signal IDs
- critical workflow scenarios have at least one transcript

It does not judge prose quality or perform NLP matching. That keeps the test
stable and reviewable.

## Layer 4: Runtime Integration Tests

Runtime integration tests verify that a real host loads the root router and
workflow skills correctly. They can use Codex CLI, Claude Code, Cursor wrappers,
or an ACP adapter.

ACP is a transport and host-integration layer, not the core testing method. Add
an ACP runner only when cross-runtime behavior needs black-box coverage. Keep it
in the adapter layer and reuse the same pressure scenario signal IDs.

## Test Addition Workflow

1. Add or update a pressure scenario.
2. Give each required behavior a stable signal ID.
3. Add a transcript when a real or manual run should become regression evidence.
4. Run `bash scripts/validate-skills.sh`.
5. Review scope drift: no runtime-specific fields in canonical skill files, no
   plugin manifests unless a distribution decision approved them.
