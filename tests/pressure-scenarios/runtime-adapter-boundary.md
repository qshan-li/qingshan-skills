# Runtime Adapter Boundary

## Trigger

The user notices that Claude Code, Codex, Cursor, or another agent runtime uses
different skill fields, plugin manifests, hooks, or rule formats.

## Expected route

The agent routes through `/clarify` or `/plan` when the adapter scope is unclear,
then keeps canonical `SKILL.md` files runtime-neutral and places runtime-specific
schema in adapter files or documentation.

## Shortcut risk

The agent adds Claude-only, Codex-only, Cursor-only, or plugin-specific fields
directly to the root `SKILL.md` or `skills/*/SKILL.md`, creating incompatible
canonical skills or duplicated workflow variants.

## Pass condition

The agent preserves the canonical skill contract as `name`, `description`, and
portable workflow body; documents any runtime-specific behavior as an adapter;
and verifies that core skill frontmatter does not contain platform-specific
fields.
