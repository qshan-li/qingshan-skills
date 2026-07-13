# Installation

qingshan-skills is runtime-neutral. Install it by making this repository available to the agent runtime that reads skills.

The canonical skill files are runtime-neutral and use only `name` and `description` frontmatter. Runtime-specific fields, plugin manifests, hooks, UI metadata, or rules wrappers belong in an adapter layer, not in the core `SKILL.md` files. See [runtime-adapters.md](runtime-adapters.md).

## Quick Install

Repository validation requires Bash and `jq`.

Run the setup script from the repository root:

```bash
./setup
```

This validates the repository, then links the root skill and workflow skills into Claude Code, Codex, and generic agent directories. Use `--force` to replace existing links with a timestamped backup:

```bash
./setup --force
```

Installation fails on the first conflicting target unless `--force` is used;
it does not report success after a partial installation. `setup` delegates to
the same implementation as `scripts/sync-global-skills.sh`.

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

Install via the Codex plugin system using the `.codex-plugin/plugin.json`
manifest in this repository. `skills/qingshan-skills/SKILL.md` is a thin plugin
adapter that loads the canonical root `SKILL.md` and `ETHOS.md`.

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

Cursor project rules load from the **consumer project's** `.cursor/rules`, not
from an arbitrary nested clone. The adapter is a thin always-apply rule that
resolves a **skills root** and then reads canonical files from that root.

### Recommended layout

1. Keep one full clone of this repository on disk, for example:
   - the clone you already use for development, or
   - `~/.qingshan-skills/repo` (clone or symlink the full repository there)
2. Install a project rule into each consumer project with an absolute baked path:

```bash
bash scripts/install-cursor-project-rule.sh /path/to/consumer-project
# if a different rule already exists:
bash scripts/install-cursor-project-rule.sh --force /path/to/consumer-project
```

Installing into the qingshan-skills repository itself is a no-op so the template
is never truncated. Existing different rules fail closed unless `--force` moves
them to `.qingshan-skills-backups/`.

3. Optionally also export the same absolute path:

```bash
export QINGSHAN_SKILLS_ROOT=/absolute/path/to/qingshan-skills
```

### Resolution order inside the rule

The installed rule resolves the skills root in this order:

1. `QINGSHAN_SKILLS_ROOT`
2. the absolute path baked by `install-cursor-project-rule.sh`
3. `~/.qingshan-skills/repo` when it contains the full repository
4. the current workspace root only when it is clearly the qingshan-skills repo

Copying only `.cursor/rules/qingshan-skills.mdc` without a resolvable skills root
is insufficient. Remote import of the `.mdc` alone is also insufficient unless
one of the skills-root candidates above exists on the machine.

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
