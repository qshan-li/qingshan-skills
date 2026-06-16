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
