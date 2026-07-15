# Runtime Adapters

qingshan-skills has one canonical skill contract and separate runtime adapters.

The canonical contract is the repository root `SKILL.md` plus the six workflow
files under `skills/{clarify,plan,execute,investigate,verify,reflect}/SKILL.md`.
`skills/qingshan-skills/SKILL.md` is a thin plugin adapter, not another canonical
workflow definition. The canonical files define the methodology and must stay portable across agent runtimes.
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
- native UI rendering for canonical stopping-handoff options

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
  every Taste decision is explicitly approved with no root
  `Workflow Continuation` stop condition left open
- render valid stopping-handoff routes through native selection controls, with
  the canonical recommended route first
- require fresh verification before completion, release, merge, publish, or
  deployment claims

Adapters must not:

- run `/clarify -> /plan -> /execute -> /verify` unconditionally
- turn a `/clarify` handoff into automatic execution when product,
  architecture, release, irreversible, or unapproved Taste decisions remain
- treat a workflow invocation, silence, or lack of objection as Taste approval
- hide stop-or-continue decisions from the user when automation changes risk,
  scope, ownership, or release exposure
- open a handoff selection prompt when canonical `Workflow Continuation`
  authorizes automatic continuation
- require users to type canonical skill commands when the host can provide
  native or labeled selection

Runtime automation protects workflow boundaries; it does not drive the whole
development process.

When a stopping handoff has valid next routes, adapters should map the canonical
labels, recommendation order, and impact descriptions to the host's strongest
interactive input surface. Hosts without native selection should preserve the
same choices as numbered or labeled conversational input. Adapter UI must not
offer blocked routes or treat navigation selection as approval for unresolved
Taste or User Challenge decisions.

## Native Handoff Channels

The qingshan-skills plugin adapter defines the preferred native channel for the
two primary interactive runtimes:

- Claude Code calls `AskUserQuestion` before prose, with one question and two to
  four options.
- Codex calls `request_user_input` before prose, with one question and the valid
  route options supported by the host.

Both runtimes put the recommended valid route first, omit blocked routes, and
skip the native prompt when canonical `Workflow Continuation` authorizes an
automatic handoff. A tool failure may fall back to labeled conversation, but a
plain recommendation paragraph is not the preferred first action.

## Memory Retrieval Boundary

Runtime adapters may help implement the root Memory Retrieval Gate. They may
search project artifacts and global memory such as
`~/.qingshan-skills/memory/learnings.jsonl` for entries whose trigger matches
the task type, stack, risk, artifact, or failure mode.

Adapters must return targeted excerpts or artifact references, not full memory
dumps. Missing global memory is not a blocker. Adapter retrieval must not change
canonical workflow semantics, invent new memory rules, or continue past User
Challenge decisions or open Taste approval gates.

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
- silently continue past open Taste or User Challenge decisions
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
| Claude Code | `~/.claude/skills`, `.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json`, `skills/qingshan-skills/SKILL.md` | Local skill loading, plugin distribution, and `AskUserQuestion` mapping for stopping handoffs |
| Codex | `$CODEX_HOME/skills`, `.codex-plugin/plugin.json`, `skills/qingshan-skills/SKILL.md` | Local skill loading plus `request_user_input` mapping for stopping handoffs |
| Cursor | Consumer `.cursor/rules/qingshan-skills.mdc` via `scripts/install-cursor-project-rule.sh` | An `alwaysApply: true` bootstrap wrapper that resolves `QINGSHAN_SKILLS_ROOT` / baked path / `~/.qingshan-skills/repo`, then reads the canonical root router, ETHOS, and selected workflow skill |
| Generic agents | `~/.agents/skills` | Local skill loading for runtimes that scan a personal skill folder (OpenCode, Gemini CLI, etc.) |

## Current Scope

The repository supports Claude Code, Codex, Cursor, and generic agent runtimes:

- **Claude Code and Codex**: `scripts/sync-global-skills.sh` or `./setup` links the canonical skill folders into both runtimes. Plugin manifests (`.claude-plugin/plugin.json`, `.codex-plugin/plugin.json`) enable marketplace and plugin-system distribution.
- **Cursor**: install the thin bootstrap rule into each consumer project with `scripts/install-cursor-project-rule.sh`. The full repository remains at a resolvable skills root (`QINGSHAN_SKILLS_ROOT`, baked path, or `~/.qingshan-skills/repo`).
- **Generic agents**: `./setup` links skills into `~/.agents/skills/` for runtimes that scan that directory.

Runtime-specific fields, manifests, hooks, and UI metadata remain outside the canonical `SKILL.md` files.
