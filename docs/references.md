# References — Source Skills and Project Structure

## Source Skills

These are the four skill frameworks that qingshan-skills draws from. Each contributes a distinct capability dimension.

---

## The Essence of Each Source Skill

Each framework's value is not its feature list but one **core insight**. Strip away the tooling and this is what remains.

### gstack — The Essence is **Decision Grading**

The surface is "23 skills as a virtual engineering team." The core problem it solves: **AI steals your decisions.** `/autoplan` grades every decision into three buckets:

| Grade | Handling |
|-------|----------|
| **Mechanical** | Auto-execute silently, never disturb you |
| **Taste** | Batch-collect, surface once at a single approval gate |
| **User Challenge** | **Never auto-decided** — must ask you |

This single move cures two diseases at once: **decision fatigue** (asking about every trivial thing) and **decision theft** (deciding the big things for you).

- *Secondary essence:* `benefits-from` soft dependencies wire skills into a `Think → Plan → Build → Review → Test → Ship → Reflect` pipeline where each step's output is the next step's input.

### Superpowers — The Essence is **Anti-Shortcut Discipline**

The surface is TDD + subagents. The real insight: **agents, like humans under pressure, invent excuses to skip discipline.** Two layers of resistance:

- **CSO (Claude Search Optimization):** the `description` field describes **only when to trigger, never the workflow.** Testing showed that once the description says "how," the agent uses it as a shortcut and **skips the full skill body** — doing one review instead of two.
- **Rationalization Prevention tables:** every skill carries an "excuse → reality" table that nails shut every lazy reason an agent might voice ("too simple to test," "I'll explore first," "tests after achieve the same thing").

- *Secondary essence:* **skills are tested like code** — write a pressure scenario, watch the agent fail (RED), write the skill to fix that specific failure (GREEN).

### GSD — The Essence is **Context Rot**

GSD has one problem consciousness: **AI quality silently degrades as a conversation grows long, and you cannot feel it happening.** Everything is designed around this single fact:

- Each **executor starts from a clean 200k-token context** — heavy work never runs in the main session.
- `STATE.md` / `CONTEXT.md` persist cross-session memory, because context will be compressed or lost.
- The five-phase loop (Discuss → Plan → Execute → Verify → Ship) is fundamentally a brake on context rot.

- *One-liner:* **Other frameworks care about "making the AI do the right thing once." GSD cares about "making the AI keep doing the right thing."**

### Grill Me — The Essence is **Nobody Knows What They Want**

Grill Me is the most minimal of the four (the entire SKILL.md is four directives), but its insight is the most fundamental:

> **The most common failure mode is believing the agent understood you when it didn't.**

Every mechanism exists to force out the real requirement:
- Ask **one question at a time** (depth-first, not a bombardment)
- Attach a **recommended answer** to each question (lower your answer cost)
- If the codebase can answer it, **read the code instead of asking**
- Resolve the decision tree **one branch at a time**

- *The subtlety:* it produces no code — only **shared understanding.** That consensus is the prerequisite for all downstream work (plan / implement / review).

### How the Four Compose

```
Grill Me    forces out "what we're really doing"   ← consensus layer
GSD         ensures "keep doing it right"           ← context layer
Superpowers enforces "do it by the rules"           ← discipline layer
gstack      decides "who does what, when to stop"   ← orchestration layer
```

**qingshan-skills compresses these four layers into 6 skills** — `/clarify`, `/plan`, `/execute`, `/investigate`, `/verify`, `/reflect` — constrained by the "surgical + minimal" philosophy, rather than laying out all four frameworks' full feature sets side by side. TDD, review, and shipping are **not** top-level skills: TDD is the default execution mode inside `/execute`, review is a verification dimension inside `/verify`, and shipping is the release path after `/verify` passes. See `docs/superpowers/specs/2026-06-16-qingshan-skills-design.md` for the authoritative design.

---

### 1. gstack — Virtual Engineering Team

