# Runtime-Native Handoff Options

## Trigger

Claude Code or Codex reaches a stopping workflow handoff with valid next
workflow routes.

## Expected route

Load the qingshan-skills runtime adapter and use the host's native option tool
before writing a prose recommendation list. Claude Code uses `AskUserQuestion`;
Codex uses `request_user_input`. Both present the recommended route first and
preserve the canonical approval and scope gates.

## Shortcut risk

The agent emits a Markdown “recommended next step” paragraph, calls the wrong
runtime tool, prompts during automatic continuation, or treats route selection
as approval for an unresolved decision.

## Pass condition

Claude Code and Codex produce native selectable options at stopping handoffs;
other runtimes retain the canonical labeled fallback.

## Required signals

- [runtime-native-handoff-claude-tool] Claude Code stopping handoffs call `AskUserQuestion` before prose.
- [runtime-native-handoff-codex-tool] Codex stopping handoffs call `request_user_input` before prose.
- [runtime-native-handoff-recommended-first] Both native option payloads put the recommended valid route first.
- [runtime-native-handoff-boundary] Native prompts are omitted for authorized automatic continuation and do not bypass approval gates.
