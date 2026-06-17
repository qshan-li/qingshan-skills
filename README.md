**English** · [简体中文](./README.zh-CN.md)

# qingshan-skills

A lightweight software development methodology for AI coding agents. Distills the best patterns from gstack, Superpowers, GSD, and Matt Pocock's skills into 6 skills, organized around eight threads: **retain engineering control, surgical changes, risk-graded workflows, shared domain language, tight feedback loops, language-appropriate type safety, fresh context, and verify before concluding**.

qingshan-skills does not take over the full development workflow. It provides the minimal engineering protection layer: helping agents clarify goals, hold scope, build evidence, maintain context quality, and leave high-impact decisions to users and engineers.

## Core Constraints

- Use the lightest workflow that protects correctness; do not add weight for the sake of process.
- Retain user and engineer control; do not let agents steal product, architecture, release, or irreversible decisions.
- Prefer vertical slices and verifiable feedback loops; avoid stacking large plans by technical layer.
- Use shared domain language to reduce misunderstanding; confirmed stable terms go into `CONTEXT.md`, which serves only as a glossary — never as a spec, draft, or decision log.
- For bugs, performance, deployment, and stability issues, establish facts and baselines before discussing fixes.
- Any conclusion of done, fixed, passing, shipped, optimized, or ready-for-review must have fresh verification evidence.

## Usage

qingshan-skills is not a set of isolated commands — it is a lightweight routing rule. Every software engineering task starts from the root [`SKILL.md`](SKILL.md), reads the shared constraints in [`ETHOS.md`](ETHOS.md), then selects the lightest applicable workflow based on the task shape.

1. Determine the task shape: unclear goal, needs planning, ready to change, troubleshooting, completion proof, or retrospective capture.
2. Follow the Memory Retrieval Gate for trigger-based retrieval: only read `CONTEXT.md`, `LEARNINGS.md`, decision artifacts, or global memory excerpts that match the task type, risk, tech stack, artifact, failure mode, or decision boundary — never a full dump.
3. Select the entry skill: low-risk tasks enter the shortest path that solves the problem; medium-to-high-risk tasks first fill gaps in understanding, planning, evidence, or rollback thinking.
4. Execute the skill's `Workflow`: each skill has trigger conditions, risk thresholds, hard rules, outputs, and handoff methods.
5. Hand off between skills: `/clarify` produces a clear goal and persists confirmed shared language; `/plan` produces an executable plan and records approved durable decisions; `/execute` makes changes; `/verify` proves conclusions; `/reflect` captures only reusable lessons.
6. Any conclusion of "done, fixed, passing, shipped, optimized, or ready-for-review" must first pass through `/verify` with fresh evidence.

### Quick Routing Reference

| Task Signal | Entry Skill | Typical Follow-up |
| --- | --- | --- |
| Goal, scope, acceptance criteria, terminology, or user decision unclear | [`/clarify`](skills/clarify/SKILL.md) | Low-risk → `/execute`; needs decomposition → `/plan` |
| Goal is clear, but needs task breakdown, ordering, decision grading, or verification design | [`/plan`](skills/plan/SKILL.md) | `/execute → /verify` |
| Dependency or toolchain upgrade | [`/plan`](skills/plan/SKILL.md) | Control blast radius, compatibility impact, and verification path |
| Plan is clear, needs code, config, docs, tools, or project structure changes | [`/execute`](skills/execute/SKILL.md) | `/verify` |
| Bug, failing test, performance, deployment, security, stability, or unknown root cause | [`/investigate`](skills/investigate/SKILL.md) | After root cause is clear → `/plan` or `/execute` |
| Test improvement but coverage gap, flaky signal, or failure behavior unclear | [`/investigate`](skills/investigate/SKILL.md) | Confirm real signal first, then `/plan` or `/execute` |
| Code review, PR/diff review, implementation or spec review | [`/verify`](skills/verify/SKILL.md) | Scope/quality review and report residual risk |
| About to declare done, fixed, passing, shipped, optimized, or ready-for-review | [`/verify`](skills/verify/SKILL.md) | If reusable experience exists → `/reflect` |
| Ship, deploy, publish, PR, merge, release | [`/verify`](skills/verify/SKILL.md) | Only execute or hand off after release-path readiness proof passes and residual User Challenge risk is accepted |
| Verified work produced reusable lessons, project invariants, verification commands, or durable decisions | [`/reflect`](skills/reflect/SKILL.md) | Update minimal persistence artifact, or explicitly skip |