- **Repo**: https://github.com/garrytan/gstack
- **Author**: Garry Tan (CEO, Y Combinator)
- **License**: MIT
- **Language**: TypeScript 79.1%, Go Template 11.3%, Shell 5.8%, JavaScript 2.8%
- **Install**: `git clone --single-branch --depth 1 https://github.com/garrytan/gstack.git ~/.claude/skills/gstack && cd ~/.claude/skills/gstack && ./setup`

#### What It Is

gstack transforms Claude Code into "a virtual engineering team" — specialists acting as CEO, Designer, Eng Manager, Release Manager, Doc Engineer, QA, and more. It is explicitly "a process, not a collection of tools." Skills run in sprint order: **Think → Plan → Build → Review → Test → Ship → Reflect**. Each skill feeds into the next — `/office-hours` writes a design doc that `/plan-ceo-review` reads, `/plan-eng-review` writes a test plan that `/qa` picks up, etc.

The project embodies the idea that "a single builder with the right tooling can move faster than a traditional team." It supports 10+ AI coding agents: Claude Code, OpenAI Codex CLI, OpenCode, Cursor, Factory Droid, Slate, Kiro, Hermes, GBrain, and OpenClaw.

#### File Structure

```
gstack/
├── SKILL.md                    # Root skill: routing table + browser automation
├── SKILL.md.tmpl               # Template for generating per-skill SKILL.md files
├── CLAUDE.md                   # Development guide for contributors
├── AGENTS.md                   # Runtime skill catalog (7 category tables)
├── ETHOS.md                    # Builder principles injected into every skill
├── ARCHITECTURE.md             # Browser daemon, security model, template system
├── BROWSER.md                  # Browser interaction architecture
├── DESIGN.md                   # Design system documentation
├── CONTRIBUTING.md             # Contribution guidelines
├── conductor.json              # Workspace lifecycle hooks
├── package.json / bun.lock / bunfig.toml
├── setup                       # Install script
├── VERSION
│
├── skills/ (each is a top-level directory)
│   ├── office-hours/           # YC Office Hours — 6 forcing questions
│   ├── plan-ceo-review/        # CEO review — 4 modes (Expansion/Selective/Hold/Reduction)
│   ├── plan-eng-review/        # Eng Manager — locks architecture, data flow, edge cases
│   ├── plan-design-review/     # Senior Designer — 0-10 rating per dimension
│   ├── plan-devex-review/      # DX Lead — 20-45 forcing questions
│   ├── autoplan/               # Orchestrator: CEO → design → eng → DX pipeline
│   ├── spec/                   # Spec Author — vague intent → precise spec in 5 phases
│   ├── review/                 # Staff Engineer — finds bugs that pass CI
│   ├── investigate/            # Debugger — "Iron Law: no fixes without investigation"
│   ├── qa/                     # QA Lead — browser-based testing with fix loop
│   ├── qa-only/                # QA Reporter — bug report without code changes
│   ├── cso/                    # Chief Security Officer — OWASP Top 10 + STRIDE
│   ├── ship/                   # Release Engineer — 21-step pipeline
│   ├── land-and-deploy/        # Merge PR → CI → verify production
│   ├── canary/                 # SRE — post-deploy monitoring
│   ├── benchmark/              # Performance Engineer — Core Web Vitals
│   ├── retro/                  # Eng Manager — weekly retro
│   ├── learn/                  # Memory — cross-session learning
│   ├── document-release/       # Technical Writer — Diataxis framework
│   ├── document-generate/      # Documentation Author — generate missing docs
│   ├── design-consultation/    # Design Partner — full design system from scratch
│   ├── design-shotgun/         # Design Explorer — 4-6 AI mockup variants
│   ├── design-html/            # Design Engineer — mockup → production HTML/CSS
│   ├── design-review/          # Designer Who Codes — audit + fix
│   ├── devex-review/           # DX Tester — live onboarding audit
│   ├── codex/                  # Second opinion from OpenAI Codex CLI
│   ├── careful/                # Safety — warns before destructive commands
│   ├── freeze/                 # Edit lock — restricts edits to one directory
│   ├── guard/                  # Full safety = careful + freeze
│   ├── unfreeze/               # Removes freeze boundary
│   ├── browse/                 # Real Chromium browser (~100ms/command)
│   ├── make-pdf/               # Markdown → PDF/HTML/DOCX
│   ├── diagram/                # English → Mermaid/excalidraw/SVG
│   └── ... (70+ directories total)
│
├── lib/                        # Shared TypeScript modules
├── bin/                        # Standalone CLI binaries
├── scripts/                    # Build tooling
├── browse/                     # Headless Chromium CLI
├── hosts/                      # Multi-platform host configs
├── extension/                  # Chrome sidebar extension
├── model-overlays/             # Model-specific configuration
├── supabase/                   # Telemetry schema
└── docs/                       # Deep-dive documentation
```

