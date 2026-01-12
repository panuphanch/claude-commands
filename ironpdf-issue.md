---
description: Manage GitHub issues for Universal.IronPdf (view, create, edit, comment)
argument-hint: [view|create|edit|comment] [issue-number] ["description"] [--labels]
---

# Universal.IronPdf Issue Manager

Manage GitHub issues for the Universal.IronPdf repository with intelligent content crafting.

## Input

**Full Arguments:** $ARGUMENTS

### Operations

| Operation | Syntax | Description |
|-----------|--------|-------------|
| View | `/ironpdf-issue [number]` or `/ironpdf-issue view [number]` | View issue details |
| Create | `/ironpdf-issue create "description" [--labels "label1,label2"]` | Create new issue |
| Edit | `/ironpdf-issue edit [number] "description"` | Edit existing issue |
| Comment | `/ironpdf-issue comment [number] "description"` | Add comment to issue |

## Configuration

```yaml
Repository: iron-software/Universal.IronPdf
```

## Workflow

### Phase 1: Parse Input

1. Detect operation from first argument:
   - If first arg is a number → `view` operation
   - If first arg is `view`, `create`, `edit`, `comment` → that operation
   - Default to showing help if unrecognized

2. Extract parameters:
   - **view**: Issue number
   - **create**: Description (quoted string), optional `--labels`
   - **edit**: Issue number, description (quoted string)
   - **comment**: Issue number, description (quoted string)

### Phase 2: Execute Operation

#### View Issue

Use Bash to run:
```bash
gh issue view [number] --repo iron-software/Universal.IronPdf
```

Display results in formatted output with:
- Issue title and state
- Labels and assignees
- Body content
- Recent comments (if any)

#### Create Issue

1. **Craft Title** from description:
   - Extract the core feature/bug summary
   - Follow project conventions: `[Category] Brief description`
   - Keep under 80 characters

2. **Craft Body** from description:
   - Structure with clear sections:
   ```markdown
   ## Overview
   [Brief summary of what this issue addresses]

   ## Scope
   [Specific functionality or changes needed]

   ## Acceptance Criteria
   - [ ] [Criterion 1]
   - [ ] [Criterion 2]
   ```

3. **Execute** using Bash:
   ```bash
   gh issue create --repo iron-software/Universal.IronPdf \
     --title "[Crafted Title]" \
     --body "[Crafted Body]" \
     --label "[labels if provided]"
   ```

4. **Display** created issue URL and number

#### Edit Issue

1. **Read existing issue** first:
   ```bash
   gh issue view [number] --repo iron-software/Universal.IronPdf
   ```

2. **Craft updates** from description:
   - If description implies title change → update title
   - Append or modify body content appropriately
   - Preserve existing structure while adding new information

3. **Execute** using Bash:
   ```bash
   gh issue edit [number] --repo iron-software/Universal.IronPdf \
     --title "[Updated Title if changed]" \
     --body "[Updated Body]"
   ```

4. **Display** updated issue details

#### Add Comment

1. **Read existing issue and comments** for context:
   ```bash
   gh issue view [number] --repo iron-software/Universal.IronPdf --comments
   ```

2. **Craft comment** from description:
   - Format status updates consistently
   - Structure technical notes clearly
   - Reference related items if mentioned

3. **Execute** using Bash:
   ```bash
   gh issue comment [number] --repo iron-software/Universal.IronPdf \
     --body "[Crafted Comment]"
   ```

4. **Confirm** comment was added

### Phase 3: Display Result

Show success message with relevant details:

**For View:**
```
Issue #[number]: [title]
State: [open/closed]
Labels: [labels]
---
[body content]
```

**For Create:**
```
Issue Created Successfully!

Issue: #[number] [title]
URL: [issue URL]
Labels: [labels]
```

**For Edit:**
```
Issue Updated Successfully!

Issue: #[number] [updated title]
URL: [issue URL]
Changes: [summary of what changed]
```

**For Comment:**
```
Comment Added Successfully!

Issue: #[number] [title]
Comment: [first 100 chars of comment...]
```

## Content Crafting Guidelines

### Title Conventions
- **Features**: `[Feature] Brief description of capability`
- **Bugs**: `[Bug] Brief description of issue`
- **Infra**: `[Infrastructure] Brief description`
- **Docs**: `[Docs] Brief description`

### Body Structure

**For Features:**
```markdown
## Overview
[What capability is being added]

## Scope
[Specific implementation details]

## Technical Notes
[Any relevant technical considerations]

## Acceptance Criteria
- [ ] [Testable criterion]
```

**For Bugs:**
```markdown
## Description
[What is happening vs what should happen]

## Steps to Reproduce
1. [Step 1]
2. [Step 2]

## Expected Behavior
[What should happen]

## Actual Behavior
[What actually happens]
```

### Comment Formatting

**Status Update:**
```markdown
## Status Update

[Current status description]

### Progress
- [x] [Completed item]
- [ ] [Pending item]

### Notes
[Any additional context]
```

**Technical Note:**
```markdown
## Technical Note

[Technical information or finding]

### Details
[Specific details]

### Impact
[How this affects the implementation]
```

## Error Handling

| Error | Message |
|-------|---------|
| Missing issue number | "Error: Issue number required. Usage: /ironpdf-issue view 8" |
| Issue not found | "Error: Issue #[number] not found in iron-software/Universal.IronPdf" |
| Missing description | "Error: Description required. Usage: /ironpdf-issue create \"description\"" |
| Invalid operation | "Error: Unknown operation. Valid: view, create, edit, comment" |
| API error | "Error: GitHub API error: [message]" |

## Example Usage

```bash
# View issue details
/ironpdf-issue 8
/ironpdf-issue view 45

# Create new feature issue
/ironpdf-issue create "Add support for extracting tables from PDFs as CSV format" --labels "feature: Extract"

# Create bug issue
/ironpdf-issue create "PDF merge fails when documents have different page sizes" --labels "bug"

# Edit existing issue scope
/ironpdf-issue edit 8 "Expand scope to also support JSON and XML output formats"

# Add progress comment
/ironpdf-issue comment 8 "Started implementation using PDFium table detection APIs. Initial prototype working for simple tables."

# Add technical comment
/ironpdf-issue comment 45 "Found that nested tables require recursive parsing. Will need additional iteration."
```

## Behavior Notes

- Always use `--repo iron-software/Universal.IronPdf` flag with all gh commands
- Craft professional, well-structured content from user descriptions
- Preserve existing issue content when editing (append/modify, don't replace)
- Read context before editing or commenting to maintain consistency
- Follow project conventions for titles and body structure
