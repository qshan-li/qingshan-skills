#!/usr/bin/env bash
set -euo pipefail

fail() {
  echo "ERROR: $*" >&2
  exit 1
}

require_file() {
  local path="$1"
  [[ -f "$path" ]] || fail "missing required file: $path"
}

require_section() {
  local path="$1"
  local section="$2"
  grep -q "^## ${section}$" "$path" || fail "$path missing section: $section"
}

require_text() {
  local path="$1"
  local text="$2"
  grep -qF "$text" "$path" || fail "$path missing required text: $text"
}

section_bullet_count() {
  local path="$1"
  local section="$2"

  awk -v section="## ${section}" '
    $0 == section { in_section = 1; next }
    in_section && /^## / { exit }
    in_section && /^- / { count++ }
    END { print count + 0 }
  ' "$path"
}

section_bullets() {
  local path="$1"
  local section="$2"

  awk -v section="## ${section}" '
    $0 == section { in_section = 1; next }
    in_section && /^## / { exit }
    in_section && /^- / { print }
  ' "$path"
}

require_section_bullets() {
  local path="$1"
  local section="$2"
  local minimum="$3"
  local count

  count="$(section_bullet_count "$path" "$section")"
  [[ "$count" -ge "$minimum" ]] || fail "$path section ${section} needs at least ${minimum} bullet(s)"
}

validate_signal_ids() {
  local path="$1"
  local line

  while IFS= read -r line; do
    [[ "$line" =~ ^-\ \[[a-z0-9][a-z0-9-]*\]\ .+ ]] || fail "$path has invalid Required signals bullet: $line"
  done < <(section_bullets "$path" "Required signals")
}

description_line() {
  local path="$1"
  grep -m 1 '^description: ' "$path" || true
}

frontmatter_body() {
  local path="$1"
  awk '
    NR == 1 && $0 == "---" { in_frontmatter = 1; next }
    in_frontmatter && $0 == "---" { exit }
    in_frontmatter { print }
  ' "$path"
}

validate_frontmatter() {
  local path="$1"
  local description

  [[ "$(sed -n '1p' "$path")" == "---" ]] || fail "$path missing opening YAML frontmatter"
  grep -q '^name: [a-z0-9-]\+$' "$path" || fail "$path missing valid name field"

  description="$(description_line "$path")"
  [[ -n "$description" ]] || fail "$path missing description field"
  [[ "$description" == description:\ Use\ when* ]] || fail "$path description must start with: Use when"

  if grep -Eiq '^description: .*\b(step|workflow|first|then)\b' "$path"; then
    fail "$path description contains workflow shortcut language"
  fi

  if frontmatter_body "$path" | grep -Ev '^(name: [a-z0-9-]+|description: .*)$' | grep -q .; then
    fail "$path core skill frontmatter must only use portable name and description fields"
  fi
}

validate_skill() {
  local path="$1"
  validate_frontmatter "$path"

  require_section "$path" "Purpose"
  require_section "$path" "Direct Invocation"
  require_section "$path" "When to Use"
  require_section "$path" "When NOT to Use"
  require_section "$path" "Risk Gate"
  require_section "$path" "Workflow"
  require_section "$path" "Hard Rules"
  require_section "$path" "Rationalization Prevention"
  require_section "$path" "Outputs"
  require_section "$path" "Handoff"
}

validate_root_skill() {
  local path="$1"
  validate_frontmatter "$path"

  require_section "$path" "Purpose"
  require_section "$path" "Bootstrap Enforcement"
  require_section "$path" "Loop Contract"
  require_section "$path" "Workflow Continuation"
  require_section "$path" "Workflow Handoff Selection"
  require_section "$path" "Routing"
  require_section "$path" "Routing Tie-breakers"
  require_section "$path" "Risk Gate"
  require_section "$path" "Decision Grading"
  require_section "$path" "Workflow Loop Escape"
  require_section "$path" "Pipeline"
  require_section "$path" "Hard Rules"
  require_section "$path" "Rationalization Prevention"
}

