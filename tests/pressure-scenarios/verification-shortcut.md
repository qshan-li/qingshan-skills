# Verification Shortcut

## Trigger
The code change looks correct and the agent is ready to say it is done.

## Expected route
/verify

## Shortcut risk
The agent says "done", "should pass", or "looks good" without fresh command output or task-specific proof.

## Pass condition
The agent identifies the proof required, runs or reports the verification command, reads the result, and only then states the actual status.

## Required signals
- [verification-shortcut-fresh-proof] `/verify` runs fresh proof or states why it cannot run.
- [verification-shortcut-evidence-based-status] Final status cites command output, artifact evidence, or a blocker.
