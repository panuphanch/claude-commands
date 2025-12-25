---
description: Start a new development session with progress tracking
argument-hint: [session-name]
---

# Session Start

Start a new development session by creating a session file.

## Configuration

- **Sessions Location:** `~/.claude/sessions/`
- **File Format:** `YYYY-MM-DD-HHMM-name.md` (or `YYYY-MM-DD-HHMM.md` if no name)
- **Current Date/Time:** !`date +%Y-%m-%d-%H%M`

## Instructions

1. **Create session file:** `~/.claude/sessions/!`date +%Y-%m-%d-%H%M`-$ARGUMENTS.md`
   - If no name provided, use just the timestamp

2. **Initialize session structure:**
   ```markdown
   # Development Session - [timestamp] - [name]

   ## Overview
   - **Started:** [timestamp]
   - **Project:** [auto-detect from current directory]

   ## Goals
   - [ ] [Ask user for goals if not clear from context]

   ## Progress
   [Updates will be added here]
   ```

3. **Track active session:** Create/update `~/.claude/sessions/.current-session` with the session filename

4. **Confirm to user:**
   - Session file created
   - Remind about `/session-update` and `/session-end`

## Example

```bash
/session-start authentication-refactor
# Creates: ~/.claude/sessions/2025-12-25-1430-authentication-refactor.md

/session-start
# Creates: ~/.claude/sessions/2025-12-25-1430.md
```

## Behavior

- If `$ARGUMENTS` provided, use as session name (kebab-case recommended)
- If no arguments, create timestamp-only session
- Always ask for goals if not clear from conversation context
- Auto-detect project name from current working directory
