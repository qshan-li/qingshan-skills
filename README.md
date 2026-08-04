**English** · [简体中文](./README.zh-CN.md)

# qingshan-skills

A lightweight software development methodology for AI coding agents. It distills the best patterns from gstack, Superpowers, GSD, and Matt Pocock's skills into 6 skills (think of them as 6 steps or commands), organized around one goal: **keep agents reliable — no drift, no careless edits, and proof before any claim of "done."** That goal breaks down into eight threads: retain engineering control, surgical changes (touch only what the task needs), risk-graded workflows, shared domain language, tight feedback loops, language-appropriate type safety, fresh context (hand heavy work to clean sub-sessions), and verify before concluding.

qingshan-skills does not take over the full development workflow. It is a minimal "engineering guardrail": it helps agents clarify goals, hold scope, argue from evidence, keep context from rotting, and leave high-impact decisions (architecture, release, irreversible actions) to users and engineers.

## Core Constraints

- Use the lightest workflow that still protects correctness; don't add weight just for the sake of process.
- Keep control in the hands of users and engineers; don't let agents quietly make product, architecture, release, or irreversible decisions for you.
- Prefer vertical slices (end-to-end, independently verifiable pieces) and verifiable feedback loops; avoid stacking large plans by technical layer.
- Use shared domain language to reduce misunderstanding; confirmed stable terms go into `CONTEXT.md` — but `CONTEXT.md` is a glossary only, never a spec, draft, or decision log.
- For bugs, performance, deployment, and stability issues, establish facts and baselines before discussing fixes.
- Any conclusion of "done, fixed, passing, shipped, optimized, or ready-for-review" must be backed by freshly-run verification evidence.

## Usage

qingshan-skills is not a set of isolated commands — it is a lightweight routing rule. Every software engineering task starts from the root [`SKILL.md`](SKILL.md), reads the shared constraints in [`ETHOS.md`](ETHOS.md), and then picks the lightest workflow that fits the task's shape.

1. Determine the task shape: unclear goal, needs planning, ready to change, troubleshooting, completion proof, or retrospective capture.
2. Apply the Memory Retrieval Gate: pull only the `CONTEXT.md`, `LEARNINGS.md`, decision artifacts, or global-memory excerpts that match the task's type, risk, tech stack, artifact, failure mode, or decision boundary — never a full dump.
3. Select the entry skill: low-risk tasks enter the shortest path that solves the problem; medium-to-high-risk tasks first fill gaps in understanding, planning, evidence, or rollback thinking.
4. Execute the skill's `Workflow`: each skill has trigger conditions, risk thresholds, hard rules, outputs, and handoff methods.
5. Continue across routine handoffs when the original request asks for the complete outcome, acceptance criteria are user-supplied, repository-derived with citation, or user-confirmed, every Taste decision is explicitly approved, and no User Challenge or missing prerequisite requires a stop. A phase-only invocation returns control after that stage. When a stopping handoff has valid next routes, Claude Code calls `AskUserQuestion` and Codex calls `request_user_input` before writing prose, with the recommended route first; if the runtime has no native input, use numbered or labeled choices so the user doesn't have to type a skill command.
6. Add a Loop Contract (a recurring-task agreement) only for recurring, automation-backed, fresh-context, multi-agent, migration, or broad repetitive work. Ordinary one-off tasks rely on their goal, acceptance criteria, boundaries, and proof.
7. Any conclusion of "done, fixed, passing, shipped, optimized, or ready-for-review" must first pass through `/verify` with fresh evidence. `/verify` is the sole owner of temporary task-state cleanup.

### Quick Routing Reference

