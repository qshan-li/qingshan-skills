# Runtime Smoke Tests

Runtime smoke tests check whether a real host can load the root router and
workflow skills. They are adapter-level checks, not canonical methodology
validation.

The current smoke wrapper uses Codex CLI in read-only, ephemeral mode. Each
prompt must return exactly one non-empty `ROUTE:` line; the script checks that
route line for the expected workflow skills across four scenarios:

- `simple-docs-route`: a clear small README typo routes through `/execute` and
  `/verify`
- `ambiguous-clarify-route`: an underspecified improvement request routes
  through `/clarify`
- `bug-investigate-route`: an unexplained login failure routes through
  `/investigate` before any fix
- `review-verify-route`: a diff review request routes through `/verify` without
  implementation claims

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
