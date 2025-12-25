---
description: End session with comprehensive summary
argument-hint: (none)
---

# Session End

End the current development session with a comprehensive summary.

## Configuration

- **Sessions Location:** `~/.claude/sessions/`
- **Current Time:** !`date "+%Y-%m-%d %H:%M"`

## Instructions

1. **Check for active session:**
   - Read `~/.claude/sessions/.current-session` for active session filename
   - If no active session, inform user there's nothing to end

2. **Generate comprehensive summary:**

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

3. **Clear active session:**
   - Empty the contents of `~/.claude/sessions/.current-session` (don't delete the file)

4. **Confirm session ended:**
   - Show summary highlights
   - Inform user the session has been documented

## Behavior

- Generate thorough summary that another developer (or AI) can understand
- Capture all git changes since session start
- Include all todo items and their final status
- Document any breaking changes or important discoveries
- The summary should be self-contained and actionable