### Risk Levels

| Risk | Approach |
| --- | --- |
| Low | Shortest path, e.g. `/clarify → /execute → /verify`; no heavy planning |
| Medium | Clarify goals, task order, decision grading, and verification strategy, e.g. `/clarify → /plan → /execute → /verify` |
| High | Establish evidence, rollback, or failure handling first; use fresh-context subagents, TDD, adversarial review, and release checks as needed |

Risk rises from cross-module changes, irreversibility, user-visible impact, security, deployment, performance, architecture, or unclear requirements. Risk only determines workflow weight — it never overrides hard rules.

### Decision Grades

| Decision Type | Handling |
| --- | --- |
| Mechanical | Decide directly following existing project patterns; do not interrupt the user |
| Taste | Batch recommended options with tradeoffs and reversibility |
| User Challenge | Stop and let the user decide explicitly, e.g. architecture direction, product behavior, irreversible data, or release risk |

## Skill Details

Each skill is organized around the failure it prevents. TDD is the default mode inside `/execute` for high-risk changes; code review is a dimension of `/verify`; shipping is the path after `/verify` passes. All three are embedded in existing skills, not standalone.

### `/clarify`

Prevents agents from starting work when they only "think they understand." Used when goals, scope, constraints, acceptance criteria, terminology, tradeoffs, or user decision boundaries are unclear.

Core actions:

- Read relevant code, docs, and existing context first; avoid asking questions code can answer.
- Clarify goals, non-goals, constraints, acceptance criteria, and task risk.
- Run a shared language check on domain vocabulary; user-confirmed stable terms are written to or updated in `CONTEXT.md`.
- Provide tradeoff analysis and recommendations for medium-to-high-risk tasks; high-impact decisions must be left to the user.

Output: task type, risk level, goals and non-goals, acceptance criteria, terminology clarifications with `CONTEXT.md` update status, open decisions, and a lightweight goal statement for `/plan` or `/execute`.

### `/plan`

Prevents scope drift and silently making high-impact decisions on the user's behalf. Used when goals are clear but the task needs decomposition, ordering, decision grading, verification strategy, or rollback thinking.

Core actions:

- List files, modules, or boundaries that will be touched and those that should be protected.
- When entering `/plan` directly from the root router, first establish a lightweight goal, acceptance criteria, protection boundaries, and verification path; return to `/clarify` if these inputs are missing.
- Classify decisions as Mechanical, Taste, or User Challenge.
- Write Decision Briefs for Taste and User Challenge decisions, covering recommended options, alternatives, tradeoffs, reversibility, and coverage differences.
- Prefer independently verifiable vertical slices; avoid stacking plans by technical layer.
- For approved durable decisions that pass all three gates, write to existing ADR/decision artifacts; if no project convention exists, write to root `DECISIONS.md`.
- Add rollback or failure handling for high-risk changes involving deployment, data, security, or architecture.

Output: ordered tasks, impact scope, protected scope, decision grades, durable decision artifacts or deferral reasons, verification strategy, necessary rollback notes, and a plan ready for `/execute`.

### `/execute`

Prevents execution drift, over-engineering, and context rot. Used for implementing clear code, config, docs, tools, or project structure changes.

Core actions:

- Re-confirm the lightweight goal or plan, constraints, protected files, and verification requirements.
- Run the Context Gate to assess whether current context is sufficient; for high-risk tasks, hand off narrow tasks to fresh context.
- Make minimal changes; only touch files required by the current task.
- Execute high-risk code changes using TDD vertical slices: one behavior, one failing test, one minimal implementation.
- Do not refactor opportunistically, introduce speculative abstractions, swallow errors, or ignore Promises.

Output: changed files, rationale, verification commands and results, unresolved risks, and a checkable state for `/verify`.

### `/investigate`

Prevents guessing at fixes without facts. Used for bugs, failing tests, regressions, performance, deployment, CI, security, stability, or unknown root cause issues.

