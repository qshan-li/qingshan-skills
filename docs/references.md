# References — Source Skills and Project Structure

## Source Skills

These are the four source skill systems that qingshan-skills draws from: gstack, Superpowers, GSD, and Matt Pocock's skills. Each contributes a distinct capability dimension. Grill Me is treated as a flagship pattern inside Matt Pocock's skills, not as a separate fourth source.

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

For qingshan-skills, the approved gstack absorption is deliberately narrower than gstack itself. The system should absorb Decision Briefs, scope drift detection, review readiness dashboards, adversarial review, release gates inside `/verify`, durable decision logs, and soft dependencies. It should not absorb the full role catalog, telemetry/runtime preamble, automatic version bumping, changelog generation, PR creation, or "Boil the Ocean" as an implementation principle.

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

### Matt Pocock's skills — The Essence is **Control-Preserving Real Engineering**

Matt Pocock's skills supply the control-preserving posture and several concrete engineering patterns that qingshan-skills absorbs selectively: shared language, sparse ADRs, feedback-loop-first debugging, behavior-first TDD, vertical slices, and the Grill Me clarification loop.

Grill Me is the most direct source for `/clarify` and its insight is the most fundamental:

> **The most common failure mode is believing the agent understood you when it didn't.**

Every mechanism exists to force out the real requirement:
- Ask **one question at a time** (depth-first, not a bombardment)
- Attach a **recommended answer** to each question (lower your answer cost)
- If the codebase can answer it, **read the code instead of asking**
- Resolve the decision tree **one branch at a time**

- *The subtlety:* it produces no code — only **shared understanding.** That consensus is the prerequisite for all downstream work (plan / implement / review).

### How the Four Compose

```
Matt Pocock's skills / Grill Me  forces out "what we're really doing" and preserves engineer control   ← consensus/control layer
GSD                              ensures "keep doing it right"                                        ← context layer
Superpowers                      enforces "do it by the rules"                                        ← discipline layer
gstack                           decides "who does what, when to stop"                                ← orchestration layer
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

For qingshan-skills, `STATE.md` and `CONTEXT.md` are treated as project-local continuity tools, not as the whole learning system. Cross-project learning requires a promotion pipeline: task state → project context → project learning → global memory → skill rule. `/reflect` is the gate that decides which layer a verified lesson belongs in and prevents one-off project facts from polluting future projects.

#### Key Patterns to Extract

| Pattern | Description | Target Skill |
|---------|-------------|--------------|
| Five-phase loop | Discuss → Plan → Execute → Verify → Ship | Overall pipeline |
| Fresh context subagents | 200k-token clean context per executor | `/execute` |
| STATE.md / CONTEXT.md | Persistent artifacts surviving session boundaries | `/execute`, `/reflect` |
| Reflect / learn promotion | Convert verified project experience into conditional cross-project rules | `/reflect` |
| Verification step | Built-in quality gate before shipping | `/verify` |
| Cross-runtime installer | One installer handles all AI coding tools | Installation |
| Context rot prevention | The core insight: degrade gracefully or prevent degradation | All skills |

---

### 4. Matt Pocock's skills — Skills For Real Engineers

- **Repo**: https://github.com/mattpocock/skills
- **Author**: Matt Pocock (Total TypeScript)
- **License**: MIT
- **Plugin name**: `mattpocock-skills` (15 published skills)
- **Install**: `npx skills@latest add mattpocock/skills` (skills.sh installer), then run `/setup-matt-pocock-skills` once per repo to configure the issue tracker, triage-label vocabulary, and domain-doc layout the engineering skills consume

#### What It Is

A personal collection of agent skills pitched as **"skills for real engineers — not vibe coding."** The explicit positioning is the opposite of GSD/BMAD/Spec-Kit: those frameworks *own the process*, which "takes away your control and makes bugs in the process hard to resolve." These skills are instead **small, easy to adapt, composable, model-agnostic**, and grounded in conventional engineering fundamentals.

The README is organized around **four failure modes** the skills exist to fix — a useful map of the whole repo:

| Failure mode | Root cause | Fix (skill) |
|--------------|-----------|-------------|
| The agent didn't do what I want | Misalignment — you thought it understood, it didn't | `/grill-me`, `/grill-with-docs` (grilling session before coding) |
| The agent is way too verbose | No shared language; agent reinvents jargon each turn | `/grill-with-docs` building a `CONTEXT.md` glossary (DDD ubiquitous language) |
| The code doesn't work | No feedback loops; agent flies blind | `/tdd` (red-green-refactor), `/diagnose` (debugging loop) |
| We built a ball of mud | Agents accelerate software entropy | `/to-prd`, `/zoom-out`, `/improve-codebase-architecture` (care about design, deep modules) |

The repo **dogfoods its own advice**: its root `CONTEXT.md` is a worked example of the ubiquitous-language technique, pinning down terms like *Issue tracker*, *Issue*, and *Triage role* and explicitly recording resolved ambiguities (e.g. retiring "backlog" as overloaded).

#### File Structure

Skills are organized into six **bucket folders** with a strict promotion rule (`CLAUDE.md`): every skill in `engineering/`, `productivity/`, or `misc/` must appear in both the top-level `README.md` and `.claude-plugin/plugin.json`; skills in `personal/`, `in-progress/`, or `deprecated/` must appear in neither.

```
mattpocock/skills/
├── README.md                   # Four-failure-mode narrative + skill reference
├── CLAUDE.md                   # Bucket promotion rules
├── CONTEXT.md                  # Dogfooded ubiquitous-language glossary
├── LICENSE                     # MIT
├── .claude-plugin/plugin.json  # Registry of the 15 published skills
├── docs/adr/                   # Repo's own ADRs
├── scripts/                    # link-skills.sh, list-skills.sh
└── skills/
    ├── engineering/   (10)     # Daily code work
    ├── productivity/  (5)      # Daily non-code workflow
    ├── misc/          (4)      # Kept around, rarely used
    ├── personal/      (2)      # Tied to author's setup, not promoted
    ├── in-progress/   (4)      # Drafts (review, writing-*)
    └── deprecated/    (4)      # No longer used
