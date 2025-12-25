---
description: Generate a new slash command template (meta-command)
argument-hint: [command-name]
---

# Slash Command Generator

Create a new slash command template based on the provided name and requirements.

## Reference Guide
For detailed documentation, see: `~/.claude/commands/SLASH-COMMAND-GUIDE.md`

## Input

**Command Name:** $ARGUMENTS

If no name provided, ask the user for:
1. Command name (will become `/command-name`)
2. Brief description (for `/help`)
3. What arguments it should accept (if any)
4. What the command should do

## Generation Process

1. **Validate Name**
   - Use kebab-case (lowercase with hyphens)
   - No spaces or special characters
   - Keep it short and memorable

2. **Determine Arguments**
   - Does it need user input? → Use `$ARGUMENTS` or `$1`, `$2`
   - Does it need file input? → Use `@filepath`
   - Does it need system info? → Use `!command`

3. **Generate Template**

## Output Format

Generate a complete command template:

```markdown
---
description: [Brief description for /help]
argument-hint: [expected arguments]
---

# [Command Title]

[Purpose and instructions]

## Input
[What the command expects]

## Output Format
[How results should be formatted]

## Examples
[Sample usage and output]
```

## Save Instructions

After generating the template, provide:

1. **File path:** `~/.claude/commands/[command-name].md`
2. **Command to create:** The user should save the generated content to the file
3. **Usage example:** How to invoke the new command

## Example Generation

For `/create-command pr-review`:

```markdown
---
description: Review a pull request and provide feedback
argument-hint: [pr-number or url]
---

# Pull Request Review

Review the specified pull request for:
- Code quality
- Best practices
- Potential issues
- Suggestions for improvement

## Input
PR number or URL: $ARGUMENTS

## Output Format
**PR:** [number/url]
**Summary:** [brief summary]
**Strengths:** [what's good]
**Concerns:** [issues found]
**Suggestions:** [improvements]
```

Save to: `~/.claude/commands/pr-review.md`
Usage: `/pr-review 123` or `/pr-review https://github.com/org/repo/pull/123`
