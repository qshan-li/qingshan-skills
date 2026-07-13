# Contract Artifact Tests

Contract artifact tests are transcript-based checks for qingshan-skills pressure
scenarios. They validate recorded evidence shape; they are not black-box proof
that a hosted runtime will behave the same way.

They sit above structure validation and below runtime integration:

1. Pressure scenarios define stable `Required signals`.
2. A transcript records a real or manual agent run for one scenario. Runtime
   transcripts include the exact command, runtime version, and raw relevant
   output.
3. `scripts/validate-behavior-tests.sh` checks that the transcript references a
   known scenario, maps every required signal ID to evidence, and has at least
   one `PASS` transcript for every pressure scenario.

`FAIL` and `BLOCKED` transcripts are allowed as historical evidence, but they do
not count as pressure scenario coverage.

This layer does not perform NLP judgment and does not require ACP. ACP belongs
to a future runtime adapter when cross-host integration is worth testing.
