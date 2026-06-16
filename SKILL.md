---
name: qingshan-skills
description: Use when coordinating software engineering work through qingshan-skills, routing tasks by risk, evidence, scope, and completion proof
---

# qingshan-skills

## Purpose

Route software engineering work through the smallest workflow that can still protect correctness, user decisions, and verification quality.

Read `ETHOS.md` before applying any core skill. Its non-negotiables override convenience.

## Routing

| Request shape | Entry skill | Reason |
| --- | --- | --- |
| New feature, product change, refactor, project structure work, deployment improvement, documentation workflow | `/clarify` | Goal, scope, constraints, and acceptance criteria must be explicit |
| Bug, failing test, performance issue, deployment failure, security or stability concern | `/investigate` | Evidence must exist before fixes |
| Clarified goal that needs decomposition, sequencing, rollback, or validation strategy | `/plan` | Hidden decisions and scope drift need control |
| Planned code, config, docs, or tooling change | `/execute` | Edits must stay scoped and context-safe |
| Any completion, fixed, passing, optimized, or ready claim | `/verify` | Claims require fresh proof |
| Completed work with reusable learning | `/reflect` | Durable lessons should update future behavior |

## Risk Gate

| Risk | Use |
| --- | --- |
| Low | Lightweight `/clarify -> /execute -> /verify` |
| Medium | `/clarify -> /plan -> /execute -> /verify` |
| High | Full relevant flow, with `/investigate` first when evidence is required |

Risk increases when work is cross-module, irreversible, user-facing, security-sensitive, deployment-related, performance-related, or poorly understood.

## Decision Grading

| Grade | Handling |
| --- | --- |
| Mechanical | Decide silently using project conventions |
| Taste | Batch and present with a recommendation |
| User Challenge | Stop and ask before proceeding |

Do not steal User Challenge decisions. Architecture direction, product behavior, irreversible data changes, and release risk belong to the user.

## Pipeline

```text
/clarify -> /plan -> /execute -> /verify -> /reflect
      \                         ^
       -> /investigate -> /plan |
```

TDD, review, and ship are embedded disciplines:

- TDD is the default for high-risk code changes inside `/execute`.
- Review is part of `/verify`.
- Ship happens only after `/verify` passes.

## Hard Rules

- Keep changes surgical.
- Prefer existing project patterns.
- Use TypeScript for new JS/TS code.
- Do not introduce `any`.
- Do not swallow errors or ignore promises.
- Do not claim completion without verification output.
- Do not use fresh context as a substitute for clear task boundaries.
