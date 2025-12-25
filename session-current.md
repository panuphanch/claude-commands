---
description: Show current session status
argument-hint: (none)
---

# Session Current

Show the status of the current active session.

## Configuration

- **Sessions Location:** `~/.claude/sessions/`
- **Current Time:** !`date "+%Y-%m-%d %H:%M"`

## Instructions

1. **Check for active session:**
   - Read `~/.claude/sessions/.current-session` for active session filename
   - If empty or file doesn't exist, inform user no session is active

2. **If no active session:**
   ```
   No active session.

   Start a new session with: /session-start [name]
   List past sessions with: /session-list
   ```

3. **If session exists, display status:**
   ```markdown
   ## Current Session: [session-name]

   **File:** [filename]
   **Started:** [start time from file]
   **Duration:** [calculated from start to now]

   ### Goals
   - [list goals from session file]

   ### Recent Updates
   - [last 2-3 updates with timestamps]

   ### Quick Actions
   - Update progress: `/session-update [notes]`
   - End session: `/session-end`
   ```

## Behavior

- Keep output concise and informative
- Show recent updates to remind of current progress
- Include available commands for easy reference
- Calculate duration from session start to current time
