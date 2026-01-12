---
description: Start a new development session with progress tracking
argument-hint: [session-name]
---

# Session Start

Start a new development session by creating a session file in a project-specific directory.

## Project Detection

Detect project name by running these commands (in order, use first successful result):
1. Git repository root: `basename "$(git rev-parse --show-toplevel 2>/dev/null)"`
2. Fallback to current directory: `basename "$PWD"`

Sanitize project name: lowercase, replace spaces with dashes.

## Configuration

- **Project Sessions Directory:** `~/.claude/sessions/{project}/`
- **File Format:** `YYYY-MM-DD-HHMM-name.md` (or `YYYY-MM-DD-HHMM.md` if no name)
- **Current Date/Time:** !`date +%Y-%m-%d-%H%M`

## Instructions

1. **Detect project name** from git repo or directory name

2. **Create project directory** if not exists: `~/.claude/sessions/{project}/`

3. **Create session file:** `~/.claude/sessions/{project}/!`date +%Y-%m-%d-%H%M`-$ARGUMENTS.md`
   - If no name provided, use just the timestamp

4. **Initialize session structure:**
   ```markdown
   # Development Session - [timestamp] - [name]

   ## Overview
   - **Started:** [timestamp]
   - **Project:** [detected project name]
   - **Directory:** [current working directory]

   ## Goals
   - [ ] [Ask user for goals if not clear from context]

   ## Progress
   [Updates will be added here]
   ```

5. **Track active session:** Create/update `~/.claude/sessions/{project}/.current-session` with the session filename

6. **Confirm to user:**
   - Project detected: `{project}`
   - Session file created
   - Remind about `/session-update` and `/session-end`

## Example

```bash
# In a git repo named "deployment"
/session-start auth-refactor
# Creates: ~/.claude/sessions/deployment/2025-12-26-1430-auth-refactor.md

# In a non-git directory named "my-project"
/session-start
# Creates: ~/.claude/sessions/my-project/2025-12-26-1430.md
```

## Behavior

- Automatically detect project from git repo name or directory name
- Create project subdirectory under `~/.claude/sessions/` if not exists
- If `$ARGUMENTS` provided, use as session name (kebab-case recommended)
- If no arguments, create timestamp-only session
- Always ask for goals if not clear from conversation context
