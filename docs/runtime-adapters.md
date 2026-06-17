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
- trigger-based project or global memory retrieval
- runtime-specific subagent, fork, or context behavior
- prompt or rules wrappers for runtimes that do not read Agent Skills directly

Adapters must not:

- fork the meaning of `/clarify`, `/plan`, `/execute`, `/investigate`,
  `/verify`, or `/reflect`
- add runtime-specific frontmatter to canonical `SKILL.md` files
- duplicate the same workflow into separate Claude, Codex, or Cursor variants
- hide product, architecture, release, or irreversible decisions in adapter
  automation

## Automation Boundary

Runtime adapters may add automatic protection, not automatic process ownership.

Adapters may:

- detect the matching entry workflow from root routing and load the relevant
  skill
- enforce hard stops before editing without a clear target, evidence, or
  validation path
- continue across a handoff when the original user request asks the agent to
  complete the work, the risk is controlled, acceptance criteria are clear, and
  no User Challenge decision remains open
- require fresh verification before completion, release, merge, publish, or
  deployment claims

Adapters must not:

- run `/clarify -> /plan -> /execute -> /verify` unconditionally
- turn a `/clarify` handoff into automatic execution when product,
  architecture, release, or irreversible decisions remain
- hide stop-or-continue decisions from the user when automation changes risk,
  scope, ownership, or release exposure

Runtime automation protects workflow boundaries; it does not drive the whole
development process.

## Memory Retrieval Boundary

Runtime adapters may help implement the root Memory Retrieval Gate. They may
search project artifacts and global memory such as
`~/.qingshan-skills/memory/learnings.jsonl` for entries whose trigger matches
the task type, stack, risk, artifact, or failure mode.

Adapters must return targeted excerpts or artifact references, not full memory
dumps. Missing global memory is not a blocker. Adapter retrieval must not change
canonical workflow semantics, invent new memory rules, or continue past User
Challenge decisions.

## Workflow Breadcrumbs

Adapters may provide workflow-state breadcrumbs when the host supports hooks or
per-turn metadata. Breadcrumbs can record the selected route, current phase,
missing prerequisite, active task artifact, or required next proof.

Breadcrumbs may:

- remind the agent which workflow skill is active
- surface missing prerequisites before editing, releasing, or claiming completion
- point to task-local artifacts such as a plan, context manifest, or verification
  checklist
- help a runtime load the right wrapper or prompt

Breadcrumbs must not:

- fork the meaning of any canonical workflow skill
- make task creation mandatory for low-risk work
- silently continue past User Challenge decisions
- treat a hook, worker report, or manifest as completion proof

Workflow breadcrumbs are an adapter convenience. The portable source of truth
remains the root router, `ETHOS.md`, and the selected workflow skill.

## Bootstrap Wrapper

Runtimes that do not load Agent Skills directly should use a wrapper based on
`docs/templates/runtime-bootstrap.md`.

The wrapper should:

- load root `SKILL.md` before software engineering task work
- load `ETHOS.md` before applying a workflow skill
- select the lightest safe workflow from root routing
- load only the selected workflow skill until a handoff requires another one

This wrapper is an adapter. It must not copy and edit the canonical workflow
skills for a specific runtime.

## Runtime Map

| Runtime | Adapter surface | Use |
| --- | --- | --- |
| Claude Code | `~/.claude/skills`, `.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json` | Local skill loading, plugin marketplace distribution, optional Claude-only enhancements such as tool declarations, hooks, forked context, or subagents |
| Codex | `$CODEX_HOME/skills`, `.codex-plugin/plugin.json` | Local skill loading, plugin distribution, UI metadata, invocation policy, and dependency declarations |
| Cursor | `.cursor/rules/qingshan-skills.mdc` | Project rules with `alwaysApply: true` providing root router, ETHOS, and all six workflow skill summaries |
| Generic agents | `~/.agents/skills` | Local skill loading for runtimes that scan a personal skill folder (OpenCode, Gemini CLI, etc.) |

## Current Scope

The repository supports Claude Code, Codex, Cursor, and generic agent runtimes:

- **Claude Code and Codex**: `scripts/sync-global-skills.sh` or `./setup` links the canonical skill folders into both runtimes. Plugin manifests (`.claude-plugin/plugin.json`, `.codex-plugin/plugin.json`) enable marketplace and plugin-system distribution.
- **Cursor**: `.cursor/rules/qingshan-skills.mdc` provides a complete summary of the methodology as a project rule.
- **Generic agents**: `./setup` links skills into `~/.agents/skills/` for runtimes that scan that directory.

Runtime-specific fields, manifests, hooks, and UI metadata remain outside the canonical `SKILL.md` files.
