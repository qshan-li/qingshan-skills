# Runtime Smoke Tests

Runtime smoke tests check whether a real host can load the root router and
workflow skills. They are adapter-level checks, not canonical methodology
validation.

The current smoke wrapper uses Codex CLI in read-only, ephemeral mode. Each
prompt must return exactly one non-empty `ROUTE:` line; the script checks that
route line for the expected workflow skills across ten scenarios:

- `new-feature-clarify-route`: new feature work routes through `/clarify`
- `bug-investigate-route`: an unexplained login failure routes through
  `/investigate` before any fix
- `planned-work-plan-route`: clarified work needing sequencing, rollback, and
  validation strategy routes through `/plan`
- `dependency-upgrade-plan-route`: a TypeScript toolchain upgrade routes through
  `/plan`
- `test-system-investigate-route`: unclear flaky CI test improvement routes
  through `/investigate`
- `planned-docs-execute-route`: a clear small README typo routes through
  `/execute` and `/verify`
- `review-verify-route`: a diff review request routes through `/verify` without
  implementation claims
- `completion-claim-verify-route`: a completion claim routes through `/verify`
- `release-verify-route`: a release request routes through `/verify`
- `learning-reflect-route`: reusable learning routes through `/reflect`

Run them only when host credentials, model cost, and runtime availability are
acceptable:

```bash
QINGSHAN_RUNTIME_SMOKE=1 bash scripts/validate-runtime-smoke.sh
```

Without `QINGSHAN_RUNTIME_SMOKE=1`, the script reports `SKIP` and exits
successfully. Keep runtime smoke separate from `scripts/validate-skills.sh` so
structure validation remains deterministic.

ACP is intentionally not part of this smoke layer. Add an ACP runner only when a
real cross-runtime adapter needs black-box coverage across hosts.
