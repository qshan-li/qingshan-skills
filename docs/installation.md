# Installation

qingshan-skills is runtime-neutral. Install it by making this repository available to the agent runtime that reads skills.

## Claude Code and Codex

Use the sync script from the repository root:

```bash
bash scripts/sync-global-skills.sh
```

The script validates the repository, then links the root skill and workflow skills into:

- `~/.claude/skills/qingshan-skills`
- `~/.claude/skills/{clarify,plan,execute,investigate,verify,reflect}`
- `${CODEX_HOME:-$HOME/.codex}/skills/qingshan-skills`
- `${CODEX_HOME:-$HOME/.codex}/skills/{clarify,plan,execute,investigate,verify,reflect}`

It is safe to re-run. If any target already exists and does not point to the expected qingshan-skills directory, the script exits without changing it. Use `--force` to move the existing target to a timestamped backup before linking:

```bash
bash scripts/sync-global-skills.sh --force
```

Set `CLAUDE_SKILLS_DIR`, `CODEX_SKILLS_DIR`, or `CODEX_HOME` when a runtime uses non-default global directories.

## Other repositories

Keep the project in a normal workspace and reference the root `AGENTS.md` or `SKILL.md` from the agent session.

Use the root `SKILL.md` as the session bootstrap: load it before software engineering task work so it can route each request to the lightest applicable workflow.

## Personal agent directories

For runtimes that scan a personal skill folder, symlink the repository:

```bash
ln -s /path/to/qingshan-skills ~/.agents/skills/qingshan-skills
```

## Verify

After installation, run:

```bash
bash scripts/validate-skills.sh
```

The validator checks required files, skill frontmatter, required sections, and pressure scenarios.