Core actions:

- Define the symptom and expected behavior first.
- Establish the fastest, reliable, reproducible feedback loop; strengthen weak loops before drawing conclusions.
- Reproduce or observe the failure; collect evidence from tests, logs, metrics, traces, configs, or code paths.
- Narrow the failure surface; form 3 to 5 falsifiable hypotheses and verify the strongest ones sequentially.
- Performance issues must have a baseline; deployment issues must describe environment boundaries; security and stability issues must describe the threat or failure model.

Output: reproduction or observation method, feedback loop quality, collected facts, narrowed failure surface, root cause hypotheses with confidence, and minimal fix path.

### `/verify`

Prevents treating "looks right" as "done." Used before any declaration of completion, fix, passing, shipping, optimization, or readiness for review.

Core actions:

- Find commands, checks, or artifacts that can prove the conclusion; run fresh verification.
- Read output and exit codes; do not treat old results or implementer reports as evidence.
- Run Scope Drift Detection against the task, plan, and diff to classify as Delivered, Missing, Extra, Changed, or Unverifiable.
- Use the Review Readiness Dashboard for medium-to-high-risk or release-path tasks.
- For ship, deploy, publish, PR, merge, release requests: complete release-path readiness proof first; only execute or hand off when checklist is ready, residual User Challenge risk is accepted, and the action is a mechanical handoff or release.
- Run Adversarial Review for high-risk changes involving auth, data migration, concurrency, payments, deployment, LLM trust boundaries, or large cross-module diffs.

Output: verification commands and results, acceptance status, scope drift check, necessary review panels, residual risks, and whether completion can genuinely be claimed.

### `/reflect`

Prevents repeating the same mistakes and polluting the knowledge base with noise. Used only when verified work produces reusable lessons.

Core actions:

- Determine whether the result is a reusable lesson, an unrecorded durable decision, both, or not worth capturing.
- Use the Memory Promotion Gate to decide the persistence layer: current task, project context, project learning, global memory, or skill rule.
- Use the Consumption Contract to confirm the future reader and retrieval trigger for each artifact; lessons without a reader/trigger are not persisted.
- Global memory written to `~/.qingshan-skills/memory/learnings.jsonl` must include at least trigger, lesson, scope, evidence, date, and source.
- Unrecorded durable decisions must include date, scope, rationale, rejected alternatives, and reversal conditions.
- Glossary entries are limited to stable domain terms or resolved ambiguities; ADRs are limited to hard-to-reverse decisions that would surprise someone without context and come from real tradeoffs.
- Choose the minimal persistence artifact; avoid session journals and one-off observations.

Output: reusable lessons, future triggers, future readers, necessary glossary or durable decision supplements, updated artifacts, or an explicit statement that no capture is needed.

## Workflow

### Default Flow

```text
/clarify -> /plan -> /execute -> /verify -> /reflect
      \                         ^
       -> /investigate -> /plan |
```

`/investigate` can enter at any stage; after diagnosis is clear, return to `/plan` then `/execute`. Use the root `SKILL.md` as the session bootstrap and routing entry; `ETHOS.md` serves as the shared constraint layer across all skills.

### Common Paths

Choose the lightest workflow for the scenario; no need to run the full pipeline every time:

| Scenario | Path |
| --- | --- |
| Small docs change | `/clarify → /execute → /verify` |
| Bug fix | `/investigate → /execute → /verify` |
| Performance tuning | `/investigate → /plan → /execute → /verify` |
| Dependency or toolchain upgrade | `/plan → /execute → /verify` |
| Code review or PR/diff review | `/verify` |
| Ship, PR, merge, deploy | `/verify` release-path check, then execute or hand off mechanical action |
| Large cross-module work | `/clarify → /plan → /execute` (fresh-context subagents) `→ /verify → /reflect` |

## Engineering Templates

The repository provides lightweight templates under [`docs/templates/`](docs/templates/), used only when the corresponding workflow needs them:

