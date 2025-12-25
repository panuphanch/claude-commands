# Slash Command Creation Guide

Comprehensive guide for creating custom Claude Code slash commands.

---

## Quick Start

1. Create a markdown file in `~/.claude/commands/` (personal) or `.claude/commands/` (project)
2. Add YAML frontmatter with `description`
3. Write your prompt content
4. Use as `/filename` (without `.md`)

---

## File Structure

### Location
| Location | Scope | Label in /help |
|----------|-------|----------------|
| `~/.claude/commands/` | Personal (all projects) | (user) |
| `.claude/commands/` | Project (team-shared) | (project) |

### Naming Convention
- File: `command-name.md`
- Usage: `/command-name`
- Example: `jira-bug.md` → `/jira-bug`

---

## YAML Frontmatter

Required metadata at the top of the file:

```yaml
---
description: Brief description shown in /help
argument-hint: [arg1] [arg2]  # Optional
---
```

### Fields

| Field | Required | Description |
|-------|----------|-------------|
| `description` | Yes | Brief description shown when user types `/help` |
| `argument-hint` | No | Placeholder showing expected arguments |

---

## Special Variables

### Arguments

| Variable | Description | Example |
|----------|-------------|---------|
| `$ARGUMENTS` | All arguments as single string | `/cmd foo bar` → `"foo bar"` |
| `$1` | First positional argument | `/cmd foo bar` → `"foo"` |
| `$2` | Second positional argument | `/cmd foo bar` → `"bar"` |
| `$3`, `$4`... | Additional positional arguments | Continue pattern |

### File References

| Syntax | Description |
|--------|-------------|
| `@filepath` | Include file content in prompt |
| `@src/main.ts` | Reference specific file |

### Bash Command Execution

| Syntax | Description |
|--------|-------------|
| `!command` | Execute bash command and include output |
| `!date +%Y-%m-%d` | Get current date |
| `!git branch --show-current` | Get current git branch |

---

## Best Practices

### 1. Keep Commands Focused
- One command = one purpose
- Don't try to do everything in one command
- Create separate commands for related but distinct tasks

### 2. Write Clear Descriptions
- Description should explain what AND when to use
- Keep it concise but informative
- Include key trigger words

### 3. Document Output Format
- Specify expected output structure
- Use code blocks for templates
- Include examples

### 4. Use Context Wisely
- Commands can access conversation context
- Mention what context will be used
- Provide fallback for missing context

### 5. Provide Examples
- Show sample usage
- Include sample output
- Cover common scenarios

---

## Template Examples

### Simple Prompt Command

```markdown
---
description: Analyze code for performance issues
---

Analyze the provided code for:
1. Time complexity issues
2. Memory optimization opportunities
3. Algorithmic improvements

Provide specific, actionable recommendations.
```

### Command with Arguments

```markdown
---
description: Create a new component with the given name
argument-hint: [component-name] [type]
---

Create a new $1 component of type $2.

If no type specified, default to functional component.
```

### Command with File References

```markdown
---
description: Review the specified file for best practices
argument-hint: [filepath]
---

Review the file at @$1 for:
- Code quality
- Best practices
- Potential improvements
```

### Command with Bash Integration

```markdown
---
description: Generate commit message based on staged changes
---

Current branch: !`git branch --show-current`
Staged changes: !`git diff --cached --stat`

Generate a conventional commit message based on the staged changes.
```

### Command with Context Analysis

```markdown
---
description: Generate bug ticket from conversation context
argument-hint: [brief-description]
---

# Bug Ticket Generator

Analyze the current conversation for:
- Error messages
- Reproduction steps
- Expected vs actual behavior

If $ARGUMENTS is provided, use it as the bug summary.
Otherwise, derive from conversation context.

## Output Format
**Summary:** [Title]
**Description:** [Details]
**Steps to Reproduce:** [Steps]
```

---

## Existing Commands Reference

| Command | File | Purpose |
|---------|------|---------|
| `/jira-bug` | `jira-bug.md` | Generate Jira bug ticket |
| `/daily-note` | `daily-note.md` | Update daily notes |
| `/create-command` | `create-command.md` | Generate new command template |

---

## Debugging

### Command Not Appearing
1. Check file location (`~/.claude/commands/` or `.claude/commands/`)
2. Verify YAML frontmatter syntax (no tabs, proper indentation)
3. Ensure file has `.md` extension
4. Restart Claude Code session

### Command Not Working as Expected
1. Test with simple input first
2. Check variable substitution (`$ARGUMENTS`, `$1`, etc.)
3. Verify bash commands work standalone
4. Check file references exist

### View Available Commands
```bash
ls ~/.claude/commands/
claude /help
```
