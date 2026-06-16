# qingshan-skills Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build the six-skill qingshan-skills methodology from the approved design spec.

**Architecture:** Keep the skill library as Markdown-first artifacts with a small Bash validator. The root `SKILL.md` routes by task type and risk; `ETHOS.md` defines shared principles; each core skill owns one failure mode; tests combine structural validation with pressure scenarios.

**Tech Stack:** Markdown skill files, Bash validation script, Git. No package manager or runtime dependency is required.

---

## File Structure

- Create: `SKILL.md` — root routing table and behavioral contract.
- Create: `ETHOS.md` — shared principles and non-negotiables.
- Create: `README.md` — project overview and quick start.
- Create: `docs/philosophy.md` — methodology explanation.
- Create: `docs/installation.md` — cross-agent installation notes.
- Create: `skills/clarify/SKILL.md` — shared-understanding workflow.
- Create: `skills/plan/SKILL.md` — task decomposition and decision grading.
- Create: `skills/execute/SKILL.md` — scoped execution, TDD, and Context Gate.
- Create: `skills/investigate/SKILL.md` — evidence-first diagnosis.
- Create: `skills/verify/SKILL.md` — completion proof and review checks.
- Create: `skills/reflect/SKILL.md` — selective learning capture.
- Create: `prompts/fresh-worker.md` — fresh-context execution prompt.
- Create: `prompts/spec-reviewer.md` — spec compliance reviewer prompt.
- Create: `prompts/quality-reviewer.md` — quality reviewer prompt.
- Create: `scripts/validate-skills.sh` — structural validator.
- Create: `tests/pressure-scenarios/simple-task-overprocessing.md`
- Create: `tests/pressure-scenarios/feature-ambiguity.md`
- Create: `tests/pressure-scenarios/user-decision-theft.md`
- Create: `tests/pressure-scenarios/bug-guesswork.md`
- Create: `tests/pressure-scenarios/performance-guesswork.md`
- Create: `tests/pressure-scenarios/context-rot.md`
- Create: `tests/pressure-scenarios/verification-shortcut.md`
- Create: `tests/pressure-scenarios/scope-creep.md`
- Modify: `AGENTS.md` — replace the old eight-skill project description with the six-skill model.
- Modify: `docs/references.md` — update the composition note from eight skills to six skills.

## Validation Contract

Run:

```bash
bash scripts/validate-skills.sh
```

Expected passing output:

```text
OK qingshan-skills validation passed
```

The validator must fail before core skill files exist, then pass after implementation. It must check:

- root `SKILL.md`, `ETHOS.md`, `README.md`, `docs/philosophy.md`, and `docs/installation.md` exist
- all six `skills/<name>/SKILL.md` files exist
- each skill has YAML frontmatter with `name` and `description`
- every description starts with `Use when`
- no skill description contains workflow shortcut terms: `step`, `workflow`, `first`, `then`
- every skill includes `Purpose`, `When to Use`, `When NOT to Use`, `Risk Gate`, `Workflow`, `Hard Rules`, `Rationalization Prevention`, `Outputs`, and `Handoff`
- all eight pressure scenario files exist and include `Trigger`, `Expected route`, `Shortcut risk`, and `Pass condition`

## Task 1: Add Failing Validation and Pressure Scenarios

**Files:**
- Create: `scripts/validate-skills.sh`
- Create: `tests/pressure-scenarios/*.md`

- [ ] **Step 1: Create the validator**

Create `scripts/validate-skills.sh` as an executable Bash script. It must fail fast with `ERROR: <message>` and exit non-zero when a required file, section, or pressure scenario field is missing.

- [ ] **Step 2: Create eight pressure scenarios**

Each scenario file must use this exact shape:

```markdown
# <Scenario Name>

## Trigger
<user request that should activate the methodology>

## Expected route
<skill path, such as /investigate -> /execute -> /verify>

## Shortcut risk
<what an undisciplined agent would likely skip>

## Pass condition
<observable behavior that proves the skill resisted the shortcut>
```

- [ ] **Step 3: Run RED validation**

Run:

```bash
bash scripts/validate-skills.sh
```

Expected: FAIL because root docs and six skill files do not exist yet.

## Task 2: Add Root Infrastructure and Documentation

**Files:**
- Create: `SKILL.md`
- Create: `ETHOS.md`
- Create: `README.md`
- Create: `docs/philosophy.md`
- Create: `docs/installation.md`

- [ ] **Step 1: Create `ETHOS.md`**

Include these seven principles: Understand Before Acting, Risk Determines Process, Minimal Surgical Change, Readable Is Documented, Type Safety First, Evidence Before Claims, Preserve Context Quality. Include the non-negotiables from the design spec.

- [ ] **Step 2: Create root `SKILL.md`**

Use trigger-only frontmatter:

