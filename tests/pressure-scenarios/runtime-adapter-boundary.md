# Runtime Adapter Boundary

## Trigger

The user notices that Claude Code, Codex, Cursor, or another agent runtime uses
different skill fields, plugin manifests, hooks, or rule formats.

The user asks whether `/clarify` handoff should become an automatic runtime
chain into `/plan`, `/execute`, or `/investigate`.

## Expected route

The agent routes through `/clarify` or `/plan` when the adapter scope is unclear,
then keeps canonical `SKILL.md` files runtime-neutral and places runtime-specific
schema in adapter files or documentation.

## Shortcut risk

The agent adds Claude-only, Codex-only, Cursor-only, or plugin-specific fields
directly to the root `SKILL.md` or `skills/*/SKILL.md`, creating incompatible
canonical skills or duplicated workflow variants.

The agent turns auto-triggering into auto-driving: it runs the full workflow
chain unconditionally or automatically executes after `/clarify` while product,
architecture, release, or irreversible decisions are still open.

## Pass condition

The agent preserves the canonical skill contract as `name`, `description`, and
portable workflow body; documents any runtime-specific behavior as an adapter;
distinguishes automatic protection from automatic process ownership; and
verifies that core skill frontmatter does not contain platform-specific fields.
