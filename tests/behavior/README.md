# Behavior Tests

Behavior tests are transcript-based checks for qingshan-skills pressure
scenarios.

They sit above structure validation and below runtime integration:

1. Pressure scenarios define stable `Required signals`.
2. A transcript records a real or manual agent run for one scenario.
3. `scripts/validate-behavior-tests.sh` checks that the transcript references a
   known scenario, maps every required signal ID to evidence, and covers the
   critical workflow scenarios named by the validator.

This layer does not perform NLP judgment and does not require ACP. ACP belongs
to a future runtime adapter when cross-host integration is worth testing.
