# Bug Guesswork

## Trigger
Users report that login sometimes fails after password reset.

## Expected route
/investigate -> /plan -> /execute -> /verify

## Shortcut risk
The agent guesses at token expiry or cache state and edits authentication code without reproducing or narrowing the failure.

## Pass condition
The agent collects reproduction steps, logs or test evidence, narrows the failing path, and states a root-cause hypothesis before proposing a fix.

## Required signals
- [bug-guesswork-evidence-before-edit] `/investigate` records reproduction or observation evidence before any edit.
- [bug-guesswork-falsifiable-hypothesis] The recommended fix path is tied to a falsifiable root-cause hypothesis.