```

#### The 15 Published Skills

| Bucket | Skill | Purpose |
|--------|-------|---------|
| engineering | `diagnose` | Disciplined diagnosis loop: reproduce → minimise → hypothesise → instrument → fix → regression-test |
| engineering | `grill-with-docs` | Grilling that challenges the plan against the domain model, sharpens terminology, updates `CONTEXT.md`/ADRs inline |
| engineering | `triage` | Triage issues through a state machine driven by triage roles |
| engineering | `improve-codebase-architecture` | Find deepening opportunities, informed by `CONTEXT.md` + `docs/adr/` |
| engineering | `setup-matt-pocock-skills` | Scaffold the per-repo config (issue tracker, triage labels, doc layout) other skills consume |
| engineering | `tdd` | Red-green-refactor, one vertical slice at a time |
| engineering | `to-issues` | Break a plan/spec/PRD into independently-grabbable issues via tracer-bullet vertical slices |
| engineering | `to-prd` | Turn the current conversation into a PRD published to the issue tracker |
| engineering | `zoom-out` | Ask the agent for broader context / a higher-level perspective on unfamiliar code |
| engineering | `prototype` | Throwaway prototype to flesh out a design (terminal app for state/logic, or multiple UI variations) |
| productivity | `caveman` | Ultra-compressed communication; ~75% fewer tokens, full technical accuracy |
| productivity | `grill-me` | Relentless interview about a plan/design until every branch of the decision tree is resolved |
| productivity | `handoff` | Compact the conversation into a handoff document for another agent |
| productivity | `teach` | Teach a skill/concept over multiple sessions using the cwd as a stateful workspace |
| productivity | `write-a-skill` | Create new skills with structure, progressive disclosure, and bundled resources |
| misc | `git-guardrails-claude-code` | Claude Code hooks blocking dangerous git commands before they execute |
| misc | `migrate-to-shoehorn` | Migrate test files from `as` assertions to @total-typescript/shoehorn |
| misc | `scaffold-exercises` | Create exercise directory structures (sections/problems/solutions/explainers) |
| misc | `setup-pre-commit` | Husky pre-commit hooks with lint-staged, Prettier, type check, tests |

`personal/` (`edit-article`, `obsidian-vault`), `in-progress/` (`review`, `writing-beats`/`-fragments`/`-shape`), and `deprecated/` (`design-an-interface`, `qa`, `request-refactor-plan`, `ubiquitous-language`) are intentionally excluded from the published set.

#### Flagship: `/grill-me` and `/grill-with-docs`

These are the author's most popular skills and qingshan-skills' direct source for `/clarify`. The entire `/grill-me` body is four directives:

```yaml
---
name: grill-me
description: Interview the user relentlessly about a plan or design until reaching shared understanding, resolving each branch of the decision tree. Use when user wants to stress-test a plan, get grilled on their design, or mentions "grill me".
---