#### SKILL.md Format (Template)

Every skill SKILL.md is generated from `SKILL.md.tmpl`. The template uses `{{PREAMBLE}}`, `{{BROWSE_SETUP}}`, `{{COMMAND_REFERENCE}}` placeholders for shared sections.

**YAML Frontmatter fields:**
```yaml
name: skill-name                    # slash-command identifier
preamble-tier: 1-4                  # execution order of shared preamble
version: 1.1.0                      # semantic version
description: What it does (gstack)  # always suffixed with (gstack)
allowed-tools: [Bash, Read, Write, Edit, Grep, Glob, Agent, AskUserQuestion, WebSearch]
triggers: [natural language phrases]
benefits-from: [other-skill]        # soft dependency
gbrain: semantic queries            # optional cross-session knowledge
```

**Body sections (16 shared + 1 unique):**
1. When to invoke this skill
2. Preamble (bash block for session setup, telemetry, config)
3. Plan Mode Safe Operations
4. Skill Invocation During Plan Mode
5. AskUserQuestion Format (structured decision-brief spec)
6. Artifacts Sync (gbrain integration)
7. Model-Specific Behavioral Patch
8. Voice guidelines
9. Context Recovery (loading prior session artifacts)
10. Writing Style
11. Completeness Principle
12. Question Tuning
13. Continuous Checkpoint Mode
14. Completion Status Protocol
15. Operational Self-Improvement
16. Telemetry
17. **Skill-specific workflow** (the only unique part)

#### Skills That Feed Into Each Other

```
/office-hours → design doc → /plan-ceo-review
/plan-eng-review → test plan → /qa
/review → bugs → /ship verifies fixes
/autoplan chains: CEO → design → eng → DX
/design-shotgun → approved mockup → /design-html
/ship → auto-invokes /document-release
/document-release → gaps → /document-generate
/investigate → auto-activates /freeze
/ship → auto-closes source issue on merge
```

#### Key Patterns to Extract

| Pattern | Description | Target Skill |
|---------|-------------|--------------|
| `/autoplan` | Sequential multi-role review: CEO → design → eng → DX | `/plan` |
| Decision classification | Mechanical (auto) / Taste (batch for human) / User Challenge (never auto) | `/plan` |
| `/review` | Staff-engineer code review with specialist dispatch | `/verify` |
| `/ship` | 21-step release: sync → test → coverage → commit → push → PR | Release path after `/verify` |
| `/investigate` | "Iron Law: no fixes without investigation." 3-fail stop. | `/investigate` |
| `/learn` | Persistent cross-session learning to `~/.gstack/` | `/reflect` |
| `benefits-from` | Soft dependency between skills | Root SKILL.md |
| Proactive routing | Natural language → skill invocation table | Root SKILL.md |
| ETHOS.md | "Boil the Ocean", "Search Before Building" (3 layers), "User Sovereignty" | `ETHOS.md` |
| Uniform chassis | 16 shared preamble sections + 1 unique workflow | SKILL.md template |

#### ETHOS.md Summary (Injected into Every Skill)

Three principles:
1. **Boil the Ocean** — since AI makes completeness nearly free, always choose the full implementation. Build "oceans" one "lake" at a time.
2. **Search Before Building** — three knowledge layers: Layer 1 (tried and true), Layer 2 (new and popular, needs scrutiny), Layer 3 (first principles, most valuable). The "Eureka Moment" comes from combining all three.
3. **User Sovereignty** — overrides all others. AI models recommend, users decide. Generation-verification loop: AI never skips user verification.

