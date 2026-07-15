---
name: qingshan-skills
description: Use when coordinating software engineering work through qingshan-skills, routing tasks by risk, evidence, scope, and completion proof
---

# qingshan-skills plugin adapter

This adapter exposes the canonical repository router to plugin runtimes without duplicating its workflow semantics.

Before responding to or acting on a software engineering request:

1. Read `../../SKILL.md` completely.
2. Read `../../ETHOS.md` completely.
3. Apply the canonical root router, then load only the selected workflow skill.

Do not treat this adapter as a substitute for the canonical files. If either
referenced file is unavailable, stop and report that the plugin package is
incomplete.

## Runtime Handoff Interaction

This section is runtime-specific adapter behavior. It does not change the
canonical routing, approval, risk, or continuation semantics.

When a stopping handoff has valid next workflows, use the host's native option
channel before writing any prose:

- Claude Code: call `AskUserQuestion` with one question and two to four options.
  Put the recommended valid route first; use action labels rather than
  `/skill-name` commands.
- Codex: call the native `request_user_input` action with one question and the
  same route options, again putting the recommendation first.
- Other runtimes: use the canonical labeled fallback when no native option
  action is available.

Do not call either native option action for an authorized automatic handoff.
Do not offer blocked routes, and do not treat selecting a route as approval for
an open Taste or User Challenge decision. If a native action is unavailable or
fails before the user can answer, use the canonical fallback rather than
emitting only a recommendation paragraph.
