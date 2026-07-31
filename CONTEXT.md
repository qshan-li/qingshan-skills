# qingshan-skills Glossary

This file is a glossary only. It records stable terms and resolved ambiguities
for this repository. It is not a spec, plan, scratch pad, or decision log.

## Mechanical Decision

A reversible implementation choice the agent may make using existing project
conventions without interrupting the user.

## Taste Decision

A meaningful but reversible choice where the agent should batch options and give
a recommendation before proceeding when the choice affects user-facing behavior,
documentation shape, or workflow ergonomics.

## User Challenge Decision

A high-impact product, architecture, release, data, or irreversible decision
that the agent must not decide silently.

## Pressure Scenario

A test fixture describing a situation where an agent would naturally take the
wrong shortcut. Each scenario records the trigger, expected route, shortcut
risk, pass condition, and required behavior signals.

## Fresh Context

A narrow execution or review context used when the current session may degrade
accuracy. Fresh context receives scoped task inputs, owned files, protected
files, and verification requirements, not an unbounded memory dump.

## Runtime Adapter

A runtime-specific wrapper, manifest, hook, prompt, or install surface that makes
the canonical skills usable in a host such as Claude Code, Codex, or Cursor
without changing the meaning of the root router or six workflow skills.

## Uncertainty Pass

An operational clarification pass that separates evidence, open facts, open
decisions, blind-spot hypotheses, and residual uncertainty by how each item can
be resolved, who must decide it, and whether it blocks later work.

## Open Fact

An objective answer that exists but has not yet been found. Resolve it from
repository or external evidence with the smallest applicable read-only probe.

## Open Decision

An answer that does not exist until its decision owner chooses. It is handled by
the applicable Mechanical, Taste, or User Challenge decision rule, not disguised
as a fact-finding probe.

## Blind-spot Hypothesis

A grounded suspicion that a named risk surface may contain an unobserved
constraint. It must name why that surface is plausible and the smallest probe
that could expose it; generic possibility lists do not qualify.

## Residual Uncertainty

An uncertainty that proportionate discovery cannot eliminate. It carries its
impact, mitigation, and required proof forward and cannot replace a blocking
goal, acceptance-criteria, boundary, or user decision.

## Implementation Constraint Probe

The read-only pre-edit check in `/execute` that resolves only unresolved or stale
local implementation constraints and reuses applicable fresh upstream evidence.

## Durable Decision

A settled architecture, scope, tool, vendor, release, or reversal choice that
future sessions should not silently re-litigate. Durable decisions are recorded
separately from reusable lessons.

## Document Language

The natural language the skill *source files* (`SKILL.md`, `ETHOS.md`, prompts)
are authored in. For qingshan-skills this is English, fixed by convention for
portability across the English source systems. Distinct from output language:
document language governs source files, not replies.

## Output Language

The natural language the agent *replies to the user in* while running a skill.
Output language follows the user's current conversation language, unless the
user explicitly requests another language. It is independent of document
language: English source documents must not pull replies toward English when the
user is conversing in another language.
