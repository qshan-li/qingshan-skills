# Output Language Mirror

## Trigger
A user conversing in a non-English language invokes a skill such as `/clarify`
for a task. Every skill source document is authored in English.

## Expected route
root `SKILL.md` Bootstrap (applies before any routed skill responds)

## Shortcut risk
The agent reads the English skill document and lets the document language pull
its reply toward English, ignoring the language the user is actually using.

## Pass condition
The agent replies in the user's current conversation language, switches only
when the user explicitly requests another language, and leaves the English skill
documents unchanged.

## Required signals
- [output-language-mirror-user-language] The agent replies in the user's current conversation language, not the skill document language.
- [output-language-explicit-override] The agent changes output language only when the user explicitly requests another language.
- [output-language-doc-english-preserved] The English skill documents stay unchanged; the rule governs output, not source.