---

### 2. Superpowers — Structured Development Methodology

- **Repo**: https://github.com/obra/superpowers
- **Author**: Jesse Vincent (Prime Radiant)
- **License**: MIT
- **Language**: Shell 66.4%, JavaScript 24.8%, HTML 3.3%, Python 2.8%, TypeScript 2.1%
- **Install**: Via plugin marketplace (`/plugin install superpowers@claude-plugins-official` for Claude Code)

#### What It Is

Superpowers is "a complete software development methodology for your coding agents, built on top of a composable skills framework." Skills are "mandatory workflows, not suggestions." The agent checks for relevant skills before any task and auto-triggers them.

**Philosophy pillars:** Test-Driven Development, Systematic over ad-hoc, Complexity reduction, Evidence over claims.

**Supported harnesses:** Claude Code, Codex CLI, Codex App, Factory Droid, Gemini CLI, OpenCode, Cursor, GitHub Copilot CLI.

#### File Structure

```
superpowers/
├── CLAUDE.md                   # Claude-specific instructions
├── AGENTS.md                   # Contributor guidelines (not runtime catalog)
├── GEMINI.md                   # Gemini-specific instructions
├── gemini-extension.json       # Gemini CLI integration
├── package.json
├── LICENSE / README.md / RELEASE-NOTES.md / CODE_OF_CONDUCT.md
│
├── .claude-plugin/             # Claude Code plugin config
├── .codex-plugin/              # Codex plugin config
├── .cursor-plugin/             # Cursor plugin config
├── .opencode/                  # OpenCode plugin config
│
├── skills/
│   ├── using-superpowers/      # Bootstrap skill — loaded at session start
│   │   └── SKILL.md
│   ├── brainstorming/          # Socratic design refinement
│   │   ├── SKILL.md
│   │   ├── spec-document-reviewer-prompt.md
│   │   ├── visual-companion.md
│   │   └── scripts/
│   ├── writing-plans/          # Break spec into 2-5 min tasks
│   │   └── SKILL.md
│   ├── executing-plans/        # Batch execution with human checkpoints
│   │   └── SKILL.md
│   ├── subagent-driven-development/  # Coordinator/worker architecture
│   │   ├── SKILL.md
│   │   ├── implementer-prompt.md
│   │   ├── spec-reviewer-prompt.md
│   │   └── code-quality-reviewer-prompt.md
│   ├── test-driven-development/ # RED-GREEN-REFACTOR iron rule
│   │   ├── SKILL.md
│   │   └── testing-anti-patterns.md
│   ├── systematic-debugging/   # 4-phase root cause investigation
│   │   └── SKILL.md
│   ├── verification-before-completion/ # "Claiming done without verification is dishonesty"
│   │   └── SKILL.md
│   ├── requesting-code-review/ # Pre-review checklist
│   │   └── SKILL.md
│   ├── receiving-code-review/  # Responding to review feedback
│   │   └── SKILL.md
│   ├── using-git-worktrees/    # Isolated workspace creation
│   │   └── SKILL.md
│   ├── finishing-a-development-branch/ # Merge/PR/keep/discard
│   │   └── SKILL.md
│   ├── dispatching-parallel-agents/ # Concurrent subagent workflows
│   │   └── SKILL.md
│   └── writing-skills/         # Guide for creating new skills
│       ├── SKILL.md
│       ├── anthropic-best-practices.md
│       ├── testing-skills-with-subagents.md
│       ├── persuasion-principles.md
│       ├── graphviz-conventions.dot
│       ├── render-graphs.js
│       └── examples/
│
├── hooks/                      # Hook scripts
├── scripts/                    # Utility scripts
├── tests/                      # Test suite
├── assets/                     # Static assets
└── docs/                       # Documentation
```

#### SKILL.md Format

**Frontmatter (max 1024 chars total):**
```yaml
name: skill-name-with-hyphens
description: Use when [specific triggering conditions and symptoms]
```

