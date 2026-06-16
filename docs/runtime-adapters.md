# Runtime Adapters

qingshan-skills has one canonical skill contract and separate runtime adapters.

The canonical contract is the repository root `SKILL.md` plus `skills/*/SKILL.md`.
Those files define the methodology and must stay portable across agent runtimes.
They use only the common Agent Skills frontmatter surface:

```yaml
---
name: <skill-name>
description: Use when <trigger conditions only>
---
```

Runtime-specific fields, manifests, hooks, and UI metadata belong outside the
canonical skill files. An adapter may make a runtime easier to install or use,
but it must not change the workflow semantics.

## Adapter Responsibilities

Adapters may provide:

- install paths and symlinks
- plugin manifests
- UI metadata and invocation policy
- tool or MCP dependency declarations
- hooks or lifecycle enforcement
- runtime-specific subagent, fork, or context behavior
- prompt or rules wrappers for runtimes that do not read Agent Skills directly

Adapters must not:

- fork the meaning of `/clarify`, `/plan`, `/execute`, `/investigate`,
  `/verify`, or `/reflect`
- add runtime-specific frontmatter to canonical `SKILL.md` files
- duplicate the same workflow into separate Claude, Codex, or Cursor variants
- hide product, architecture, release, or irreversible decisions in adapter
  automation

## Runtime Map

| Runtime | Adapter surface | Use |
| --- | --- | --- |
| Claude Code | `~/.claude/skills`, optional `.claude-plugin/plugin.json`, Claude-specific wrappers | Local skill loading and optional Claude-only enhancements such as tool declarations, hooks, forked context, or subagents |
| Codex | `$CODEX_HOME/skills`, `.agents/skills`, optional `.codex-plugin/plugin.json`, optional `agents/openai.yaml` | Local skill loading, plugin distribution, UI metadata, invocation policy, and dependency declarations |
| Cursor | Project rules or prompt wrapper | Make the root router and six workflows visible to Cursor without changing the canonical Agent Skills files |

## Current Scope

The repository currently supports local Claude Code and Codex installation through
`scripts/sync-global-skills.sh`. That script links the canonical skill folders
into both runtimes.

Do not add `.claude-plugin` or `.codex-plugin` until there is a real
distribution need, such as publishing a plugin, bundling MCP configuration,
declaring hooks, or sharing a stable package with other users.