| Task Signal | Entry Skill | Typical Follow-up |
| --- | --- | --- |
| Goal, scope, acceptance criteria, terminology, or user decision unclear | [`/clarify`](skills/clarify/SKILL.md) | Low-risk → `/execute`; needs decomposition → `/plan` |
| Read a project, directory, or module and produce a structured map plus uncertainties | [`/clarify`](skills/clarify/SKILL.md) | Continue `/clarify`, or route to `/plan`, `/investigate`, or `/execute` when a scoped next step is clear |
| Goal is clear, but needs task breakdown, ordering, decision grading, or verification design | [`/plan`](skills/plan/SKILL.md) | `/execute → /verify` |
| Dependency or toolchain upgrade | [`/plan`](skills/plan/SKILL.md) | Control blast radius (impact spread), compatibility impact, and verification path |
| Plan is clear, needs code, config, docs, tools, or project structure changes | [`/execute`](skills/execute/SKILL.md) | Local completion or `/verify` |
| Bug, failing test, performance, deployment, security, stability, or unknown root cause | [`/investigate`](skills/investigate/SKILL.md) | After root cause is clear → `/plan` or `/execute` |
| Test improvement but coverage gap, flaky signal (intermittent pass/fail), or failure behavior unclear | [`/investigate`](skills/investigate/SKILL.md) | Confirm the real signal first, then `/plan` or `/execute` |
| Code review, PR/diff review, implementation or spec review | [`/verify`](skills/verify/SKILL.md) | Scope/quality review and report residual risk |
| About to declare done, fixed, passing, shipped, optimized, or ready-for-review | [`/verify`](skills/verify/SKILL.md) | If reusable experience exists → `/reflect` |
| Ship, deploy, publish, PR, merge, release | [`/verify`](skills/verify/SKILL.md) | Only execute or hand off after the readiness proof passes, Taste is approved, and residual User Challenge risk is accepted |
| Verified work produced reusable lessons, project invariants, verification commands, or durable decisions | [`/reflect`](skills/reflect/SKILL.md) | Update minimal persistence artifact, or explicitly skip |

### Risk Levels

| Risk | Approach |
| --- | --- |
| Low | Shortest path, e.g. `/clarify → /execute`, ending locally only when the Local Completion Exit (in-place finish criteria) passes |
| Medium | Clarify goals, task order, decision grading, and verification strategy, e.g. `/clarify → /plan → /execute → /verify` |
| High | Establish evidence, rollback, or failure handling first; use fresh-context subagents, TDD, adversarial review, and release checks as needed |

Risk uses floors (minimum thresholds), not open-ended scoring: security, secrets, irreversible data, and real release actions are at least High; cross-module or multi-option user-facing work is at least Medium. Choose the minimum level that's sufficient, never below a matching floor. Risk only determines workflow weight — it never overrides hard rules.

### Decision Grades

| Decision Type | Handling |
| --- | --- |
| Mechanical | Project conventions already decide it; reversible; no user-visible, contract, data, architecture, or release impact — decide it silently |
| Taste | A reversible choice that still affects user-facing behavior, docs shape, workflow ergonomics, or implementation style — batch it and ask for explicit approval once |
| User Challenge | Architecture, product behavior, public contracts, irreversible data, or release risk — stop and ask the user immediately |

Note: a complete-outcome request, or a later `/execute` invocation, does **not** approve an open Taste batch. Record the selected options and the approval evidence; ask again only when a material decision changes.

## Skill Details

Each skill is organized around the failure it prevents. TDD is the default mode inside `/execute` for high-risk changes; code review is a dimension of `/verify`; shipping is the path after `/verify` passes. All three are embedded in existing skills, not standalone.

### `/clarify`

Prevents agents from starting work when they only "think they understand." Used when goals, scope, constraints, acceptance criteria, terminology, tradeoffs, or user decision boundaries are unclear.

Core actions:

