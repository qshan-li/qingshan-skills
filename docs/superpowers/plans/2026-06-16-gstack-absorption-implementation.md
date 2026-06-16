# gstack Absorption Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement the approved gstack absorption addendum inside the existing six-skill methodology without adding top-level skills or opening a new branch.

**Architecture:** Keep the system Markdown-first. Encode the new methodology requirements in the existing root router and `/plan`, `/verify`, and `/reflect` skills; update reference docs and pressure scenarios; extend the Bash validator with focused content checks so the new contracts are mechanically guarded.

**Tech Stack:** Markdown skill docs, Bash validation script, pressure-scenario Markdown files.

---

### Task 1: Add RED Validator Checks

**Files:**
- Modify: `scripts/validate-skills.sh`

- [x] **Step 1: Add focused content checks for the gstack absorption contract**

Add helper checks that require:

- `skills/plan/SKILL.md` contains `Decision Brief`
- `skills/verify/SKILL.md` contains `Scope Drift Detection`, `Review Readiness Dashboard`, and `Adversarial Review`
- `skills/reflect/SKILL.md` contains `Durable Decision Log`
- `SKILL.md` routes release language to `/verify`
- pressure scenarios exist for decision brief, release stale evidence, adversarial review, durable decision log, and verification scope drift

- [x] **Step 2: Run validator and verify RED**

Run: `bash scripts/validate-skills.sh`

Expected: FAIL before the skill and scenario documents are updated, with the first missing gstack absorption requirement.

### Task 2: Update Core Skill Contracts

**Files:**
- Modify: `SKILL.md`
- Modify: `skills/plan/SKILL.md`
- Modify: `skills/verify/SKILL.md`
- Modify: `skills/reflect/SKILL.md`

- [x] **Step 1: Update root routing**

Add release request wording to the routing table so ship, deploy, PR, merge, publish, and release requests enter `/verify`, not a new `/ship` skill.

- [x] **Step 2: Add soft dependency guidance**

Add concise prose to the root pipeline or handoff guidance explaining that `/verify` benefits from `/plan`, `/reflect` benefits from `/verify`, and `/execute` benefits from `/investigate` when evidence-driven work is involved.

- [x] **Step 3: Update `/plan`**

Add a `Decision Brief` subsection and update workflow, hard rules, outputs, and rationalization prevention so Taste and User Challenge decisions include recommendation, alternatives, reversibility, and trade-offs.

- [x] **Step 4: Update `/verify`**

Add `Scope Drift Detection`, `Review Readiness Dashboard`, `Adversarial Review`, and release-gate behavior. Keep low-risk verification lightweight.

- [x] **Step 5: Update `/reflect`**

Add `Durable Decision Log` handling next to the Memory Promotion Gate so decisions and lessons are not mixed.

### Task 3: Update Docs And Pressure Scenarios

**Files:**
- Modify: `docs/references.md`
- Create: `tests/pressure-scenarios/decision-brief.md`
- Create: `tests/pressure-scenarios/release-stale-evidence.md`
- Create: `tests/pressure-scenarios/adversarial-review.md`
- Create: `tests/pressure-scenarios/durable-decision-log.md`
- Create: `tests/pressure-scenarios/verification-scope-drift.md`

- [x] **Step 1: Update references**

Record the refined gstack absorption: decision briefs, scope drift detection, review readiness dashboard, adversarial review, durable decision log, release gate inside `/verify`, and rejected heavy gstack mechanisms.

- [x] **Step 2: Add pressure scenarios**

Create small Markdown scenarios with the standard sections: Trigger, Expected route, Shortcut risk, Pass condition.

### Task 4: Verify

**Files:**
- Read: `docs/superpowers/specs/2026-06-16-gstack-absorption-design.md`
- Read: all modified files from Tasks 1-3

- [x] **Step 1: Run structural/content validation**

Run: `bash scripts/validate-skills.sh`

Expected: PASS.

- [x] **Step 2: Run markdown sanity checks**

Run: `rg -n -e 'TBD' -e 'TODO' -e 'FIXME' -e 'PLACEHOLDER' -e '\?\?' SKILL.md skills docs/references.md tests/pressure-scenarios`

Expected: no output.

- [x] **Step 3: Review diff scope**

Run: `git diff --stat`

Expected: changes are limited to the plan, root router, relevant skills, reference docs, validator, and pressure scenarios.