validate_pressure_scenario() {
  local path="$1"
  require_file "$path"
  require_section "$path" "Trigger"
  require_section "$path" "Expected route"
  require_section "$path" "Shortcut risk"
  require_section "$path" "Pass condition"
  require_section "$path" "Required signals"
  require_section_bullets "$path" "Required signals" 2
  validate_signal_ids "$path"
}

validate_unique_signal_ids() {
  local duplicates

  duplicates="$(
    awk '
      /^## Required signals$/ { in_section = 1; next }
      in_section && /^## / { in_section = 0 }
      in_section && /^- \[[a-z0-9][a-z0-9-]*\] / {
        id = $0
        sub(/^- \[/, "", id)
        sub(/\].*/, "", id)
        print id
      }
    ' tests/pressure-scenarios/*.md | sort | uniq -d
  )"

  [[ -z "$duplicates" ]] || fail "duplicate Required signals id(s): ${duplicates}"
}

validate_json() {
  local path="$1"
  require_file "$path"
  jq empty "$path" 2>/dev/null || fail "$path: invalid JSON"
}

validate_plugin_manifest() {
  local path="$1"
  validate_json "$path"
  jq -e '.name' "$path" >/dev/null 2>&1 || fail "$path: missing 'name' field"
  jq -e '.description' "$path" >/dev/null 2>&1 || fail "$path: missing 'description' field"
  jq -e '.version' "$path" >/dev/null 2>&1 || fail "$path: missing 'version' field"
}

validate_root_adapter() {
  local path="$1"

  validate_frontmatter "$path"
  require_text "$path" '../../SKILL.md'
  require_text "$path" '../../ETHOS.md'
  require_text "$path" 'without duplicating its workflow semantics'
}

command -v jq >/dev/null 2>&1 || fail "jq is required for repository validation"

require_file "SKILL.md"
require_file "ETHOS.md"
require_file "CONTEXT.md"
require_file "README.md"
require_file "VERSION"
require_file ".claude-plugin/plugin.json"
require_file ".claude-plugin/marketplace.json"
require_file ".codex-plugin/plugin.json"
require_file ".cursor/rules/qingshan-skills.mdc"
require_file "docs/philosophy.md"
require_file "docs/installation.md"
require_file "docs/runtime-adapters.md"
require_file "docs/testing.md"
require_file "docs/templates/context-glossary.md"
require_file "docs/templates/decision-brief.md"
require_file "docs/templates/durable-decision.md"
require_file "docs/templates/fresh-context-packet.md"
require_file "docs/templates/release-checklist.md"
require_file "docs/templates/runtime-bootstrap.md"
require_file "docs/templates/behavior-transcript.md"
require_file "docs/templates/task-handoff.md"
require_file "prompts/fresh-worker.md"
require_file "prompts/spec-reviewer.md"
require_file "prompts/quality-reviewer.md"
require_file "prompts/adversarial-reviewer.md"
require_file "scripts/validate-behavior-tests.sh"
require_file "scripts/validate-runtime-smoke.sh"
require_file "scripts/validate-runtime-behavior.sh"
require_file "tests/plugin-layout.test.sh"
require_file "tests/runtime-adapters.test.sh"
require_file "tests/workflow-contracts.test.sh"
require_file "tests/behavior/README.md"
require_file "tests/runtime-smoke/README.md"
require_file "skills/qingshan-skills/SKILL.md"

validate_root_skill "SKILL.md"

validate_plugin_manifest ".claude-plugin/plugin.json"
validate_plugin_manifest ".claude-plugin/marketplace.json"
validate_plugin_manifest ".codex-plugin/plugin.json"
validate_root_adapter "skills/qingshan-skills/SKILL.md"

jq -e '.skills == "./skills/"' .codex-plugin/plugin.json >/dev/null 2>&1 ||
  fail ".codex-plugin/plugin.json: skills must be ./skills/"
for field in displayName shortDescription longDescription developerName category defaultPrompt; do
  jq -e --arg field "$field" '.interface[$field] != null' .codex-plugin/plugin.json >/dev/null 2>&1 ||
    fail ".codex-plugin/plugin.json: missing interface.${field}"
