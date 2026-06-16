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
  require_section "$path" "Routing"
  require_section "$path" "Risk Gate"
  require_section "$path" "Decision Grading"
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

require_file "SKILL.md"
require_file "ETHOS.md"
require_file "CONTEXT.md"
require_file "README.md"
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
require_file "prompts/fresh-worker.md"
require_file "prompts/spec-reviewer.md"
require_file "prompts/quality-reviewer.md"
require_file "scripts/validate-behavior-tests.sh"
require_file "tests/behavior/README.md"

validate_root_skill "SKILL.md"

require_text "SKILL.md" "Ship, deploy, publish, PR, merge, release"
require_text "SKILL.md" "/verify"
require_text "skills/plan/SKILL.md" "Decision Brief"
require_text "skills/verify/SKILL.md" "Scope Drift Detection"
require_text "skills/verify/SKILL.md" "Review Readiness Dashboard"
require_text "skills/verify/SKILL.md" "Adversarial Review"
require_text "skills/reflect/SKILL.md" "Durable Decision Log"
require_text "docs/runtime-adapters.md" "Runtime-specific fields, manifests, hooks, and UI metadata belong outside the"
require_text "docs/runtime-adapters.md" "## Automation Boundary"
require_text "docs/runtime-adapters.md" "## Bootstrap Wrapper"
require_text "docs/runtime-adapters.md" "Runtime automation protects workflow boundaries; it does not drive the whole"
require_text "docs/testing.md" "## Layer 3: Transcript Behavior Tests"
require_text "docs/testing.md" "ACP is a transport and host-integration layer"
require_text "CONTEXT.md" "This file is a glossary only."
require_text "README.md" "docs/templates/"
require_text "docs/templates/decision-brief.md" "## Approval"
require_text "docs/templates/fresh-context-packet.md" "## Stop Conditions"
require_text "docs/templates/release-checklist.md" "## Scope Review"
require_text "docs/templates/runtime-bootstrap.md" "## Adapter Must Not"
require_text "docs/templates/behavior-transcript.md" "## Signal evidence"
require_text "prompts/fresh-worker.md" "## Review Handoff"
require_text "prompts/spec-reviewer.md" "## Inputs Required"
require_text "prompts/quality-reviewer.md" "## Review Rules"
require_text "tests/behavior/README.md" "scripts/validate-behavior-tests.sh"

for skill in clarify plan execute investigate verify reflect; do
  validate_skill "skills/${skill}/SKILL.md"
done

for scenario in \
  simple-task-overprocessing \
  feature-ambiguity \
  user-decision-theft \
  bug-guesswork \
  performance-guesswork \
  context-rot \
  verification-shortcut \
  scope-creep \
  methodology-bypass \
  decision-brief \
  release-stale-evidence \
  adversarial-review \
  durable-decision-log \
  runtime-adapter-boundary \
  verification-scope-drift; do
  validate_pressure_scenario "tests/pressure-scenarios/${scenario}.md"
done

validate_unique_signal_ids

bash scripts/validate-behavior-tests.sh >/dev/null

echo "OK qingshan-skills validation passed"
