---
description: Show current session status
argument-hint: (none)
---

# Session Current

Show the status of the current active session for this project.

## Project Detection

Detect project name by running these commands (in order, use first successful result):
1. Git repository root: `basename "$(git rev-parse --show-toplevel 2>/dev/null)"`
2. Fallback to current directory: `basename "$PWD"`

Sanitize project name: lowercase, replace spaces with dashes.

## Configuration

- **Project Sessions Directory:** `~/.claude/sessions/{project}/`
- **Current Time:** !`date "+%Y-%m-%d %H:%M"`

## Instructions

1. **Detect project name** from git repo or directory name

2. **Check for active session:**
   - Read `~/.claude/sessions/{project}/.current-session` for active session filename
   - If empty or file doesn't exist, inform user no session is active for this project

3. **If no active session:**
   ```
   No active session for project: {project}

   Start a new session with: /session-start [name]
   List past sessions with: /session-list
   List all projects: /session-list --all
   ```

4. **If session exists, display status:**
   ```markdown
   ## Current Session: [session-name]

   **Project:** [project name]
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

- Show project name in the status output
- Keep output concise and informative
- Show recent updates to remind of current progress
- Include available commands for easy reference
- Calculate duration from session start to current time
