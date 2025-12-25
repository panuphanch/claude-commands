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
