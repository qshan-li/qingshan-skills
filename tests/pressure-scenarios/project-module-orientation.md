# Project Module Orientation

## Trigger
`/clarify` asks to read a project module or multi-file directory and return a
structured map plus uncertainties.

## Expected route
/clarify

## Shortcut risk
The agent either dumps a directory summary, invents a new command, scans the
whole repository without scope, or presents inferred business meaning as fact.

## Pass condition
The agent keeps the request inside `/clarify`, bounds the scope, reads targeted
evidence, separates facts from interpretation, returns a teaching-graph style
map with nodes, edges, layers, domain flow, guided tour, operational
uncertainties, and next route, and does not create persistent graph or dashboard
artifacts.

## Required signals
- [project-module-orientation-clarify-route] The request stays in `/clarify` and does not introduce a new top-level command.
- [project-module-orientation-scope-evidence] The agent states included/excluded scope and targeted evidence read.
- [project-module-orientation-facts-inferences] The output separates evidence-backed facts from inferences.
- [project-module-orientation-teaching-graph] The output includes nodes, edges, layers, and guided reading order.
- [project-module-orientation-domain-view] The output includes domain flow, steps, invariants, or explains why no domain behavior was found.
- [project-module-orientation-unknowns-next-route] The output separates evidence, open facts, open decisions, blind-spot hypotheses, residual uncertainty, discovery probes, and next route.
- [project-module-orientation-no-persistent-graph] The agent does not create persistent graph files, dashboards, or multi-agent scans by default.
