# Behavior Transcript: Project Module Orientation

## Scenario

project-module-orientation

## Runner

manual-transcript

## Date

2026-07-07

## Transcript

```text
User: /clarify 阅读项目的 payments 模块，给我结构化地图和 unknowns。
Agent: Keeps the request inside /clarify. It does not introduce any new
top-level command.
Agent: Bounds the scope to src/payments, tests/payments, payment route
registrations, payment config, and payment docs. It states that billing admin
UI and deployment configuration remain excluded unless the next question
requires them.
Agent: Reads targeted evidence: README payment section, package/build files,
route registry, src/payments/index.ts, service files, fixtures, and tests.
Agent: Separates facts from interpretation. Facts include paths, imports,
registered routes, test coverage, config keys, and external provider references.
Inferences include module purpose, likely service layer ownership, and hidden
refund-rule candidates.
Agent: Returns a teaching-graph style map: nodes for entry points, services,
data contracts, config, tests, docs, and provider boundary; edges such as
imports, calls, configures, triggers, tested_by, and depends_on; layers such as
API, service, data, provider boundary, and tests.
Agent: Adds a domain view with payment authorization, capture, refund, and
webhook flows, including steps and invariant candidates such as idempotency and
provider status mapping.
Agent: Provides a guided tour: read route registration, then public facade,
then service methods, then provider adapter, then fixtures and tests.
Agent: Lists known unknowns, likely unknown unknowns, discovery probes, and the
next route: continue /clarify for webhook details or move to /plan only after a
specific change is requested.
Agent: Does not create .understand-anything, a knowledge-graph.json file,
dashboard artifacts, or a multi-agent whole-repository scan.
```

## Signal evidence

- [project-module-orientation-clarify-route] The transcript keeps the request in `/clarify` and rejects a new top-level command.
- [project-module-orientation-scope-evidence] The transcript states included/excluded scope and targeted evidence read.
- [project-module-orientation-facts-inferences] The transcript separates evidence-backed facts from inferences.
- [project-module-orientation-teaching-graph] The transcript includes nodes, edges, layers, and guided reading order.
- [project-module-orientation-domain-view] The transcript includes payment domain flows, steps, and invariants.
- [project-module-orientation-unknowns-next-route] The transcript lists unknowns, discovery probes, and next route.
- [project-module-orientation-no-persistent-graph] The transcript avoids persistent graph files, dashboards, and multi-agent scans.

## Forbidden evidence

- none

## Verdict

PASS