**Critical CSO rule:** The `description` field describes **only when to trigger**, never what the skill does or how. If description summarizes workflow, the agent follows the description as shortcut and skips reading the full body. This is "Claude Search Optimization."

**Body structure (conventional, not rigid):**
- Overview — core principle in 1-2 sentences
- When to Use — symptoms, use cases, and when NOT to use
- Core Pattern — the workflow, often with Graphviz `digraph` flowcharts
- Quick Reference — scannable table or bullets
- Common Mistakes / Red Flags — tables of excuses mapped to realities
- Rationalization Prevention — explicit counters to every loophole
- Integration — references using `superpowers:skill-name` notation (not `@file` paths)

**Two skill types:** Rigid (TDD, debugging — follow exactly) and Flexible (patterns — adapt to context).

#### How Auto-Trigger Works

The bootstrap skill `using-superpowers` is loaded at session start. It establishes:

1. On every user message, agent checks if any skill's `description` matches
2. If even 1% chance a skill applies, MUST invoke it before responding
3. Skill content injected into context, followed directly
4. "Red Flags" table enumerates every rationalization for skipping

**Priority order:** User instructions (CLAUDE.md) > Superpowers skills > Default system prompt.

Skills are composable: "Let's build X" triggers brainstorming → writing-plans → subagent-driven-development → TDD, each handing off to the next.

#### Subagent-Driven Development (Core Execution Pattern)

**Coordinator** (main session): reads plan, dispatches fresh subagents per task, manages review pipeline, never pauses for human checkpoints.

**Per-task cycle:**
1. Dispatch **implementer** with full task text + architectural context
2. If BLOCKED/NEEDS_CONTEXT → provide more context or upgrade model, re-dispatch
3. Dispatch **spec compliance reviewer** — told "implementer finished suspiciously quickly," reads actual code line-by-line against requirements
4. Issues → fix → re-review loop until approved
5. Dispatch **code quality reviewer** — checks decomposition, naming, maintainability
6. Issues → fix → re-review loop
7. Mark complete, next task

**Model selection:** cheap/fast for mechanical tasks, standard for integration, most capable for architecture/design/review.

#### Brainstorming Skill (Detailed)

**Hard gate:** no implementation action of any kind until design is approved. Even trivial projects must go through this.

**9-step checklist:**
1. Explore project context (files, docs, recent commits)
2. Offer visual companion if visual questions anticipated
3. Ask clarifying questions — one per message, multiple choice preferred
4. Propose 2-3 approaches with tradeoffs and a recommendation
5. Present design in sections, get approval per section
6. Write spec to `docs/superpowers/specs/YYYY-MM-DD-<topic>-design.md`
7. Spec self-review: placeholder scan, consistency, scope, ambiguity
8. User reviews written spec — wait for explicit approval
9. Transition to `writing-plans` skill exclusively

#### TDD Skill (Detailed)

**Iron Rule:** never write production code without a failing test first. If code written before test → delete it entirely, start fresh.

**RED-GREEN-REFACTOR:**
- RED: write one minimal failing test, run it, confirm it fails for the right reason
- GREEN: write simplest code to pass, verify all tests still pass
- REFACTOR: clean up while keeping tests green, no new behavior

**Rationalization table (11 entries):**
| Excuse | Reality |
|--------|---------|
| Too simple to test | Simple code breaks; test takes 30 seconds |
| I'll write tests after | Tests-after are biased by implementation |
| Keep code as reference | You'll adapt it, which is testing after |
| TDD is dogmatic | TDD is pragmatic — finds bugs before commit |
| Tests after achieve same goals | Tests-after verify what you built, not what's required |

#### Key Patterns to Extract