Interview me relentlessly about every aspect of this plan until we reach a
shared understanding. Walk down each branch of the design tree, resolving
dependencies between decisions one-by-one. For each question, provide your
recommended answer.

Ask the questions one at a time.

If a question can be answered by exploring the codebase, explore the
codebase instead.
```

`/grill-with-docs` is the same grilling session plus an inline documentation layer:

- **`CONTEXT.md` is a glossary and nothing else** — "totally devoid of implementation details," not a spec or scratch pad. Terms are captured the moment they are resolved, never batched. A root `CONTEXT-MAP.md` extends this to repos with multiple bounded contexts.
- **ADRs are offered sparingly** — only when all three hold: *hard to reverse*, *surprising without context*, and *the result of a real trade-off*. If any is missing, skip the ADR.
- **Challenge, sharpen, cross-reference** — call out terms that conflict with the glossary, propose precise canonical terms for fuzzy language, and surface contradictions between stated behavior and the actual code.

#### Key Patterns to Extract

| Pattern | Description | Target Skill |
|---------|-------------|--------------|
| Relentless questioning | Don't accept vague requirements; walk the decision tree | `/clarify` |
| One question at a time | Depth over breadth; avoid overwhelm | `/clarify` |
| Recommended answers | Attach a suggested answer per question to lower answer cost | `/clarify` |
| Codebase-first | If answerable by exploring code, do that instead of asking | `/clarify` |
| Decision-tree resolution | Resolve dependencies between decisions one-by-one | `/clarify` |
| Shared-language glossary (`CONTEXT.md`) | A pure glossary cuts verbosity and aids navigation session after session | `/clarify`, `/reflect` |
| ADR three-gate rule | Record a decision only when hard-to-reverse ∧ surprising ∧ a real trade-off | `/plan`, `/reflect` |
| Feedback-loop-first diagnosis | Build a fast, deterministic pass/fail signal before hypothesizing | `/investigate` |
| Ranked falsifiable hypotheses | Avoid anchoring on the first plausible cause | `/investigate` |
| Behavior-first TDD | Test observable behavior through public interfaces, one behavior at a time | `/execute` |
| Tracer-bullet decomposition | Break work into independently verifiable vertical slices | `/plan`, `/execute` |
| Architecture deepening | Resist the "ball of mud"; seek deep modules informed by the domain language | Reference for `/plan`, `/reflect` |

qingshan-skills absorbs Matt Pocock's control-preserving posture and selected engineering rules: grilling and shared language, sparse ADR capture, feedback-loop-first debugging, behavior-first TDD, and vertical-slice decomposition. It does **not** absorb the whole issue tracker, triage, PRD, prototype, or architecture-report workflow; those remain reference material because qingshan's 6-skill design stays deliberately small and composable.

---

### 5. Supplementary: vibe-check (Grill Me for Non-Engineers)

- **Repo**: https://github.com/TexasBedouin/vibe-check
- **Author**: Amer Arab (12-year product manager)
- **Stars**: ~304
- **Install**: `npx skills add TexasBedouin/vibe-check`

vibe-check positions the human as PM and the AI as engineer, targeting complete beginners. It extends the grill-me concept into a 10-phase flow: Discovery → UX mapping → Hidden decisions → Tech stack → Plan document → Build checkpoints → Build basics → Growth loops → Marketplace honesty → Checkup Mode.

Not directly used in qingshan-skills, but the "hidden decision surfacing" and "checkup mode" concepts are worth noting.

---

### 6. Supplementary: Trellis - Repo-Native Agent Harness

- **Repo**: https://github.com/mindfold-ai/Trellis
- **Author**: Mindfold LLC
- **npm**: `@mindfoldhq/trellis`
- **License**: AGPL-3.0-only
- **Language**: TypeScript-first monorepo with Python runtime hooks/scripts and Markdown agent templates
- **Stars**: ~10.5k
- **Install**: `npm install -g @mindfoldhq/trellis@latest`, then `trellis init -u <developer-name>`

#### What It Is

Trellis is an "out-of-the-box engineering framework for AI coding." Its central move is to persist the working context that coding agents usually lose: project specs, task artifacts, per-developer journals, sub-agent manifests, and platform integration files all live in or near the repository.

The product thesis overlaps with GSD's context-rot concern, but Trellis is more concrete and runtime-oriented. It generates a `.trellis/` project layer plus platform-specific files for Claude Code, Codex, Cursor, OpenCode, Gemini, Kiro, Qoder, CodeBuddy, Copilot, Droid, Pi, Reasonix, and other agent surfaces. The local repo becomes the source of truth; platform integrations inject that truth back into the AI session.

Trellis is useful to qingshan-skills as a supplementary reference, not as a fifth source in the authoritative design. Its value is in its concrete implementation of repo-local specs, task artifacts, context injection, multi-agent worker channels, and session memory.

#### File Structure

```
trellis/
├── README.md / README_CN.md
├── AGENTS.md                   # Trellis-managed repo instructions + GitNexus notes in the source repo
├── CLAUDE.md                   # Contributor guidance
├── package.json                # pnpm workspace root
├── pnpm-workspace.yaml
├── LICENSE                     # AGPL-3.0-only
│
├── packages/
│   ├── cli/                    # @mindfoldhq/trellis CLI package
│   │   ├── bin/trellis.js
│   │   ├── src/
│   │   │   ├── cli/            # CLI entrypoint
│   │   │   ├── commands/       # init, update, workflow, mem, channel, uninstall
│   │   │   ├── configurators/  # per-platform setup
│   │   │   ├── migrations/     # manifest migrations
│   │   │   ├── templates/      # generated .trellis + platform files
│   │   │   └── utils/
│   │   ├── test/               # Vitest coverage for commands/templates
│   │   └── scripts/            # release, manifest, template copy scripts
│   │
│   └── core/                   # @mindfoldhq/trellis-core SDK
│       ├── src/
│       │   ├── channel/        # event-sourced multi-agent channel runtime
│       │   ├── mem/            # local session-history search/extraction
│       │   ├── task/           # task paths, schema, records, phases
│       │   └── testing/
│       └── test/
│
├── .claude/ .codex/ .cursor/ .opencode/ .pi/
├── .trellis/                   # Trellis dogfoods its generated project layer
├── assets/
├── docs-site/
├── drafts/
└── marketplace/
```

#### Generated Project Layer

The important artifact is what `trellis init` writes into a user repository:

```
.trellis/
├── workflow.md                 # phase model, routing rules, workflow-state breadcrumbs
├── config.yaml                 # hooks, channel limits, Codex dispatch mode, registry sources
├── spec/                       # package/layer-scoped coding specs and thinking guides
├── tasks/
│   └── MM-DD-slug/
│       ├── task.json           # status, branch, scope, parent/child metadata
│       ├── prd.md              # requirements and acceptance criteria
│       ├── design.md           # optional technical design
│       ├── implement.md        # optional execution plan
│       ├── implement.jsonl     # curated context manifest for implement agents
│       └── check.jsonl         # curated context manifest for check agents
├── workspace/<developer>/      # deliberate journals and session indexes
├── agents/
│   ├── implement.md            # platform-agnostic channel runtime worker
│   └── check.md                # platform-agnostic channel runtime reviewer
└── scripts/
    ├── task.py                 # task lifecycle and context manifests
    ├── get_context.py          # package/spec/workflow context loader
    ├── add_session.py          # workspace journal append
    └── hooks/                  # lifecycle hooks such as Linear sync