- Read relevant code, docs, and existing context first; avoid asking questions code can answer.
- Pick a mode first: `goal-clarify` (clarify the goal) or `orientation` (map a project/module); orientation must not invent implementation-level acceptance criteria.
- Clarify goals, non-goals, constraints, and acceptance criteria, and label each with its provenance — user, repository, or agent-inferred; confirm any agent-proposed, user-visible success criterion before continuing.
- For project or module reading requests, produce a teaching-graph-style orientation: scoped evidence, structural nodes and edges, layers, domain flows, a guided tour, uncertainties, and the next route.
- Run an operational Uncertainty Pass for unfamiliar or risk-sensitive work, separating evidence, open facts (objective answers not yet found), open decisions (answers that need an owner's choice), blind-spot hypotheses, and residual uncertainty. Unfamiliarity triggers the pass — it does not raise the risk floor on its own.
- Run a shared-language check on domain vocabulary; user-confirmed stable terms are written to or updated in `CONTEXT.md`.
- Provide tradeoff analysis and recommendations for medium-to-high-risk tasks; high-impact decisions must be left to the user.
- Pass Taste decisions to `/plan` for batch approval, or approve the batch in `/clarify` before a low-risk direct `/execute` handoff.

Output: task type, risk level, goals and non-goals, acceptance criteria, Project/Module Orientation when requested, terminology clarifications with `CONTEXT.md` update status, open decisions, and a lightweight goal statement for `/plan` or `/execute`.

### `/plan`

Prevents scope drift and silently making high-impact decisions on the user's behalf. Used when goals are clear but the task needs decomposition, ordering, decision grading, verification strategy, or rollback thinking.

Core actions:

- List files, modules, or boundaries that will be touched and those that should be protected.
- When entering `/plan` directly from the root router, first establish a lightweight goal, acceptance criteria, protection boundaries, and verification path; return to `/clarify` if these inputs are missing.
- Classify decisions as Mechanical, Taste, or User Challenge.
- Write Decision Briefs for Taste and User Challenge decisions, covering recommended options, alternatives, tradeoffs, reversibility, and coverage differences.
- Batch Taste decisions into one explicit approval gate before `/execute`; stop immediately for User Challenge decisions.
- Prefer independently verifiable vertical slices; avoid stacking plans by technical layer.
- For approved durable decisions (decisions meant to last) that pass all three gates, write to existing ADR (architecture decision record) / decision artifacts; if no project convention exists, write to root `DECISIONS.md`.
- Add rollback or failure handling for high-risk changes involving deployment, data, security, or architecture.

Output: ordered tasks, impact scope, protected scope, decision grades, durable decision artifacts or deferral reasons, verification strategy, necessary rollback notes, and a plan ready for `/execute`.

### `/execute`

Prevents execution drift, over-engineering, and context rot. Used for implementing clear code, config, docs, tools, or project structure changes.

Core actions:

- Re-confirm the lightweight goal or plan, constraints, protected files, verification requirements, and decision approval evidence.
- Treat a lightweight target as a valid named-memory container (a place to hold memory tied to this task); apply only the memory named on the plan, Task Handoff, lightweight target, or context manifest.
- Refuse to edit while a Taste decision is open or changed; invoking `/execute` alone is not approval.
- Run the Context Gate; for high-risk tasks, hand narrow tasks off to fresh context.
- Make minimal changes; only touch files required by the current task.
- Execute high-risk code changes as TDD vertical slices: one behavior, one failing test, then one minimal implementation.
- Don't refactor opportunistically, introduce speculative abstractions (code written for a "might need it later" that isn't needed now), swallow errors, or ignore Promises.

Output: changed files, rationale, verification commands and results, unresolved risks, and a checkable state for `/verify`.

### `/investigate`

Prevents guessing at fixes without facts. Used for bugs, failing tests, regressions, performance, deployment, CI, security, stability, or unknown root cause issues.

Core actions:

- Define the symptom and expected behavior first.
- Establish the fastest, reliable, reproducible feedback loop; strengthen weak loops before drawing conclusions.
- Reproduce or observe the failure; collect evidence from tests, logs, metrics, traces, configs, or code paths.
- Narrow the failure surface; form 3 to 5 falsifiable hypotheses and verify the strongest ones sequentially.
- Exit by the Fix-Path Exit Criteria: go to `/execute` only for a Low re-grade with complete inputs and no sequencing risk; otherwise `/plan`.
- Performance issues must have a baseline; deployment issues must describe environment boundaries; security and stability issues must describe the threat or failure model.

Output: reproduction or observation method, feedback loop quality, collected facts, narrowed failure surface, root cause hypotheses with confidence, risk re-grade, and next skill.

### `/verify`

Prevents treating "looks right" as "done." Used before any declaration of completion, fix, passing, shipping, optimization, or readiness for review.

Core actions:

- Find commands, checks, or artifacts that can prove the conclusion; run fresh verification.
- Read output and exit codes; do not treat old results or implementer reports as evidence.
- Run Scope Drift Detection against the task, plan, and diff, classifying each item as Delivered, Missing, Extra, Changed, or Unverifiable.
- When observable behavior changes, require Behavior Regression Proof: a distinguishing test when a testable seam exists, or a repeatable changed-path proof with residual risk called out.
- Use the Review Readiness Dashboard for medium-to-high-risk or release-path tasks.
- For ship, deploy, publish, PR, merge, or release requests: complete the release-path readiness proof first; only execute or hand off when the checklist is ready, every Taste decision is approved, residual User Challenge risk is accepted, and the action itself is a mechanical handoff or release. Report readiness status and release-action status separately.
- Run Adversarial Review for high-risk changes involving auth, data migration, concurrency, payments, deployment, LLM trust boundaries, or large cross-module diffs.

Output: verification commands and results, acceptance status, scope drift check, behavior regression status when needed, necessary review panels, residual risks, release-action status when requested, and whether completion can genuinely be claimed.

### `/reflect`

Prevents repeating the same mistakes and polluting the knowledge base with noise. Used only when verified work produces reusable lessons.