| Pattern | Description | Target Skill |
|---------|-------------|--------------|
| CSO description field | Trigger-only description prevents shortcut behavior | All SKILL.md files |
| Rationalization prevention | Enumerate every excuse, counter each one | All skills |
| Subagent coordinator/worker | Fresh subagent per task, two-stage review | `/execute` |
| Spec compliance review | Distrust implementer's "done" report, verify line-by-line | `/verify` |
| TDD iron rule | Code before test → delete and start over | `/execute` |
| Brainstorming hard gate | No code until design approved | `/clarify` |
| Skills tested like code | RED-GREEN-REFACTOR applied to skill creation itself | Meta |
| `using-superpowers` bootstrap | Session-start skill that enforces skill checking | Root SKILL.md |

---

### 3. GSD (Get Shit Done) — Context Engineering

- **Repo**: https://github.com/open-gsd/get-shit-done-redux
- **npm**: `@opengsd/gsd-core`
- **License**: MIT
- **Language**: JavaScript 84.4%, TypeScript 14.7%, Shell 0.9%
- **Stars**: ~4.1k
- **Install**: `npx @opengsd/gsd-core@latest`

#### What It Is

GSD Core is "a light-weight meta-prompting, context engineering, and spec-driven development system" compatible with numerous AI coding agents. Tagline: **"Git. Ship. Done."**

The core philosophy revolves around solving **context rot** — "the quality degradation that accumulates as an AI fills its context window." Three key problems:
1. Context bloat silently degrading output quality
2. No shared memory across sessions
3. No verification that generated code actually works

"Claude Code is powerful. GSD Core makes it reliable."

**Supported runtimes:** Claude Code, OpenCode, Gemini CLI, Kimi CLI, Kilo, Codex, Copilot, Cursor, Windsurf.

#### File Structure

```
gsd-core/
├── agents/                     # Agent configurations for various runtimes
├── commands/gsd/               # Slash command definitions (e.g., /gsd-new-project)
├── src/                        # Core source code
├── tests/                      # Test suite (Vitest)
├── docs/                       # Documentation (Diataxis: tutorials/how-to/reference/explanation)
│   ├── tutorials/
│   ├── how-to/
│   ├── reference/
│   └── explanation/
├── capabilities/               # Capability modules
├── hooks/                      # Hook implementations
├── scripts/                    # Utility scripts
├── bin/                        # CLI entry points
├── eslint-rules/               # Custom ESLint rules
├── .changeset/                 # Changeset-based versioning
├── .plans/                     # Planning artifacts
├── .claude-plugin/             # Claude Code integration
├── .out-of-scope/              # Deferred features
│
├── CONTEXT.md                  # Persistent context artifact
├── CONTRIBUTING.md
├── SECURITY.md
├── VERSIONING.md
├── TESTING-STANDARDS.md
├── GEMINI.md                   # Gemini-specific instructions
├── gemini-extension.json
├── .clinerules                 # Cline integration
├── package.json
├── tsconfig.json / vitest.config.ts / eslint.config.mjs / stryker.config.mjs
└── README.md (+ ja-JP, ko-KR, pt-BR, zh-CN translations)
```

#### The Five-Phase Loop

Each milestone cycles through five sequential phases:

1. **Discuss** — "capture implementation decisions before anything is planned"
2. **Plan** — "research, decompose, and verify the plan fits a fresh context window"
3. **Execute** — "run plans in parallel waves; each executor starts with a clean 200k-token context"
4. **Verify** — "walk through what was built; diagnose and fix before declaring done"
5. **Ship** — "create the PR, archive the phase, repeat for the next one"

Each phase runs one at a time. The entire loop repeats per milestone.

#### How Fresh Context Subagents Work

The distinguishing feature. Heavy research, planning, and execution "runs in fresh subagents" while "keeping your main session lean." During Execute, "each executor starts with a clean 200k-token context" — parallel execution waves each get an uncontaminated context window. This prevents context rot.

#### STATE.md and CONTEXT.md

Structured artifacts that "survive session boundaries" as shared memory across sessions. `CONTEXT.md` exists at repo root. The framework maintains these files automatically as the project progresses through phases.

#### Key Patterns to Extract

