---
description: End session with comprehensive summary
argument-hint: (none)
---

# Session End

End the current development session with a comprehensive summary.

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
   - If no active session, inform user there's nothing to end for this project

3. **Generate comprehensive summary:**

   Append to the session file:
   ```markdown
   ---

   ## Session Summary

   ### Duration
   - **Started:** [from session file]
   - **Ended:** [current timestamp]
   - **Duration:** [calculated]

   ### Git Summary
   - **Files Changed:** [count] (added/modified/deleted breakdown)
   - **Commits Made:** [count if any]
   - **Changed Files:**
     - [list all files with change type]
   - **Final Status:** [clean/uncommitted changes]

   ### Todo Summary
   - **Completed:** [count] tasks
   - **Remaining:** [count] tasks
   - **Completed Tasks:**
     - [list completed tasks]
   - **Incomplete Tasks:**
     - [list if any]

   ### Key Accomplishments
   - [Major features/fixes implemented]

   ### Problems & Solutions
   - **Problem:** [issue encountered]
     **Solution:** [how it was resolved]

   ### Dependencies & Configuration
   - **Added:** [packages/tools added]
   - **Removed:** [packages/tools removed]
   - **Config Changes:** [any configuration modifications]

   ### Lessons Learned
   - [Key insights for future reference]

   ### Tips for Future Developers
   - [Helpful notes for anyone continuing this work]

   ### What Wasn't Completed
   - [Tasks remaining for next session]
   ```

4. **Clear active session:**
   - Empty the contents of `~/.claude/sessions/{project}/.current-session` (don't delete the file)

5. **Confirm session ended:**
   - Show project name and summary highlights
   - Inform user the session has been documented

## Behavior

- Use project-specific session directory and .current-session file
- Generate thorough summary that another developer (or AI) can understand
- Capture all git changes since session start
- Include all todo items and their final status
- Document any breaking changes or important discoveries
- The summary should be self-contained and actionable
