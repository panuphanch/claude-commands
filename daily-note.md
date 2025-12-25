---
description: Update daily notes from conversation context (auto-detects today's date)
argument-hint: [optional note or topic]
---

# Daily Notes Updater

Update the daily notes file with information from the current conversation.

## Configuration

- **Notes Location:** `/mnt/c/Ideaverse/Calendar/Notes/`
- **File Format:** `YYYY-MM-DD.md`
- **Current Date:** !`date +%Y-%m-%d`

## Instructions

1. **Identify today's file:** `/mnt/c/Ideaverse/Calendar/Notes/!`date +%Y-%m-%d`.md`

2. **Read current content:** Check existing notes structure and content

3. **Analyze context:** From the conversation, identify:
   - Completed tasks (mark with ✅)
   - New findings or discoveries
   - Bugs found or issues encountered
   - Decisions made
   - Next steps or follow-ups

4. **Generate update:** Based on the conversation context, suggest updates to add to the daily note

## Output Format

Provide the update in a format that matches the existing note structure:

```markdown
## Updates from [Topic/Context]

### Completed
- [Task] ✅

### Findings
- [Key discovery or result]

### Issues/Bugs
- [Any problems encountered]

### Next Steps
- [Follow-up items]
```

## Additional Context Sources

When generating updates, also check for today's session logs:
- **Session Location:** `~/.claude/sessions/`
- **Pattern:** Files starting with today's date (`YYYY-MM-DD-*.md`)
- If session logs exist for today, include relevant progress from those sessions
- Session logs may not always be available - use conversation context as primary source

## Behavior

- If `$ARGUMENTS` is provided, focus the update on that specific topic
- If no arguments, analyze the full conversation for relevant updates
- Check for today's session logs and incorporate relevant progress
- Preserve the existing note format (YAML frontmatter, indentation style)
- Use ✅ to mark completed items
- Keep updates concise and actionable

## Example

For an IronOCR testing session, the update might look like:

```markdown
- RC Testing
	- Testing IronOcr ✅
		- SaveAsSearchablePdf for ReadPhoto/ReadScreenShot/ReadDocumentAdvanced - Working
		- Deskew bug fix - Verified
		- Found issue: Scale() and EnhanceResolution() filters break SaveAsSearchablePdf
		- Created Jira ticket for resize filter bug
```
