# Runtime Smoke Tests

Runtime smoke tests check whether a real host can load the root router and
workflow skills. They are adapter-level checks, not canonical methodology
validation.

Run them only when host credentials, model cost, and runtime availability are
acceptable:

```bash
QINGSHAN_RUNTIME_SMOKE=1 bash scripts/validate-runtime-smoke.sh
```

Without `QINGSHAN_RUNTIME_SMOKE=1`, the script reports `SKIP` and exits
successfully. Keep runtime smoke separate from `scripts/validate-skills.sh` so
structure validation remains deterministic.