Core actions:

- Determine whether the result is a reusable lesson, an unrecorded durable decision, both, or not worth capturing.
- Use the Memory Promotion Gate to decide the persistence layer (where it should live): current task, project context, project learning, global memory, or a skill rule.
- Use the Consumption Contract to confirm, for each artifact, who the future reader is and what will trigger retrieval; lessons with no reader and no trigger are not persisted.
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
| Small Mechanical docs change | `/clarify → /execute → done` via the Local Completion Exit |
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

qingshan-skills is runtime-neutral. The goal is simply to make the root skill and the six workflow skills available to the agent runtime. Five installation methods are provided.

### Option 1: Setup Script (Recommended)

```bash
git clone https://github.com/qshan-li/qingshan-skills.git
cd qingshan-skills
./setup
```

This validates the repository, then links the root skill and workflow skills into Claude Code, Codex, and generic agent directories. Use `--force` to replace existing links with a timestamped backup:

```bash
./setup --force
```

Any conflicting target stops installation with a non-zero exit instead of leaving a partial installation. `--skip-validation` skips only the repository validation step.

### Option 2: Claude Code Plugin Marketplace

```
/plugin marketplace add qshan-li/qingshan-skills
/plugin install qingshan-skills@qingshan-skills
```

### Option 3: Sync Script

For Claude Code and Codex, use the sync script from the repository root:

```bash
bash scripts/sync-global-skills.sh
```

The script links `qingshan-skills`, `clarify`, `plan`, `execute`, `investigate`, `verify`, `reflect` into the Claude Code, Codex, and generic agent global skill directories. Use `--force` to replace existing links:

```bash
bash scripts/sync-global-skills.sh --force
```

### Option 4: Cursor

Keep a full clone of this repository on disk, then install a Cursor project rule into each consumer project:

```bash
bash scripts/install-cursor-project-rule.sh /path/to/consumer-project
# optional but recommended
export QINGSHAN_SKILLS_ROOT=/absolute/path/to/qingshan-skills
```

The rule resolves the skills root (`QINGSHAN_SKILLS_ROOT`, a baked-in path, or `~/.qingshan-skills/repo`) and reads the canonical root router, ETHOS, and the selected workflow skill. Do not assume the consumer project root is the skills repository.

### Option 5: Manual Installation

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

# Generic agents
ln -s "$(pwd)" ~/.agents/skills/qingshan-skills
for s in clarify plan execute investigate verify reflect; do
  ln -s "$(pwd)/skills/$s" ~/.agents/skills/$s
done
```

For other runtimes and detailed options, see [`docs/installation.md`](docs/installation.md).

The core `SKILL.md` files retain only the runtime-neutral `name` and `description` frontmatter (the metadata block at the top). Runtime-specific fields, plugin manifests, hooks, rules wrappers, or UI metadata for Claude Code, Codex, Cursor, and other tools belong in an adapter layer, not in the core skills. See [`docs/runtime-adapters.md`](docs/runtime-adapters.md) for the boundary.

## Verification

```bash
bash scripts/validate-skills.sh
```

Expected output:

```text
OK qingshan-skills validation passed
```

The validator checks required files, skill YAML frontmatter, required sections, templates, prompt guardrails, plugin manifests, VERSION consistency, Cursor rules, and pressure scenarios with required signals.

Pressure-scenario contract coverage uses transcript artifacts (recorded conversation logs):

```bash
bash scripts/validate-behavior-tests.sh
```

Every pressure scenario must have at least one `PASS` transcript. `FAIL` and `BLOCKED` transcripts may remain as historical evidence, but they do not count as pressure scenario coverage. Manual transcripts are reviewable contract fixtures (sample artifacts), not black-box runtime proof.

Test layering and ACP boundaries are described in [`docs/testing.md`](docs/testing.md). ACP belongs to future runtime adapter integration testing, not the first layer of core skill semantic testing. Runtime behavior is defined by root [`SKILL.md`](SKILL.md) and the six workflow skills. Design rationale (not a second executable rule set) lives under [`docs/superpowers/specs/`](docs/superpowers/specs/).

An optional runtime smoke check is available for real host loading; it is not called automatically by core validation:

```bash
QINGSHAN_RUNTIME_SMOKE=1 bash scripts/validate-runtime-smoke.sh
```

Selected canonical-body behavior (the authoritative skill text) can be checked separately:

```bash
QINGSHAN_RUNTIME_BEHAVIOR=1 bash scripts/validate-runtime-behavior.sh
```