```

Platform directories then adapt the same project layer to each AI tool:

```
.agents/skills/                 # shared bundled Trellis skills
.codex/skills/                  # Codex-specific skill wrappers
.codex/agents/                  # trellis-research / implement / check agents
.claude/agents/                 # Claude sub-agent definitions
.cursor/agents/
.opencode/plugins/
.github/prompts/
...
```

#### Workflow Model

Trellis' README describes a 4-phase loop:

1. **Plan** - `trellis-brainstorm` clarifies requirements one question at a time, writes `prd.md`, and curates `implement.jsonl` / `check.jsonl` context.
2. **Implement** - `trellis-implement` writes code from the task artifacts and injected specs.
3. **Verify** - `trellis-check` reviews the diff against specs and task artifacts, then runs lint, type-check, and tests.
4. **Finish** - final check, spec update, task archive, and workspace journal update.

The generated `workflow.md` expands this into three operational phases: Plan, Execute, Finish. A key implementation detail is the `[workflow-state:*]` block contract: hooks parse those blocks to inject per-turn breadcrumbs. If a required workflow step is missing from the breadcrumb, agents silently skip it; Trellis treats that as a testable runtime contract.

#### Bundled Skills and Agents

Trellis ships both workflow skills and runtime workers:

| Surface | Role |
|---------|------|
| `brainstorm` | Turn a request into task artifacts; one question at a time; inspect repo evidence before asking |
| `before-dev` | Load task artifacts and applicable `.trellis/spec/` guidelines before writing code |
| `check` | Inspect diffs, read specs, run lint/typecheck/tests, and fix mechanical issues |
| `update-spec` | Promote implementation learnings into executable code-spec documents |
| `trellis-meta` | Explain and modify the local Trellis architecture safely |
| `trellis-channel` | Use `trellis channel` for durable multi-agent collaboration and forums |
| `trellis-session-insight` | Search/extract local Claude/Codex conversation history via `trellis mem` |
| `trellis-implement` agent | Worker that implements from PRD/design/implement/spec context; cannot commit |
| `trellis-check` agent | Worker that reviews uncommitted diffs against specs and can self-fix mechanical issues; cannot commit |

#### Multi-Agent Channel Runtime

Trellis v0.6 adds `trellis channel`, a local event-sourced collaboration runtime. Channel state is stored outside the project tree under `~/.trellis/channels/<project>/<channel>/events.jsonl`, with file-locked sequence numbers, durable idempotency keys, worker lifecycle management, forum/thread channels, interrupt/kill commands, and raw message inspection.

This is more runtime-heavy than qingshan-skills needs, but it is a concrete reference for:

- durable worker inboxes instead of ephemeral prompt handoffs
- operator-visible progress inspection (`messages --raw`, thread/forum views)
- separating generated channel runtime agents under `.trellis/agents/` from per-platform sub-agent wrappers
- making the main session own commits while worker agents implement or check

#### Memory Model

Trellis separates deliberate project memory from raw session history:

- `.trellis/spec/` holds project-wide executable coding contracts.
- `.trellis/tasks/` holds task-local PRD/design/implementation/review context.
- `.trellis/workspace/<developer>/` holds written journals and indexes.
- `trellis mem` reads raw Claude Code and Codex JSONL logs already on disk, slices them by phase (`brainstorm`, `implement`, `all`), and never uploads them.

The `trellis-session-insight` skill is intentionally a capability skill, not a forced workflow: it teaches when to retrieve past dialogue, but leaves write-back destination to the live task. This matches qingshan-skills' `/reflect` concern: useful knowledge needs a promotion gate so session noise does not become global rules.

#### Key Patterns to Extract

| Pattern | Description | Target Skill |
|---------|-------------|--------------|
| Repo-native project layer | `.trellis/` makes specs, tasks, workflow, scripts, and journals first-class repo artifacts | `/execute`, `/reflect` |
| Spec injection by package/layer | Agents discover package/layer specs before editing instead of relying on remembered conventions | `/execute`, `/verify` |
| Task-local context manifests | `implement.jsonl` / `check.jsonl` curate exact files for sub-agents | `/execute`, `/verify` |
| Workflow-state breadcrumbs | Per-turn hooks parse `workflow.md` status blocks to keep agents in the right phase | Root SKILL.md |
| Main owns commits | Implement/check workers cannot commit, push, or merge; main session owns final integration | `/execute`, `/verify` |
| Spec update as finish step | Learned contracts are promoted after implementation, with code-spec depth for infra/cross-layer changes | `/reflect` |
| Session memory as retrieval capability | `trellis mem` is read-only raw history; write-back is contextual, not automatic | `/reflect` |
| Channel event log | Multi-agent collaboration can be made inspectable and durable through JSONL event logs | Future runtime reference |
| Platform adapters from one source | One template system emits skills, agents, hooks, prompts, and settings for many AI tools | Installation / runtime adapter design |

#### What qingshan-skills Should Not Absorb

qingshan-skills should not become Trellis:

- Do not add a mandatory `.trellis/` runtime or generated platform-file system to this project unless explicitly redesigning installation and runtime scope.
- Do not make task creation mandatory for every small change; qingshan-skills keeps risk-weighted process.
- Do not absorb a full event-sourced channel runtime; reference it only if fresh-context handoffs become insufficient.
- Do not replace `/reflect` with automatic spec updates. qingshan-skills keeps a selective memory promotion gate.
- Do not copy Trellis' platform-specific template catalog wholesale. This project's design remains six focused skills plus a small prompt surface.

The useful takeaway is operational: Trellis shows how to turn "the agent should remember project standards" into files, manifests, hooks, workers, and tests. qingshan-skills should borrow that concreteness only where it strengthens the existing minimal, surgical, verification-driven flow.

---

### 7. Supplementary: Andrej Karpathy Skills - Four-Principle Behavior Guardrail

- **Repo**: https://github.com/multica-ai/andrej-karpathy-skills
- **Author**: forrestchang / multica-ai
- **License**: MIT (declared in plugin metadata and README)
- **Language**: Markdown instruction files, Claude plugin metadata, Cursor rule
- **Stars**: ~176k
- **Install**: Claude Code plugin marketplace (`/plugin marketplace add forrestchang/andrej-karpathy-skills`, then `/plugin install andrej-karpathy-skills@karpathy-skills`) or copy/append `CLAUDE.md`

#### What It Is

andrej-karpathy-skills is a tiny instruction repo built around a single `CLAUDE.md`, a Claude Code skill wrapper, and a Cursor rule. It distills Andrej Karpathy's public critique of LLM coding agents into four behavior constraints:

| Principle | Failure It Prevents |
|-----------|---------------------|
| Think Before Coding | Silent assumptions, hidden confusion, missing tradeoffs |
| Simplicity First | Over-abstraction, speculative features, bloated APIs |
| Surgical Changes | Drive-by refactors, style drift, unrelated edits |
| Goal-Driven Execution | Vague "make it work" loops without concrete proof |

Its shape is intentionally small: no task system, no sub-agent runtime, no persistent memory, no installer logic beyond plugin metadata and copied instruction files. The value is the compression: it names the same failure modes qingshan-skills cares about in a form that can fit into one root instruction file or one reusable skill.

#### File Structure

```
andrej-karpathy-skills/
├── README.md                   # English overview, install, four principles
├── README.zh.md                # Chinese overview
├── CLAUDE.md                   # The portable root instruction payload
├── CURSOR.md                   # Cursor setup notes
├── EXAMPLES.md                 # Wrong-vs-right examples for each principle
├── .claude-plugin/
│   ├── plugin.json             # Claude Code plugin metadata
│   └── marketplace.json        # Marketplace package metadata
├── .cursor/
│   └── rules/
│       └── karpathy-guidelines.mdc  # alwaysApply Cursor project rule
└── skills/
    └── karpathy-guidelines/
        └── SKILL.md            # Reusable skill version of CLAUDE.md
