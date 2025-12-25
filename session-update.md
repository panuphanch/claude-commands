---
description: Add timestamped progress update to current session
argument-hint: [notes]
---

# Session Update

Add a timestamped progress update to the current active session.

## Configuration

- **Sessions Location:** `~/.claude/sessions/`
- **Current Time:** !`date "+%Y-%m-%d %H:%M"`

## Instructions

1. **Check for active session:**
   - Read `~/.claude/sessions/.current-session` to find active session filename
   - If no active session, inform user to start one with `/session-start`

2. **Gather update information:**
   - User notes: `$ARGUMENTS` (or auto-summarize recent activities if empty)
   - Git status: `git status --porcelain`
   - Current branch: `git branch --show-current`
   - Todo progress: Check TodoRead for task status

3. **Append update to session file:**
   ```markdown
   ### Update - [timestamp]

   **Summary:** [user notes or auto-summary]

   **Git Changes:**
   - Modified: [list of modified files]
   - Added: [list of new files]
   - Deleted: [list of deleted files]
   - Branch: [current branch]

   **Todo Progress:** [X completed, Y in progress, Z pending]
   - Completed: [list recently completed]

   **Details:**
   [Additional context from conversation]
   ```

4. **Confirm update added**

## Example

```bash
/session-update Fixed OAuth token refresh issue
# Adds timestamped update with the provided note

/session-update
# Auto-generates summary from recent conversation activity
```

## Behavior

- If `$ARGUMENTS` provided, use as the update summary
- If no arguments, analyze recent conversation for key activities
- Always capture git status and todo progress
- Keep updates concise but comprehensive for future reference
- Include code snippets for significant changes