- `decision-brief.md`: Taste or User Challenge decision explanation.
- `fresh-context-packet.md`: Narrow task input packet for fresh-context workers / reviewers.
- `task-handoff.md`: Current task handoff when `/clarify` or `/investigate` results must survive context compression, agent handoff, or a `/plan`/`/execute` transition.
- `release-checklist.md`: Release, PR, deployment, or handoff check inside `/verify` — not a new `/ship` skill.
- `durable-decision.md`: `/plan` records approved durable decisions; `/reflect` backfills unrecorded durable decisions.
- `context-glossary.md`: Shape of `CONTEXT.md` when `/clarify` needs to establish project shared terminology.
- `runtime-bootstrap.md`: Minimal wrapper for runtimes that do not read Agent Skills directly.

The root [`CONTEXT.md`](CONTEXT.md) is this repository's own glossary, recording only stable terms and resolved ambiguities — never plans, implementation details, or decision logs. Project learning goes into `LEARNINGS.md` or existing retrospective docs; global learning is only retrieved as trigger-matched excerpts, not dumped in full on every task.

Reviewer prompts under `prompts/` are used only when the corresponding workflow needs structured review or fresh-context collaboration; `adversarial-reviewer.md` supports `/verify`'s high-risk adversarial review.

## Installation

qingshan-skills is runtime-neutral. The goal is to make the root skill and six workflow skills available to the agent runtime. Three installation methods are provided.

### Option 1: npx skill (Recommended)

If your environment supports the [`skill`](https://github.com/anthropics/claude-code-skill) CLI, install with one command:

```bash
npx skill install qshan-li/qingshan-skills
```

After installation, the root skill and six workflow skills are automatically linked to the current runtime's global skill directory. Re-run the same command to update.

### Option 2: Sync Script

For Claude Code and Codex, use the sync script from the repository root to create global links:

```bash
bash scripts/sync-global-skills.sh
```

The script links `qingshan-skills`, `clarify`, `plan`, `execute`, `investigate`, `verify`, `reflect` into the Claude Code and Codex global skill directories. Re-run after moving the repository; if a target already exists and conflicts, use `--force` to move the existing target to a timestamped backup before linking.

```bash
bash scripts/sync-global-skills.sh --force
```

### Option 3: Manual Installation

Clone the repository, then manually link or copy skill files per the runtime's requirements:

```bash
git clone https://github.com/qshan-li/qingshan-skills.git
cd qingshan-skills

# Claude Code
ln -s "$(pwd)" ~/.claude/skills/qingshan-skills
for s in clarify plan execute investigate verify reflect; do
  ln -s "$(pwd)/skills/$s" ~/.claude/skills/$s
done

# Codex
ln -s "$(pwd)" "${CODEX_HOME:-$HOME/.codex}/skills/qingshan-skills"
for s in clarify plan execute investigate verify reflect; do
  ln -s "$(pwd)/skills/$s" "${CODEX_HOME:-$HOME/.codex}/skills/$s"
done
```

For other runtimes and detailed options, see [`docs/installation.md`](docs/installation.md).

The core `SKILL.md` files retain only the runtime-neutral `name` and `description` frontmatter. Runtime-specific fields, plugin manifests, hooks, rules wrappers, or UI metadata for Claude Code, Codex, Cursor, and other tools belong in an adapter layer, not in the core skills. See [`docs/runtime-adapters.md`](docs/runtime-adapters.md) for the boundary.

## Verification

```bash
bash scripts/validate-skills.sh
```

Expected output:

```text
OK qingshan-skills validation passed
```

The validator checks required files, skill YAML frontmatter, required sections, templates, prompt guardrails, and pressure scenarios with required signals.

Behavioral regression uses transcript artifacts:

```bash
bash scripts/validate-behavior-tests.sh
```

Every pressure scenario must have at least one `PASS` transcript. `FAIL` and
`BLOCKED` transcripts may remain as historical evidence, but they do not count
as pressure scenario coverage.

Test layering and ACP boundaries are described in [`docs/testing.md`](docs/testing.md). ACP belongs to future runtime adapter integration testing, not the first layer of core skill semantic testing. Design rationale is in the authoritative specs under [`docs/superpowers/specs/`](docs/superpowers/specs/).

An optional runtime smoke check is available for real host loading; it is not called automatically by core validation:

```bash
QINGSHAN_RUNTIME_SMOKE=1 bash scripts/validate-runtime-smoke.sh
```