```yaml
---
name: qingshan-skills
description: Use when coordinating software engineering work through qingshan-skills, routing tasks by risk, evidence, scope, and completion proof
---
```

The body must include routing by task type, risk gates, the six-skill pipeline, decision grading, and a rule to read `ETHOS.md` before applying any core skill.

- [ ] **Step 3: Create `README.md`, `docs/philosophy.md`, and `docs/installation.md`**

Keep them concise. README explains what the library is and lists the six skills. Philosophy explains the four source failure models and qingshan constraints. Installation explains copying or symlinking the repo into agent-specific skill directories without assuming one runtime.

## Task 3: Add Core Skills

**Files:**
- Create: `skills/clarify/SKILL.md`
- Create: `skills/plan/SKILL.md`
- Create: `skills/execute/SKILL.md`
- Create: `skills/investigate/SKILL.md`
- Create: `skills/verify/SKILL.md`
- Create: `skills/reflect/SKILL.md`

- [ ] **Step 1: Create `/clarify`**

Frontmatter:

```yaml
---
name: clarify
description: Use when a software engineering task has unclear goals, scope, constraints, acceptance criteria, tradeoffs, or user-facing decisions
---
```

The body must center shared understanding, risk-scaled brainstorming, one question at a time, recommended answers, codebase-first exploration, and handoff to `/plan`, `/execute`, or `/investigate`.

- [ ] **Step 2: Create `/plan`**

Frontmatter:

```yaml
---
name: plan
description: Use when a clarified software engineering goal needs task decomposition, decision grading, sequencing, validation strategy, or rollback planning
---
```

The body must include Mechanical, Taste, and User Challenge decision grades.

- [ ] **Step 3: Create `/execute`**

Frontmatter:

```yaml
---
name: execute
description: Use when implementing a planned software engineering change, refactor, configuration update, documentation change, or fresh-context task
---
```

The body must include the Context Gate, scoped edit rules, TDD default for high-risk code changes, and prompt handoff to `prompts/fresh-worker.md`.

- [ ] **Step 4: Create `/investigate`**

Frontmatter:

```yaml
---
name: investigate
description: Use when diagnosing bugs, failing tests, deployment failures, performance issues, security concerns, stability problems, or unknown root causes
---
```

The body must enforce no facts, no fix; reproduction; evidence collection; baseline for performance; and environment boundaries for deployment issues.

- [ ] **Step 5: Create `/verify`**

Frontmatter:

```yaml
---
name: verify
description: Use before claiming software engineering work is complete, fixed, passing, shipped, optimized, documented, or ready for review
---
```

The body must define task-specific verification and review dimensions.

- [ ] **Step 6: Create `/reflect`**

Frontmatter:

```yaml
---
name: reflect
description: Use after completing software engineering work when reusable lessons, project invariants, verification commands, or skill improvements should be captured
---
```

The body must distinguish durable learning from knowledge-base noise.

## Task 4: Add Fresh-Context and Review Prompts

**Files:**
- Create: `prompts/fresh-worker.md`
- Create: `prompts/spec-reviewer.md`
- Create: `prompts/quality-reviewer.md`

- [ ] **Step 1: Create `fresh-worker.md`**

Prompt must instruct a worker to implement only the assigned task, respect existing changes, run specified verification, and report changed files plus status.

- [ ] **Step 2: Create `spec-reviewer.md`**

Prompt must instruct a reviewer to compare actual changes against the task/spec line-by-line, report missing requirements, extras, and approval status.

- [ ] **Step 3: Create `quality-reviewer.md`**

Prompt must instruct a reviewer to check scope control, readability, type safety, error handling, verification evidence, and maintainability.

## Task 5: Update Project Catalog and References

**Files:**
- Modify: `AGENTS.md`
- Modify: `docs/references.md`

- [ ] **Step 1: Update `AGENTS.md`**

Replace the old eight-skill goal with six skills: `/clarify`, `/plan`, `/execute`, `/investigate`, `/verify`, `/reflect`. Preserve the project philosophy and conventions, but remove references that require separate `/tdd`, `/review`, or `/ship` top-level skills.

- [ ] **Step 2: Update `docs/references.md`**

Change the line saying qingshan-skills compresses four layers into eight skills to six skills. Update target-skill mappings where they still reference removed top-level skills.

## Task 6: Verify, Fix, and Commit

**Files:**
- Modify only files touched by this plan.

- [ ] **Step 1: Run validation**

Run:

```bash
bash scripts/validate-skills.sh
```

Expected:

```text
OK qingshan-skills validation passed
```

- [ ] **Step 2: Inspect diff**

Run:

```bash
git diff --check
git diff --stat
```

Expected: no whitespace errors; diff only includes planned files.

- [ ] **Step 3: Commit**

Run:

```bash
git add SKILL.md ETHOS.md README.md AGENTS.md docs scripts skills prompts tests
git commit -m "Implement qingshan skill library"
```