| Pattern | Description | Target Skill |
|---------|-------------|--------------|
| Five-phase loop | Discuss → Plan → Execute → Verify → Ship | Overall pipeline |
| Fresh context subagents | 200k-token clean context per executor | `/execute` |
| STATE.md / CONTEXT.md | Persistent artifacts surviving session boundaries | `/execute`, `/reflect` |
| Verification step | Built-in quality gate before shipping | `/verify` |
| Cross-runtime installer | One installer handles all AI coding tools | Installation |
| Context rot prevention | The core insight: degrade gracefully or prevent degradation | All skills |

---

### 4. Grill Me — Socratic Design Inquiry

- **Repo**: https://github.com/mattpocock/skills (skill at `skills/productivity/grill-me/SKILL.md`)
- **Author**: Matt Pocock
- **Install**: `npx skills@latest add mattpocock/skills`

#### What It Is

`/grill-me` is a skill that "interviews the user exhaustively about a plan or design until mutual understanding is achieved, resolving each branch of the decision tree."

The most common failure mode is **misalignment** — you think the agent understands what you want, but it doesn't. The fix is a "grilling session" where the agent asks detailed questions *before* coding begins.

> "No-one knows exactly what they want" — David Thomas & Andrew Hunt

The engineering variant `/grill-with-docs` extends this by also building a shared language (`CONTEXT.md`) and ADRs.

#### The SKILL.md (Full Content)

The entire skill is remarkably concise — just four directives:

```yaml
---
name: grill-me
description: >
  A skill that interviews the user exhaustively about a plan or design
  until mutual understanding is achieved, resolving each branch of the
  decision tree. Use when the user wants to stress-test a plan, get
  questioned on their design, or says "grill me".
---

Interview me relentlessly about every aspect of this plan until we
reach a shared understanding. Walk down each branch of the design tree,
resolving dependencies between decisions one-by-one. For every question,
provide a recommended answer.

Ask questions one at a time.

If a question can be answered by exploring the codebase, explore the
codebase instead.
```

#### Key Patterns to Extract

| Pattern | Description | Target Skill |
|---------|-------------|--------------|
| Relentless questioning | Don't accept vague requirements; walk the decision tree | `/clarify` |
| One question at a time | Avoid overwhelm; depth over breadth | `/clarify` |
| Recommended answers | Provide a suggested answer per question to reduce friction | `/clarify` |
| Codebase-first | If answerable by exploring code, do that instead of asking | `/clarify` |
| Decision tree resolution | Resolve dependencies between decisions one-by-one | `/clarify` |

#### Related Skills from the Same Author

| Skill | Purpose |
|-------|---------|
| `/grill-with-docs` | Engineering variant: builds CONTEXT.md + ADRs alongside the interview |
| `/improve-codebase-architecture` | Architecture improvement |
| `/tdd` | Test-driven development |
| `/to-issues` | Convert discussion to GitHub issues |
| `/to-prd` | Convert discussion to PRD |
| `/triage` | Bug triage |
| `/diagnose` | Systematic diagnosis |
| `/zoom-out` | Step back and see the bigger picture |

---

### 5. Supplementary: vibe-check (Grill Me for Non-Engineers)

- **Repo**: https://github.com/TexasBedouin/vibe-check
- **Author**: Amer Arab (12-year product manager)
- **Stars**: ~304
- **Install**: `npx skills add TexasBedouin/vibe-check`

vibe-check positions the human as PM and the AI as engineer, targeting complete beginners. It extends the grill-me concept into a 10-phase flow: Discovery → UX mapping → Hidden decisions → Tech stack → Plan document → Build checkpoints → Build basics → Growth loops → Marketplace honesty → Checkup Mode.

Not directly used in qingshan-skills, but the "hidden decision surfacing" and "checkup mode" concepts are worth noting.

---

## Planned Project Structure