```

#### Instruction Format

The same payload appears in three forms:

| Surface | Purpose |
|---------|---------|
| `CLAUDE.md` | Per-project root guidance, meant to be copied or merged into existing instructions |
| `skills/karpathy-guidelines/SKILL.md` | Claude Code plugin skill with `license: MIT` frontmatter |
| `.cursor/rules/karpathy-guidelines.mdc` | Cursor rule with `alwaysApply: true` |

The skill description is broader than Superpowers-style CSO: it says when to use the guideline and summarizes the behavioral intent. That is acceptable for this repo because the entire skill body is short and contains no multi-step procedure to accidentally skip.

#### Examples as Pressure Tests

`EXAMPLES.md` is the most useful supporting artifact. It gives concrete wrong-vs-right examples for:

- hidden assumptions in "export user data"
- multiple possible meanings of "make search faster"
- over-abstraction in a discount calculation
- speculative features in preference persistence
- drive-by refactoring while fixing one validator bug
- style drift while adding logging
- vague authentication fixes without success criteria
- multi-step rate limiting with verification checkpoints
- reproducing a duplicate-score sorting bug before fixing it

These examples are directly reusable as pressure scenarios for qingshan-skills tests because they make the failure observable: an agent either asks, simplifies, limits the diff, and verifies, or it does not.

#### Key Patterns to Extract

| Pattern | Description | Target Skill |
|---------|-------------|--------------|
| Four-rule compression | Understand first, keep it simple, change surgically, verify the goal | `ETHOS.md`, root `SKILL.md` |
| Senior-engineer overcomplication test | If a senior engineer would call it overcomplicated, simplify before shipping | `/execute` |
| Every changed line traces to request | Simple, reviewable rule for scope control | `/execute`, `/verify` |
| Orphan-only cleanup | Remove only unused code caused by the current change, not pre-existing dead code | `/execute` |
| Imperative-to-goal transform | Convert "do X" into success criteria and verification loop | `/clarify`, `/plan`, `/execute` |
| Wrong-vs-right examples | Use examples as behavior tests for methodology bypass and scope creep | Tests / pressure scenarios |
| Multi-surface portability | Same guidance can ship as root instructions, skill, or Cursor rule | Installation / runtime adapter notes |

#### Relationship to qingshan-skills

This repo largely converges with qingshan-skills' own philosophy. It reinforces the existing core rules rather than adding a new workflow layer:

- **Think Before Coding** maps to `/clarify` and the root "understand before acting" contract.
- **Simplicity First** maps to the minimal-solution and anti-overengineering rules in `/execute`.
- **Surgical Changes** maps to scope drift prevention and reviewable diffs.
- **Goal-Driven Execution** maps to task acceptance criteria, TDD when risk warrants it, and `/verify`.

qingshan-skills should not copy the whole text verbatim because the local `AGENTS.md`, `ETHOS.md`, and skill bodies already encode these principles with stronger project-specific routing and verification gates. The useful addition is to treat this repo as a concise external benchmark: if a qingshan-skills rule becomes more complicated than these four principles without adding verification power, it is probably drifting.

---

## Planned Project Structure

```
qingshan-skills/
├── CLAUDE.md                    # Project instructions (→ AGENTS.md)
├── LICENSE                      # MIT
├── README.md                    # Overview and installation
├── SKILL.md                     # Root skill: session-bootstrap routing enforcement
├── ETHOS.md                     # Core principles referenced by every skill
├── AGENTS.md                    # Skill catalog and contributor guide
│
├── skills/
│   ├── clarify/
│   │   └── SKILL.md             # Goal/scope/constraint clarification (← Matt Pocock's Grill Me + Superpowers brainstorming)
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
| `SKILL.md` (root) | gstack root SKILL.md + Superpowers `using-superpowers` | Session-bootstrap enforcement, routing table by task type, risk-weighted entry, meta anti-bypass table |
| `ETHOS.md` | gstack ETHOS.md + CLAUDE.md philosophy | Understand Before Acting, Risk Determines Process, Minimal/Surgical, Evidence Before Claims, Preserve Context Quality |
| `skills/clarify/SKILL.md` | Matt Pocock's Grill Me + Superpowers brainstorming | One question at a time, recommended answers, decision-tree walk, codebase-first, brainstorming hard gate scaled by risk |
| `skills/plan/SKILL.md` | gstack autoplan + Superpowers writing-plans | Decision grading (Mechanical/Taste/User Challenge), task decomposition, validation + rollback strategy |
| `skills/execute/SKILL.md` | Superpowers subagent + TDD + GSD fresh context | Context Gate, TDD default for high-risk code, fresh-context workers, surgical edits |
| `prompts/` | Superpowers implementer/spec-reviewer/code-quality prompts | Worker + reviewer prompts, only where fresh-context execution requires them |
| `skills/investigate/SKILL.md` | Superpowers systematic-debugging + gstack investigate | No facts no fix; reproduce → evidence → narrow → hypothesis → test; baseline for perf |
| `skills/verify/SKILL.md` | Superpowers verification-before-completion + gstack review | Task-type-specific proof, review as a dimension, acceptance-criteria status |
| `skills/reflect/SKILL.md` | gstack retro + learn + GSD context artifacts | Memory Promotion Gate; selective durable learning; reject chronological/generic noise and wrong generalization |

