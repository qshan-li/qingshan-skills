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

section_value() {
  local path="$1"
  local section="$2"

  awk -v section="## ${section}" '
    $0 == section { in_section = 1; next }
    in_section && /^## / { exit }
    in_section && NF { print; exit }
  ' "$path"
}

pressure_signal_ids() {
  local path="$1"

  awk '
    /^## Required signals$/ { in_section = 1; next }
    in_section && /^## / { exit }
    in_section && /^- \[[a-z0-9][a-z0-9-]*\] / {
      id = $0
      sub(/^- \[/, "", id)
      sub(/\].*/, "", id)
      print id
    }
  ' "$path"
}

transcript_signal_ids() {
  local path="$1"

  awk '
    /^## Signal evidence$/ { in_section = 1; next }
    in_section && /^## / { exit }
    in_section && /^- \[[a-z0-9][a-z0-9-]*\] / {
      id = $0
      sub(/^- \[/, "", id)
      sub(/\].*/, "", id)
      print id
    }
  ' "$path"
}

contains_line() {
  local expected="$1"

  grep -qxF "$expected"
}

validate_transcript() {
  local path="$1"
  local scenario
  local scenario_path
  local verdict
  local id

  require_section "$path" "Scenario"
  require_section "$path" "Runner"
  require_section "$path" "Date"
  require_section "$path" "Transcript"
  require_section "$path" "Signal evidence"
  require_section "$path" "Forbidden evidence"
  require_section "$path" "Verdict"

  scenario="$(section_value "$path" "Scenario")"
  [[ "$scenario" =~ ^[a-z0-9][a-z0-9-]*$ ]] || fail "$path has invalid scenario: $scenario"

  scenario_path="tests/pressure-scenarios/${scenario}.md"
  require_file "$scenario_path"

  verdict="$(section_value "$path" "Verdict")"
  [[ "$verdict" =~ ^(PASS|FAIL|BLOCKED)$ ]] || fail "$path has invalid verdict: $verdict"

  while IFS= read -r id; do
    transcript_signal_ids "$path" | contains_line "$id" || fail "$path missing evidence for signal: $id"
  done < <(pressure_signal_ids "$scenario_path")

  while IFS= read -r id; do
    pressure_signal_ids "$scenario_path" | contains_line "$id" || fail "$path references unknown signal for ${scenario}: $id"
  done < <(transcript_signal_ids "$path")
}

require_file "docs/templates/behavior-transcript.md"
require_file "tests/behavior/README.md"

shopt -s nullglob
transcripts=(tests/behavior/transcripts/*.md)
[[ "${#transcripts[@]}" -gt 0 ]] || fail "missing behavior transcripts"

for transcript in "${transcripts[@]}"; do
  validate_transcript "$transcript"
done

echo "OK qingshan-skills behavior tests validation passed"
