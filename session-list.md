---
description: List session files (current project or all projects with --all)
argument-hint: [--all]
---

# Session List

List development session files for the current project, or all projects with `--all`.

## Project Detection

Detect project name by running these commands (in order, use first successful result):
1. Git repository root: `basename "$(git rev-parse --show-toplevel 2>/dev/null)"`
2. Fallback to current directory: `basename "$PWD"`

Sanitize project name: lowercase, replace spaces with dashes.

## Configuration

- **Sessions Root:** `~/.claude/sessions/`
- **Project Sessions:** `~/.claude/sessions/{project}/`

## Arguments

- `$ARGUMENTS` empty or not `--all`: List sessions for current project only
- `$ARGUMENTS` is `--all`: List all projects and their sessions

## Instructions (Current Project)

When `$ARGUMENTS` is empty or not `--all`:

1. **Detect project name** from git repo or directory name

2. **Check if project sessions directory exists:**
   - If `~/.claude/sessions/{project}/` doesn't exist, inform user no sessions found for this project

3. **List project session files:**
   - Find all `.md` files in project directory (excluding `.current-session`)
   - Sort by filename (most recent first)

4. **Display:**
   ```markdown
   ## Sessions for: {project}

   | Date | Name | Status |
   |------|------|--------|
   | 2025-12-26 14:30 | auth-refactor | Active |
   | 2025-12-25 09:15 | bug-fix | Completed |

   ### Recent Sessions

   **2025-12-26-1430-auth-refactor.md** (Active)
   - Goals: Refactor auth system
   - Updates: 3 recorded

   **2025-12-25-0915-bug-fix.md**
   - Duration: 2h 30m
   - Summary: Fixed login issue...

   ---
   View all projects: `/session-list --all`
   ```

## Instructions (All Projects)

When `$ARGUMENTS` is `--all`:

1. **List all project directories:**
   - Find all subdirectories in `~/.claude/sessions/`
   - For each, count session files and check for active session

2. **Display cross-project overview:**
   ```markdown
   ## All Projects

   | Project | Sessions | Active | Last Activity |
   |---------|----------|--------|---------------|
   | deployment | 5 | Yes | 2025-12-26 |
   | claude-commands | 3 | No | 2025-12-25 |
   | api-server | 8 | No | 2025-12-20 |

   ### Projects with Active Sessions

   **deployment** - Active: 2025-12-26-1430-auth-refactor.md
   - Goals: Refactor auth system

   ### Recent Activity by Project

   **claude-commands** (3 sessions)
   - Latest: 2025-12-25-0915-research-cmd.md

   **api-server** (8 sessions)
   - Latest: 2025-12-20-1100-performance.md
   ```

## Behavior

- Default: Show sessions for current project only
- With `--all`: Show all projects and their session counts
- Highlight active sessions clearly
- Show most recent sessions first
- Include brief overview from each session's Goals section
- For completed sessions, show summary if available
- Limit detailed view to last 5 sessions per project