## Key Design Decisions

| Decision | Rationale | Source |
|----------|-----------|--------|
| `description` = trigger only | Prevents agent from reading description as shortcut, skipping full skill body | Superpowers CSO |
| Rationalization prevention tables | Agents find excuses to skip discipline; enumerate and counter each one | Superpowers |
| Root bootstrap enforcement | Workflow skills do not trigger themselves; the root skill checks each request before action | Superpowers `using-superpowers` |
| Decision classification (Mechanical/Taste/Challenge) | Prevents decision fatigue AND decision theft | gstack autoplan |
| Decision Briefs | Turns non-mechanical decisions into recommendation, alternatives, trade-offs, reversibility, and coverage differences | gstack AskUserQuestion format |
| Scope Drift Detection | Prevents passing tests from hiding missing, extra, changed, or unverifiable work | gstack review |
| Review Readiness Dashboard | Makes verification evidence and stale checks visible before release handoff | gstack ship |
| Adversarial Review | Finds production failure modes that friendly review and CI can miss | gstack review |
| Fresh subagent per task | Prevents context rot; coordinator keeps orchestration, workers get clean context | GSD + Superpowers |
| Memory promotion pipeline | Prevents project-local facts from becoming bad global rules; promotes repeated or high-risk lessons back into skills | GSD + gstack learn |
| Durable Decision Log | Keeps settled architecture, scope, tool, vendor, release, or reversal choices separate from reusable lessons | gstack decision memory |
| `benefits-from` soft dependency | Skills reference each other without hard coupling | gstack |
| Proactive routing table | User doesn't need to know which skill to invoke; natural language dispatches | gstack |
| Surgical changes as constraint | Distinguishes from other frameworks — minimal touch is a hard rule, not a preference | Personal philosophy |
| One question at a time | Avoid overwhelm; depth over breadth | Matt Pocock's Grill Me |
| Hard gate before implementation | No code until design approved; even trivial projects | Superpowers brainstorming |
| "No fixes without investigation" | Prevents symptom-fixing; forces root cause analysis | gstack investigate |
