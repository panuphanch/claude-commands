# Claude Commands

A personal collection of slash commands for [Claude Code](https://docs.anthropic.com/en/docs/claude-code).

## Installation

### Option 1: Symlink (Recommended)

Allows easy `git pull` updates while keeping commands in sync.

```bash
# Clone the repository
cd ~/.claude
git clone https://github.com/panuphanch/claude-commands.git

# Create symlinks for all commands
ln -sf ~/.claude/claude-commands/*.md ~/.claude/commands/
```

### Option 2: Using install script

```bash
# Clone and run install script
git clone https://github.com/panuphanch/claude-commands.git
cd claude-commands
chmod +x install.sh
./install.sh
```

### Option 3: Direct clone

```bash
# Backup existing commands first!
cp -r ~/.claude/commands ~/.claude/commands.backup

# Clone directly to commands directory
cd ~/.claude
git clone https://github.com/panuphanch/claude-commands.git commands
```

## Available Commands

| Command | Description |
|---------|-------------|
| `/jira-bug` | Generate a Jira bug ticket with proper format |
| `/daily-note` | Update daily notes from conversation context |
| `/create-command` | Generate a new slash command template |
| `/research` | Software engineering research using sequential-thinking and web search |
| `/rc-test` | Test Iron Software product RC releases as QA Engineer |
| `/rc-test-python` | Test Iron Software Python packages as QA Engineer |
| `/session-start` | Start a new development session (per-project) |
| `/session-update` | Add progress update to current session |
| `/session-end` | End session with comprehensive summary |
| `/session-current` | Show current session status |
| `/session-list` | List sessions (current project or --all) |
| `/weekly-note` | Generate weekly log for Slack sharing |
| `/legacy-card` | Create Trello card from Jira issue (Legacy Team) |

### `/jira-bug`

Generate a well-formatted Jira bug ticket from conversation context.

```bash
/jira-bug                                    # Uses conversation context
/jira-bug Scale filter breaks SaveAsSearchablePdf   # With description hint
```

**Fields Generated:**
- Summary (format: `[Feature/Method] - [Issue Description]`)
- Affects Version/s
- Environment (OS, runtime, app type, architecture)
- Issue Description
- Minimal Reproduction Code
- Expected/Actual Output
- Workaround
- Bug Severity (Low/Minor/Average/Major/Critical)
- Priority (Highest/High/Medium/Low/Lowest)
- Difficulty (Extremely Difficult/Difficult/Average/Easy/Extremely Easy)
- Scope of Work (Huge/Big/Average/Small/Tiny)
- Components

### `/daily-note`

Update daily notes from conversation context. Auto-detects today's date.

```bash
/daily-note                           # Update from conversation context
/daily-note IronOCR testing complete  # With specific topic
```

**Configuration:**
- Notes Location: `/mnt/c/Ideaverse/Calendar/Notes/`
- File Format: `YYYY-MM-DD.md`

### `/create-command`

Generate a new slash command template (meta-command).

```bash
/create-command pr-review    # Generate template for new command
/create-command              # Interactive mode
```

### `/research`

Conduct structured technical research as a Software Engineer using sequential-thinking and web search tools.

```bash
/research best Python async HTTP client 2025
/research how to implement rate limiting in Node.js
/research React vs Vue vs Svelte 2025
/research fix CORS error with fetch API
```

**Research Types:**
- Library/framework evaluation
- Implementation guides
- Troubleshooting/debugging
- Architecture decisions
- Technology comparisons

**Workflow:**
1. **Analyze** - Use sequential-thinking to clarify question and plan searches
2. **Search** - Auto-select tool (tavily/brave/firecrawl) based on research type
3. **Synthesize** - Combine findings with trade-off analysis and recommendations

### `/rc-test`

Test Iron Software product Release Candidate as a QA Engineer.

```bash
/rc-test Word 2025.11.39-prerelease                    # Test IronWord RC
/rc-test Pdf 2025.12.1                                  # Test IronPdf RC
/rc-test Ocr 2025.12.2-prerelease39687 /path/notes.txt  # With custom release notes
```

**Arguments:**

| Arg | Description | Example |
|-----|-------------|---------|
| `$1` | Product name | Word, Pdf, Ocr, Barcode, Xl |
| `$2` | Version | 2025.11.39-prerelease |
| `$3` | Release notes path (optional) | /path/to/notes.txt |

**Workflow Phases:**

| Phase | Description |
|-------|-------------|
| 0 | Environment check (PAT, nuget.config, license key) |
| 1 | Project setup (create or verify test project structure) |
| 2 | Test planning (read release notes, research API, create test steps) |
| 3 | Test implementation (create test classes) |
| 4 | Test execution (`dotnet run`) |
| 5 | Validation (manual review of output files) |
| 6 | Reporting (summary, final report, Slack message) |

**Configuration:**
- Tests Location: `/mnt/c/IronSoftware/IronRCTests/{Product}Tests/`
- Private NuGet Feeds: Asked from user (not stored for security)
- License Key: Placeholder `IRON{PRODUCT}_LICENSE_KEY_HERE`

**Output Files:**
- `docs/test-steps/IRON{PRODUCT}_YYYY_MM_TEST_STEPS.md`
- `docs/test-results/IRON{PRODUCT}_YYYY_MM_RC_TEST_SUMMARY.md`
- Slack release message (on approval)

### `/rc-test-python`

Test Iron Software Python packages as a QA Engineer.

```bash
/rc-test-python Xl 2025.12.0.2                          # Test IronXL Python
/rc-test-python Pdf 2025.12.1                           # Test IronPdf Python
```

**Arguments:**

| Arg | Description | Example |
|-----|-------------|---------|
| `$1` | Product name | Pdf, Xl, Ocr |
| `$2` | Version | 2025.12.0.2 |
| `$3` | Release notes path (optional) | /path/to/notes.txt |

**Workflow Phases:** Same as `/rc-test` but adapted for Python

| Phase | Description |
|-------|-------------|
| 0 | Environment check (Python, venv, pip config, keyring) |
| 1 | Project setup (venv, requirements.txt) |
| 2 | Test planning (release notes, Python API docs) |
| 3 | Test implementation (`test.py`) |
| 4 | Test execution (`python test.py`) - Windows & Linux |
| 5 | Validation (manual review of output files) |
| 6 | Reporting (summary with platform status) |

**Configuration:**
- Tests Location: `/mnt/c/IronSoftware/IronRCTests/python-test-iron{product}/`
- Private PyPI Feeds: Asked from user (not stored for security)
- Multi-platform testing: Windows, Linux, macOS

### Session Management Commands

Track development sessions across Claude Code conversations with per-project organization.

**Storage Structure:**
```
~/.claude/sessions/
├── project-a/
│   ├── .current-session
│   └── 2025-12-26-1430-feature.md
├── project-b/
│   ├── .current-session
│   └── 2025-12-25-0900-bugfix.md
```

**Project Detection:** Automatically detects project name from git repo or directory name.

#### `/session-start`

Start a new development session for the current project.

```bash
/session-start auth-refactor   # Named session
/session-start                  # Timestamp-only session
```

#### `/session-update`

Add timestamped progress to the active session.

```bash
/session-update Fixed OAuth issue   # With notes
/session-update                       # Auto-summarize
```

#### `/session-end`

End session with comprehensive summary (duration, git changes, accomplishments, lessons learned).

```bash
/session-end
```

#### `/session-current`

Show current session status for this project.

```bash
/session-current
```

#### `/session-list`

List sessions for current project, or all projects with `--all`.

```bash
/session-list          # Current project only
/session-list --all    # All projects overview
```

#### Workflow Example

```bash
/session-start user-authentication
# Work on implementation...
/session-update Added login middleware
# Continue working...
/session-update Fixed token refresh
# When done...
/session-end
```

### `/weekly-note`

Generate weekly log for Slack sharing. Auto-detects current and next week dates.

```bash
/weekly-note    # Auto-detects dates, reads daily logs
```

**Configuration:**
- Notes Location: `/mnt/c/Ideaverse/Calendar/Notes/`
- Daily Log Format: `YYYY-MM-DD.md`

**Workflow:**
1. Calculate this week (Mon-Fri) and next week date ranges
2. Read daily logs from current week
3. Extract tasks with status markers
4. Find next week's planned tasks from latest daily note
5. Output Slack-ready format

**Status Markers:**

| Status | Obsidian | Slack Output |
|--------|----------|--------------|
| Completed | ✅ | ✅ |
| In-Progress | 🔄 | `:loading:` |
| Leave | 🏖️ | 🏖️ |

**Output Format:**
```markdown
## @Meee's Weekly Update (Mon DD - Fri DD, Mon YYYY)

### Last Week's Tasks
- ✅ Task 1: [Description]
- :loading: Task 2: [In-progress]

### This Week's Tasks
- [Highest] Task 1: [Description]
- [High] Task 2: [Description]
- [Low] Task 3: [Description]
```

### `/legacy-card`

Create Trello card on Legacy Team board from Jira issue with auto-detection.

```bash
/legacy-card PDF-2129                           # Auto-detect type from Jira
/legacy-card PDF-2129 --type bug --priority P1  # Override type and priority
/legacy-card XL-789 --type docs --pr <url>      # Docs require PR link
/legacy-card PDF-1234 --type verify             # Verification (explicit only)
```

**Arguments:**

| Arg | Description | Example |
|-----|-------------|---------|
| `$1` | Jira ID (required) | PDF-2129, OCR-456, XL-789 |
| `--type` | Override card type | bug, feature, docs, verify |
| `--priority` | Override priority (bugs only) | P0, P1, P2, P3, P4 |
| `--pr` | PR link (required for docs) | https://github.com/... |

**Auto-Detection:**
- Card type from Jira issue type (Bug → Bug, Story/Task → Feature)
- Product from Jira project prefix (PDF → IronPdf, OCR → IronOcr, XL → IronXL)
- Priority from Jira priority (bugs only)

**MCP Requirements:**
- Atlassian MCP (Jira integration)
- Trello MCP (card creation)

## Documentation

See **[SLASH-COMMAND-GUIDE.md](SLASH-COMMAND-GUIDE.md)** for comprehensive documentation on creating commands, including:

- File structure and locations
- YAML frontmatter options
- Special variables (`$ARGUMENTS`, `$1`, `@filepath`, `!command`)
- Best practices and examples
- Debugging tips

## Future Commands

| Command | Purpose | Status |
|---------|---------|--------|
| `/jira-feature` | Feature request ticket | Planned |
| `/jira-task` | Task/story ticket | Planned |
| `/github-issue` | GitHub issue | Planned |
| `/github-pr` | Pull request description | Planned |

## Contributing

1. Create a new `.md` file following the naming convention (lowercase with hyphens)
2. Add YAML frontmatter with `description`
3. Write clear instructions and output format
4. Update this README with the new command

## License

MIT License - See [LICENSE](LICENSE) file.