```
qingshan-skills/
├── CLAUDE.md                    # Project instructions (→ AGENTS.md)
├── LICENSE                      # MIT
├── README.md                    # Overview and installation
├── SKILL.md                     # Root skill: routing table + behavioral contract
├── ETHOS.md                     # Core principles referenced by every skill
├── AGENTS.md                    # Skill catalog and contributor guide
│
├── skills/
│   ├── clarify/
│   │   └── SKILL.md             # Goal/scope/constraint clarification (← Grill Me + Superpowers brainstorming)
│   ├── plan/
│   │   └── SKILL.md             # Task decomposition + decision grading (← gstack autoplan + Superpowers writing-plans)
│   ├── execute/
│   │   └── SKILL.md             # All engineering changes; TDD default; Context Gate (← Superpowers subagent + GSD fresh context)
│   ├── investigate/
│   │   └── SKILL.md             # Root-cause investigation: no facts, no fix (← Superpowers debugging + gstack investigate)
│   ├── verify/
│   │   └── SKILL.md             # Proof before completion; review is a dimension here (← Superpowers verification + gstack review)
│   └── reflect/
│       └── SKILL.md             # Selective durable learning (← gstack retro + learn)
│
├── prompts/
│   ├── fresh-worker.md          # Fresh-context worker prompt
│   ├── spec-reviewer.md         # Spec compliance reviewer prompt
│   └── quality-reviewer.md      # Quality reviewer prompt
│
└── docs/
    ├── references.md            # This file
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

Common paths (from the design doc): small docs change → `/clarify → /execute → /verify`; bug fix → `/investigate → /execute → /verify`; perf tuning → `/investigate → /plan → /execute → /verify`.

## Cross-Reference: File Interface Mapping

| qingshan-skills File | Draws From | Key Interface Elements |
|---------------------|------------|----------------------|
| `SKILL.md` (root) | gstack root SKILL.md + Superpowers `using-superpowers` | Routing table by task type, risk-weighted entry, behavioral contract |
| `ETHOS.md` | gstack ETHOS.md + CLAUDE.md philosophy | Understand Before Acting, Risk Determines Process, Minimal/Surgical, Evidence Before Claims, Preserve Context Quality |
| `skills/clarify/SKILL.md` | Grill Me + Superpowers brainstorming | One question at a time, recommended answers, decision-tree walk, codebase-first, brainstorming hard gate scaled by risk |
| `skills/plan/SKILL.md` | gstack autoplan + Superpowers writing-plans | Decision grading (Mechanical/Taste/User Challenge), task decomposition, validation + rollback strategy |
| `skills/execute/SKILL.md` | Superpowers subagent + TDD + GSD fresh context | Context Gate, TDD default for high-risk code, fresh-context workers, surgical edits |
| `prompts/` | Superpowers implementer/spec-reviewer/code-quality prompts | Worker + reviewer prompts, only where fresh-context execution requires them |
| `skills/investigate/SKILL.md` | Superpowers systematic-debugging + gstack investigate | No facts no fix; reproduce → evidence → narrow → hypothesis → test; baseline for perf |
| `skills/verify/SKILL.md` | Superpowers verification-before-completion + gstack review | Task-type-specific proof, review as a dimension, acceptance-criteria status |
| `skills/reflect/SKILL.md` | gstack retro + learn | Selective durable learning; reject chronological/generic noise |

## Key Design Decisions

| Decision | Rationale | Source |
|----------|-----------|--------|
| `description` = trigger only | Prevents agent from reading description as shortcut, skipping full skill body | Superpowers CSO |
| Rationalization prevention tables | Agents find excuses to skip discipline; enumerate and counter each one | Superpowers |
| Decision classification (Mechanical/Taste/Challenge) | Prevents decision fatigue AND decision theft | gstack autoplan |
| Fresh subagent per task | Prevents context rot; coordinator keeps orchestration, workers get clean context | GSD + Superpowers |
| `benefits-from` soft dependency | Skills reference each other without hard coupling | gstack |
| Proactive routing table | User doesn't need to know which skill to invoke; natural language dispatches | gstack |
| Surgical changes as constraint | Distinguishes from other frameworks — minimal touch is a hard rule, not a preference | Personal philosophy |
| One question at a time | Avoid overwhelm; depth over breadth | Grill Me |
| Hard gate before implementation | No code until design approved; even trivial projects | Superpowers brainstorming |
| "No fixes without investigation" | Prevents symptom-fixing; forces root cause analysis | gstack investigate |
