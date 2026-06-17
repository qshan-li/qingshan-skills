# Installation

qingshan-skills is runtime-neutral. Install it by making this repository available to the agent runtime that reads skills.

The canonical skill files are runtime-neutral and use only `name` and `description` frontmatter. Runtime-specific fields, plugin manifests, hooks, UI metadata, or rules wrappers belong in an adapter layer, not in the core `SKILL.md` files. See [runtime-adapters.md](runtime-adapters.md).

## Quick Install

Run the setup script from the repository root:

```bash
./setup
```

This validates the repository, then links the root skill and workflow skills into Claude Code, Codex, and generic agent directories. Use `--force` to replace existing links with a timestamped backup:

```bash
./setup --force
```

Use `--skip-validation` to skip the structure check:

```bash
./setup --skip-validation
```

## Claude Code

### Plugin Marketplace

Install via the Claude Code plugin marketplace:

```
/plugin marketplace add qshan-li/qingshan-skills
/plugin install qingshan-skills@qingshan-skills
```

### Manual Install

Use the sync script from the repository root:

```bash
bash scripts/sync-global-skills.sh
```

The script validates the repository, then links the root skill and workflow skills into:

- `~/.claude/skills/qingshan-skills`
- `~/.claude/skills/{clarify,plan,execute,investigate,verify,reflect}`

It is safe to re-run. If any target already exists and does not point to the expected qingshan-skills directory, the script exits without changing it. Use `--force` to move the existing target to a timestamped backup before linking:

```bash
bash scripts/sync-global-skills.sh --force
```

Set `CLAUDE_SKILLS_DIR` when Claude Code uses a non-default global directory.

## Codex

### Plugin Install

Install via the Codex plugin system using the `.codex-plugin/plugin.json` manifest in this repository.

### Manual Install

The sync script also links skills into Codex:

```bash
bash scripts/sync-global-skills.sh
```

Links are created at:

- `${CODEX_HOME:-$HOME/.codex}/skills/qingshan-skills`
- `${CODEX_HOME:-$HOME/.codex}/skills/{clarify,plan,execute,investigate,verify,reflect}`

Set `CODEX_SKILLS_DIR` or `CODEX_HOME` when Codex uses a non-default directory.

## Cursor

The repository includes a Cursor rules file at `.cursor/rules/qingshan-skills.mdc` with `alwaysApply: true`. This file provides a complete summary of the root router, ETHOS principles, and all six workflow skills.

To use qingshan-skills with Cursor:

1. Clone or symlink this repository into your project.
2. Cursor will automatically load the rules from `.cursor/rules/qingshan-skills.mdc`.

For projects that cannot include the full repository, copy the `.cursor/rules/qingshan-skills.mdc` file into your project's `.cursor/rules/` directory.

## Generic Agent Runtimes

For runtimes that scan a personal skill folder (OpenCode, Gemini CLI, etc.), the setup script creates symlinks at:

- `~/.agents/skills/qingshan-skills`
- `~/.agents/skills/{clarify,plan,execute,investigate,verify,reflect}`

Set `AGENTS_SKILLS_DIR` to override the default directory.

## Other Repositories

Keep the project in a normal workspace and reference the root `AGENTS.md` or `SKILL.md` from the agent session.

Use the root `SKILL.md` as the session bootstrap: load it before software engineering task work so it can route each request to the lightest applicable workflow.

## Environment Variables

| Variable | Default | Purpose |
| --- | --- | --- |
| `CLAUDE_SKILLS_DIR` | `~/.claude/skills` | Claude Code skills directory |
| `CODEX_SKILLS_DIR` | `~/.codex/skills` | Codex skills directory |
| `CODEX_HOME` | `~/.codex` | Codex base directory (used when `CODEX_SKILLS_DIR` is not set) |
| `AGENTS_SKILLS_DIR` | `~/.agents/skills` | Generic agent skills directory |

## Templates

The repository includes lightweight templates under [templates/](templates/) for recurring workflow artifacts:

- `decision-brief.md`
- `fresh-context-packet.md`
- `task-handoff.md` for `/clarify` or `/investigate` results that must survive context compression, agent handoff, or a `/plan` or `/execute` handoff
- `release-checklist.md`
- `durable-decision.md` for `/plan` approved durable decisions or `/reflect` backfill of unrecorded durable decisions
- `context-glossary.md` for `/clarify` creation of `CONTEXT.md`
- `runtime-bootstrap.md`

These templates are optional. Create an artifact only when the relevant workflow needs it.

## Verify

After installation, run:

```bash
bash scripts/validate-skills.sh
```

The validator checks required files, skill frontmatter, required sections, templates, prompt guardrails, plugin manifests, VERSION consistency, Cursor rules, and pressure scenarios with required behavior signals.
