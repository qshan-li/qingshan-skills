# qingshan-skills

Personal AI-driven development methodology, distilled from gstack, Superpowers, GSD, and Matt Pocock's skills.

## Project Goal

Build a personal skill library that integrates the best patterns from four source skill systems into a cohesive, opinionated methodology. The result is not a copy or a wrapper — it is a **distillation** filtered through a specific engineering philosophy: minimal, surgical, type-safety-first, verification-driven.

### What This Project Produces

1. **6 top-level skills**, each organized by the failure it prevents:
   - `/clarify` — acting before the goal, constraints, and acceptance criteria are understood
   - `/plan` — scope drift, poor task decomposition, and hidden high-impact decisions
   - `/execute` — execution drift, over-engineering, context rot, and unsafe code changes
   - `/investigate` — guessing at fixes without facts or root-cause evidence
   - `/verify` — claiming completion without proof
   - `/reflect` — repeating mistakes because useful lessons were not captured

2. **TDD, review, and shipping are folded in, not standalone skills**:
   - TDD is the default execution mode inside `/execute` for high-risk code changes
   - Review is a verification dimension inside `/verify`
   - Shipping is the release path after `/verify` passes

3. **Root infrastructure**:
   - `SKILL.md` — session-bootstrap routing enforcement + behavioral contract
   - `ETHOS.md` — core principles referenced by every skill
   - `prompts/` — fresh-context worker/reviewer prompts, only where needed
   - `docs/` — philosophy, installation guide, references, design spec

The authoritative design lives at `docs/superpowers/specs/2026-06-16-qingshan-skills-design.md`. The earlier eight-skill outline is superseded; any future split requires explicit design review.

### Source Skills and What We Take From Each

| Source | Repo | What We Extract |
|--------|------|-----------------|
| **gstack** | [garrytan/gstack](https://github.com/garrytan/gstack) | Multi-role review pipeline, decision classification, proactive routing, `benefits-from` soft deps, ETHOS.md pattern, uniform SKILL.md chassis |
| **Superpowers** | [obra/superpowers](https://github.com/obra/superpowers) | TDD iron rule, subagent coordinator/worker, CSO description field, rationalization prevention, brainstorming hard gate, skills-tested-like-code |
| **GSD** | [open-gsd/get-shit-done-redux](https://github.com/open-gsd/get-shit-done-redux) | Context rot prevention, fresh 200k-token subagents, STATE.md/CONTEXT.md persistence, five-phase loop |
| **Matt Pocock's skills** | [mattpocock/skills](https://github.com/mattpocock/skills) | Control-preserving posture, Grill Me's one-question-at-a-time inquiry, recommended answers, codebase-first exploration, shared language, sparse ADRs, feedback-loop-first debugging |

See `docs/references.md` for full file interfaces, directory structures, and cross-reference mapping.

### How We Distinguish From the Sources

| Dimension | gstack | Superpowers | GSD | Matt Pocock's skills | **qingshan-skills** |
|-----------|--------|-------------|-----|----------------------|---------------------|
| Scope | 23+ skills, browser, iOS, multi-agent | 14 skills, multi-harness | 5-phase framework | 15 published skills, personal collection | **6 focused skills** |
| Philosophy | "Boil the Ocean" | "TDD always" | "Fresh context" | "Real engineers, not vibe coding" | **"Surgical + Minimal"** |
| Complexity | Heavy (70+ dirs) | Medium | Medium | Small and composable | **Lightweight** |
| Constraint layer | ETHOS.md 3 principles | Rationalization tables | Context engineering | Shared language, sparse ADRs, feedback loops | **CLAUDE.md 6 rules** |

## Project Structure

```
qingshan-skills/
├── CLAUDE.md                    # Project instructions (→ this file)
├── LICENSE                      # MIT
├── README.md                    # Overview and installation
├── SKILL.md                     # Root skill: session-bootstrap routing enforcement
├── ETHOS.md                     # Core principles referenced by every skill
├── AGENTS.md                    # This file
│
├── skills/
│   ├── clarify/SKILL.md         # Goal/scope/constraint clarification (← Matt Pocock's Grill Me + Superpowers brainstorming)
│   ├── plan/SKILL.md            # Task decomposition + decision grading (← gstack autoplan + Superpowers writing-plans)
│   ├── execute/SKILL.md         # All engineering changes; TDD default; Context Gate (← Superpowers subagent + GSD fresh context)
│   ├── investigate/SKILL.md     # Root-cause investigation: no facts, no fix (← Superpowers debugging + gstack investigate)
│   ├── verify/SKILL.md          # Proof before completion; review is a dimension here (← Superpowers verification + gstack review)
│   └── reflect/SKILL.md         # Selective durable learning (← gstack retro + learn)
│
├── prompts/
│   ├── fresh-worker.md          # Fresh-context worker prompt
│   ├── spec-reviewer.md         # Spec compliance reviewer prompt
│   ├── quality-reviewer.md      # Quality reviewer prompt
│   └── adversarial-reviewer.md  # High-risk adversarial review prompt
│
└── docs/
    ├── references.md            # Source skill deep-dive
    ├── philosophy.md            # Methodology philosophy
    ├── installation.md          # Installation guide
    └── superpowers/specs/2026-06-16-qingshan-skills-design.md   # Authoritative design
```

## Skill Flow (Default Flow)

```
/clarify -> /plan -> /execute -> /verify -> /reflect
      \                         ^
       -> /investigate -> /plan |
```

- **TDD** is the default execution mode inside `/execute` for high-risk code changes.
- **Review** is a verification dimension inside `/verify`, not a standalone skill.
- **Shipping** is the release path after `/verify` passes, not a standalone skill.

Common paths: small docs change → `/clarify → /execute → /verify`; bug fix → `/investigate → /execute → /verify`; perf tuning → `/investigate → /plan → /execute → /verify`; large cross-module work → `/clarify → /plan → /execute` (fresh-context subagents) `→ /verify → /reflect`.

## Conventions

- All skill documents in **English**
- Each skill lives in `skills/<name>/SKILL.md`
- YAML frontmatter: `name`, `description` (trigger condition only)
- `description` describes **WHEN** to trigger, never **WHAT** the skill does (CSO)
- Reference external skills by URL, not by copying content
- Commit style: short imperative, one logical change per commit
- Every skill includes a Rationalization Prevention table
- Every skill includes a "When NOT to use" section

## Skill Sync (Mandatory)

**Rule:** Whenever any skill-related content in this repo is updated — any `SKILL.md`, the root `SKILL.md`/`ETHOS.md`, anything under `skills/` or `prompts/`, or anything else that materially changes skill behavior — you **must** run the sync script as the final step before considering the task done:

```sh
scripts/sync-global-skills.sh
```

This propagates the updated skills into the local test skill installation so changes are actually exercised. Skipping it leaves the test environment stale and means the change is effectively unverified — do not claim completion without running it.

## Core Philosophy (from CLAUDE.md)

1. **Understand before coding** — if unclear, stop and ask
2. **Minimal solution** — fewest lines to solve the current problem
3. **Surgical changes** — touch only what's necessary, leave adjacent code alone
4. **Readable = documented** — names express intent, comments explain why
5. **Fresh context** — heavy tasks go to subagents to prevent context rot
6. **Verified = done** — no claim of completion without running the proof
