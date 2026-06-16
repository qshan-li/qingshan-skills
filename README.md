# qingshan-skills

qingshan-skills is a compact software engineering methodology for AI coding agents. It distills patterns from gstack, Superpowers, GSD, and Grill Me into a six-skill system built around surgical changes, risk-scaled process, TypeScript discipline, fresh context, and verification before claims.

## Skills

| Skill | Purpose |
| --- | --- |
| `/clarify` | Establish shared understanding before planning or execution |
| `/plan` | Decompose work and protect user decisions |
| `/execute` | Make scoped changes with context and TDD discipline |
| `/investigate` | Diagnose failures with evidence before fixes |
| `/verify` | Prove work before completion claims |
| `/reflect` | Capture durable learning without knowledge-base noise |

## Default Flow

```text
/clarify -> /plan -> /execute -> /verify -> /reflect
      \                         ^
       -> /investigate -> /plan |
```

Use the root `SKILL.md` as the routing entry point and `ETHOS.md` as the shared constraint layer.

## Validate

```bash
bash scripts/validate-skills.sh
```

Expected output:

```text
OK qingshan-skills validation passed
```
