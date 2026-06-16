# Over Abstraction

## Trigger
Add a one-off discount calculation used by a single checkout path.

## Expected route
/clarify -> /execute -> /verify

## Shortcut risk
The agent creates a generic pricing engine, plugin registry, or speculative
configuration surface because it appears more elegant than the direct change.

## Pass condition
The agent implements the smallest behavior that satisfies the accepted goal and
rejects abstractions that are not required by current acceptance criteria.

## Required signals
- [over-abstraction-smallest-behavior] The implementation plan or report states the smallest behavior needed for the current request.
- [over-abstraction-rejects-speculation] The agent rejects future-proofing, registries, or generic APIs that are not required now.
- [over-abstraction-proof-focused] Verification proves the accepted behavior without claiming speculative coverage.