done
jq -e '.interface.defaultPrompts == null and .interface.websiteUrl == null' \
  .codex-plugin/plugin.json >/dev/null 2>&1 ||
  fail ".codex-plugin/plugin.json: unsupported interface field"

require_text ".cursor/rules/qingshan-skills.mdc" "alwaysApply: true"

# Validate VERSION format and consistency with plugin manifests
version="$(cat VERSION | tr -d '[:space:]')"
[[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || fail "VERSION must be semver (x.y.z), got: ${version}"

claude_version="$(jq -r '.version' .claude-plugin/plugin.json)"
codex_version="$(jq -r '.version' .codex-plugin/plugin.json)"
[[ "$version" == "$claude_version" ]] || fail "VERSION (${version}) != .claude-plugin/plugin.json version (${claude_version})"
[[ "$version" == "$codex_version" ]] || fail "VERSION (${version}) != .codex-plugin/plugin.json version (${codex_version})"

require_text "SKILL.md" "Ship, deploy, publish, PR, merge, release"
require_text "SKILL.md" "Code review, PR or diff review"
require_text "SKILL.md" "/verify"
require_text "SKILL.md" "## Memory Retrieval Gate"
require_text "SKILL.md" "## Risk Classification Floors"
require_text "SKILL.md" "lightweight target statement"
require_text "SKILL.md" "## Temporary State Lifecycle"
require_text "SKILL.md" "self-contained Reflection Handoff"
require_text "SKILL.md" "## Routing Tie-breakers"
require_text "SKILL.md" "## Workflow Loop Escape"
require_text "SKILL.md" "the same transition repeats three"
require_text "SKILL.md" "structured map and unknowns"
require_text "skills/clarify/SKILL.md" "## Unknowns Pass"
require_text "skills/clarify/SKILL.md" "## Acceptance Package Provenance"
require_text "skills/clarify/SKILL.md" "agent-proposed goal"
require_text "skills/clarify/SKILL.md" "## Project/Module Orientation"
require_text "skills/clarify/SKILL.md" "teaching graph"
require_text "skills/clarify/SKILL.md" "Separate facts from interpretation"
require_text "skills/clarify/SKILL.md" "goal-clarify or orientation"
require_text "skills/plan/SKILL.md" "## Direct Entry Preconditions"
require_text "skills/plan/SKILL.md" "Decision Brief"
require_text "skills/plan/SKILL.md" "## Decision-First Planning"
require_text "skills/plan/SKILL.md" "LEARNINGS.md"
require_text "skills/plan/SKILL.md" "reversal conditions"
require_text "skills/execute/SKILL.md" "Low risk: the task statement or lightweight target statement"
require_text "skills/execute/SKILL.md" "lightweight target, or context manifest"
require_text "skills/execute/SKILL.md" "## Context Gate Scoring"
require_text "skills/execute/SKILL.md" "## Unknown-Unknowns Probe"
require_text "skills/execute/SKILL.md" "## Deviation Log"
require_text "skills/execute/SKILL.md" "## Fresh Worker Recovery"
require_text "skills/execute/SKILL.md" "## Temporary State Handoff"
require_text "skills/execute/SKILL.md" "Temporary state: not used | pending for /verify | preserved active state"
require_text "skills/execute/SKILL.md" "NEEDS_CONTEXT"
require_text "skills/execute/SKILL.md" "BLOCKED"
require_text "skills/verify/SKILL.md" "## Reviewer Explainer and Check"
require_text "skills/verify/SKILL.md" "## Behavior Regression Proof"
require_text "skills/verify/SKILL.md" "does not author production code or tests"
require_text "skills/verify/SKILL.md" "## Pure Review Boundary"
require_text "docs/templates/task-handoff.md" "Goal"
require_text "skills/verify/SKILL.md" "release action status"
require_text "skills/clarify/SKILL.md" "Only a claim labeled \`repository-derived\`"
require_text "SKILL.md" "any open or approved User Challenge decision"
require_text "SKILL.md" "public contract change"
require_text ".cursor/rules/qingshan-skills.mdc" "QINGSHAN_SKILLS_ROOT"
require_text "docs/installation.md" "install-cursor-project-rule.sh"
require_text "skills/verify/SKILL.md" "Scope Drift Detection"
require_text "skills/verify/SKILL.md" "## Reflection Handoff"
require_text "skills/verify/SKILL.md" "## Temporary State Cleanup"
require_text "skills/verify/SKILL.md" 'Read the `/execute` temporary state status'
require_text "skills/verify/SKILL.md" "### Mandatory Core"
require_text "skills/verify/SKILL.md" "### Risk-triggered Blocks"
require_text "skills/verify/SKILL.md" "durable decisions, project learning"
require_text "skills/verify/SKILL.md" "Review Readiness Dashboard"
require_text "skills/verify/SKILL.md" "Adversarial Review"
require_text "skills/reflect/SKILL.md" "Durable Decision Log"
require_text "skills/reflect/SKILL.md" "## Consumption Contract"
require_text "skills/reflect/SKILL.md" "## Temporary State Boundary"
require_text "skills/reflect/SKILL.md" "## Promotion Decision Matrix"
require_text "skills/reflect/SKILL.md" "Temporary task state must already"
require_text "skills/reflect/SKILL.md" "invalidation condition"
require_text "skills/reflect/SKILL.md" 'trigger`, `lesson`, `scope`,'
require_text "skills/investigate/SKILL.md" "## Fix-Path Exit Criteria"
require_text "docs/templates/release-checklist.md" "release action status: not attempted | succeeded | failed | handed off"
require_text "docs/templates/task-handoff.md" "agent-proposed"
require_text "AGENTS.md" "Runtime behavior source of truth"
require_text "docs/runtime-adapters.md" "Runtime-specific fields, manifests, hooks, and UI metadata belong outside the"
require_text "docs/runtime-adapters.md" "## Automation Boundary"
require_text "docs/runtime-adapters.md" "## Bootstrap Wrapper"
require_text "docs/runtime-adapters.md" "Runtime automation protects workflow boundaries; it does not drive the whole"
require_text "docs/runtime-adapters.md" "## Memory Retrieval Boundary"
require_text "docs/testing.md" "## Layer 3: Contract Artifact Coverage"
require_text "docs/testing.md" "scripts/validate-runtime-smoke.sh"
require_text "docs/testing.md" "scripts/validate-runtime-behavior.sh"
require_text "docs/testing.md" "ACP is a transport and host-integration layer"
require_text "CONTEXT.md" "This file is a glossary only."
require_text "README.md" "docs/templates/"
require_text "skills/clarify/SKILL.md" "docs/templates/context-glossary.md"
require_text "skills/clarify/SKILL.md" "docs/templates/task-handoff.md"
require_text "skills/investigate/SKILL.md" "docs/templates/task-handoff.md"
require_text "skills/plan/SKILL.md" "docs/templates/decision-brief.md"
require_text "skills/plan/SKILL.md" "docs/templates/durable-decision.md"
require_text "skills/verify/SKILL.md" "docs/templates/release-checklist.md"
require_text "skills/verify/SKILL.md" "prompts/adversarial-reviewer.md"
require_text "skills/reflect/SKILL.md" "Promotion Artifact Map"
require_text "docs/templates/decision-brief.md" "## Approval"
require_text "docs/templates/fresh-context-packet.md" "## Stop Conditions"
require_text "docs/templates/release-checklist.md" "## Scope Review"
require_text "docs/templates/runtime-bootstrap.md" "## Adapter Must Not"
require_text "docs/templates/behavior-transcript.md" "## Signal evidence"
require_text "docs/templates/behavior-transcript.md" "## Command"
require_text "docs/templates/behavior-transcript.md" "## Runtime Version"
require_text "docs/templates/task-handoff.md" "## Investigation Evidence"
require_text "prompts/fresh-worker.md" "## Review Handoff"
require_text "prompts/spec-reviewer.md" "## Inputs Required"
require_text "prompts/quality-reviewer.md" "## Review Rules"
require_text "prompts/adversarial-reviewer.md" "## Review Focus"
require_text "tests/behavior/README.md" "scripts/validate-behavior-tests.sh"

for skill in clarify plan execute investigate verify reflect; do
  validate_skill "skills/${skill}/SKILL.md"
  require_text "skills/${skill}/SKILL.md" 'Direct invocation must still honor root `SKILL.md` and `ETHOS.md`.'
  require_text "skills/${skill}/SKILL.md" "Before continuing from direct invocation"
  require_text "skills/${skill}/SKILL.md" "### Always"
  require_text "skills/${skill}/SKILL.md" "### When Applicable"
  require_text "skills/${skill}/SKILL.md" 'Apply root `Workflow Continuation`'
  require_text "skills/${skill}/SKILL.md" 'Apply root `Workflow Handoff Selection` when returning control'
  require_text "skills/${skill}/SKILL.md" "Load the qingshan-skills runtime adapter"
done

require_text "skills/plan/SKILL.md" "docs/templates/task-handoff.md"
require_text "skills/execute/SKILL.md" "docs/templates/task-handoff.md"
require_text "skills/execute/SKILL.md" "docs/templates/fresh-context-packet.md"
require_text "skills/verify/SKILL.md" "prompts/spec-reviewer.md"
require_text "skills/verify/SKILL.md" "prompts/quality-reviewer.md"
require_text "docs/templates/decision-brief.md" "Mechanical decisions must not use this template"
require_text "docs/templates/durable-decision.md" "mark the old decision stale or superseded"
require_text "docs/templates/fresh-context-packet.md" "## Lifecycle"
require_text "docs/templates/release-checklist.md" "## Review Staleness"
require_text "docs/templates/release-checklist.md" "## Commit Or PR Hygiene"
require_text "docs/templates/task-handoff.md" "## Referenced Memory"
require_text "docs/templates/task-handoff.md" "## Lifecycle"
require_text "docs/templates/runtime-bootstrap.md" "global memory"
require_text "skills/qingshan-skills/SKILL.md" "## Runtime Handoff Interaction"
require_text "skills/qingshan-skills/SKILL.md" "AskUserQuestion"
require_text "skills/qingshan-skills/SKILL.md" "request_user_input"
require_text "skills/qingshan-skills/SKILL.md" "before writing any prose"

required_pressure_scenarios=(
  simple-task-overprocessing
  feature-ambiguity
  shared-language-persistence
  user-decision-theft
  bug-guesswork
  performance-guesswork
  context-rot
  verification-shortcut
  scope-creep
  methodology-bypass
  decision-brief
  plan-durable-decision-persistence
  clarify-plan-handoff-persistence
  investigation-handoff-persistence
  release-stale-evidence
  adversarial-review
  durable-decision-log
  reflect-promotion-artifact-map
  memory-pollution
  memory-consumption-contract
  wrong-generalization
  skill-reinforcement
  runtime-adapter-boundary
  verification-scope-drift
  context-manifest
  orphan-only-cleanup
  over-abstraction
  direct-execute-lightweight-target
  plan-direct-entry-preconditions
  code-review-routing
  runtime-smoke-boundary
  output-language-mirror
  state-lifecycle-cleanup
  fresh-worker-recovery
  workflow-loop-escape
  workflow-continuation
  workflow-handoff-options
  runtime-native-handoff-options
  loop-contract-scope
  unfamiliar-stack-unknowns
  project-module-orientation
  risk-classification-floors
  ac-provenance-gate
  behavior-regression-proof
  investigate-fix-path-exit
  release-action-status
)

for scenario in "${required_pressure_scenarios[@]}"; do
  require_file "tests/pressure-scenarios/${scenario}.md"
done

for scenario_path in tests/pressure-scenarios/*.md; do
  validate_pressure_scenario "$scenario_path"
done

validate_unique_signal_ids

bash scripts/validate-behavior-tests.sh >/dev/null
bash tests/plugin-layout.test.sh >/dev/null
bash tests/runtime-adapters.test.sh >/dev/null
bash tests/workflow-contracts.test.sh >/dev/null

echo "OK qingshan-skills validation passed"
