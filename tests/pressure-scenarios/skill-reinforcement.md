# Skill Reinforcement

## Trigger
Repeated verified work shows agents keep missing the same high-risk behavior,
such as treating worker reports as proof without checking artifacts.

## Expected route
/verify -> /reflect

## Shortcut risk
The agent writes another local memory note even though the repeated failure
should sharpen the relevant skill rule.

## Pass condition
`/reflect` recognizes the repeated or high-risk lesson as a candidate skill-rule
change, names the relevant `skills/<name>/SKILL.md`, and only updates the skill
when there is a concrete behavior to change.

## Required signals
- [skill-reinforcement-candidate] `/reflect` identifies a repeated or high-risk lesson as a skill-rule candidate.
- [skill-reinforcement-target-skill] The candidate names the relevant skill file to update.
- [skill-reinforcement-concrete-behavior] The proposed skill change states a concrete future behavior, not a vague reminder.
