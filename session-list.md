---
description: List all session files with summaries
argument-hint: (none)
---

# Session List

List all development session files with summaries.

## Configuration

- **Sessions Location:** `~/.claude/sessions/`

## Instructions

1. **Check if sessions directory exists:**
   - If `~/.claude/sessions/` doesn't exist, inform user no sessions found

2. **List all session files:**
   - Find all `.md` files in sessions directory (excluding `.current-session`)
   - Sort by filename (most recent first, since filenames start with date)

3. **For each session file, display:**
   ```markdown
   ## Sessions

   | Date | Name | Status |
   |------|------|--------|
   | 2025-12-25 14:30 | authentication-refactor | Active |
   | 2025-12-24 09:15 | bug-fix-login | Completed |
   | 2025-12-23 16:45 | api-optimization | Completed |

   ### Recent Sessions

   **2025-12-25-1430-authentication-refactor.md** (Active)
   - Goals: Refactor auth system, implement OAuth
   - Updates: 3 updates recorded

   **2025-12-24-0915-bug-fix-login.md**
   - Duration: 2h 30m
   - Summary: Fixed login redirect issue...
   ```

4. **Highlight active session:**
   - Check `.current-session` to identify which session is active
   - Mark it clearly in the list

## Behavior

- Show most recent sessions first
- Include brief overview from each session's Goals section
- For completed sessions, show summary if available
- Limit detailed view to last 5 sessions
- For older sessions, show compact table format only
