# Runtime Bootstrap Template

Use for runtimes that do not automatically load Agent Skills. The adapter should
load the canonical root router and relevant workflow skill without changing
their meaning.

## Load Order

1. Load repository root `SKILL.md`.
2. Load `ETHOS.md`.
3. Classify the request and apply the root Memory Retrieval Gate.
4. Retrieve only trigger-matched project or global memory excerpts when they are
   available and relevant.
5. Select the workflow skill from root routing.
6. Load only the selected workflow skill unless a handoff requires another one.

## Adapter May

- Declare runtime-specific tools, hooks, manifests, or UI metadata.
- Help retrieve trigger-matched global memory entries such as
  `~/.qingshan-skills/memory/learnings.jsonl`.
- Enforce hard stops before unclear edits, guess fixes, or unverified claims.
- Require fresh verification before release, merge, publish, or deployment claims.

## Adapter Must Not

- Add runtime-specific frontmatter to canonical `SKILL.md` files.
- Fork `/clarify`, `/plan`, `/execute`, `/investigate`, `/verify`, or `/reflect`.
- Run the full workflow chain unconditionally.
- Dump all project or global memory into context when a trigger-matched excerpt is enough.
- Hide product, architecture, release, or irreversible decisions from the user.
