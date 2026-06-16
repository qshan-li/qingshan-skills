# Installation

qingshan-skills is runtime-neutral. Install it by making this repository available to the agent runtime that reads skills.

## Codex-style repositories

Keep the project in a normal workspace and reference the root `AGENTS.md` or `SKILL.md` from the agent session.

## Claude-style skill directories

Copy or symlink the repository into a skill directory used by the runtime:

```bash
ln -s /path/to/qingshan-skills ~/.claude/skills/qingshan-skills
```

## Personal agent directories

For runtimes that scan a personal skill folder, copy or symlink the repository:

```bash
ln -s /path/to/qingshan-skills ~/.agents/skills/qingshan-skills
```

## Verify

After installation, run:

```bash
bash scripts/validate-skills.sh
```

The validator checks required files, skill frontmatter, required sections, and pressure scenarios.
