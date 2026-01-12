---
description: Create Trello card on Legacy Team board from Jira issue
argument-hint: [JIRA-ID] [--type bug|feature|docs|verify] [--priority P0-P4] [--pr <url>] [--notes "text"]
---

# Legacy Card Creator

Create a Trello card on the Legacy Team board from a Jira issue with auto-detection of card type, product, and priority.

## Input

**Required:** Jira ID as first argument (e.g., `PDF-2129`, `OCR-456`, `XL-789`)

**Optional Flags:**
- `--type bug|feature|docs|verify` - Override auto-detected card type
- `--priority P0|P1|P2|P3|P4` - Override priority (bugs only)
- `--pr <url>` - PR link (required for docs, optional for others)
- `--notes "text"` - Additional notes to include in the card description

**Full Arguments:** $ARGUMENTS

## Configuration

### MCP Tools Required
- **Atlassian MCP:** `mcp__atlassian__getJiraIssue`
- **Trello MCP:** `mcp__trello__set_active_board`, `mcp__trello__add_card_to_list`

### Board Configuration
```yaml
Board ID: 6955ee3a596a0fffd0a5722b
Backlog List ID: 6955ee3a596a0fffd0a57224
Jira Cloud ID: bc5997a0-142c-4b85-a0f3-f9fdf46dc6fc
```

### Label IDs

**Type Labels:**
| Type | Label ID |
|------|----------|
| Bug | `6957381ce11b2a35ce36bf39` |
| Feature/Improvement | `695738329a4122e0b36b1f88` |
| Documentation | `6957384282c2926234af76d0` |
| Verification | `69573857be49245d277bf3a3` |

**Product Labels:**
| Project Prefix | Product | Label ID |
|----------------|---------|----------|
| PDF-* | IronPdf | `6955f479e20958907e125a66` |
| OCR-* | IronOcr | `6955f48c5066b105d00b0378` |
| XL-* | IronXL | `6955f4a776ff32828a3bf299` |
| Other | Other | `6955f4cb76e9c849815ba95d` |

**Priority Labels (Bugs Only):**
| Jira Priority | Trello Label | Label ID |
|---------------|--------------|----------|
| Highest | P0 - Blocker | `6955ee3a596a0fffd0a572a0` |
| High | P1 - Critical | `6955ee3a596a0fffd0a5729f` |
| Medium | P2 - Medium | `6955ee3a596a0fffd0a5729e` |
| Low | P3 - Low | `6955ee3a596a0fffd0a572a3` |
| Lowest | P4 - Never | `6955ee3a596a0fffd0a572a2` |

## Workflow

### Phase 1: Parse Input

1. Extract Jira ID from the first argument
2. Parse optional flags from arguments:
   - `--type` value (bug, feature, docs, verify)
   - `--priority` value (P0, P1, P2, P3, P4)
   - `--pr` URL value
   - `--notes` text value (quoted string)
3. Validate Jira ID format (PROJECT-NUMBER pattern)

**Validation Rules:**
- Jira ID is required - show error if missing
- If `--type docs` is specified, `--pr` is required
- Verification cards only created with explicit `--type verify`

### Phase 2: Fetch Jira Issue

Use `mcp__atlassian__getJiraIssue` with:
- `cloudId`: `bc5997a0-142c-4b85-a0f3-f9fdf46dc6fc`
- `issueIdOrKey`: [parsed Jira ID]

Extract from response:
- **Summary** (fields.summary)
- **Issue Type** (fields.issuetype.name)
- **Priority** (fields.priority.name)
- **Description** (fields.description - may be ADF format)
- **Project Key** (from issue key prefix)

### Phase 3: Detect Card Type

**Auto-Detection Logic (if no --type flag):**
1. Jira issue type "Bug" → Bug card
2. Jira issue type "Story", "Task", "Feature", "Improvement", "New Feature" → Feature card
3. Jira issue type "Documentation" → Documentation card
4. Otherwise → Feature card (default)

**Override:** If `--type` flag provided, use that value instead.

**Note:** Verification cards are ONLY created when `--type verify` is explicitly specified.

### Phase 4: Detect Product

From Jira project key (first part of issue ID):
- `PDF` → IronPdf (label: `6955f479e20958907e125a66`)
- `OCR` → IronOcr (label: `6955f48c5066b105d00b0378`)
- `XL` → IronXL (label: `6955f4a776ff32828a3bf299`)
- Other → Other (label: `6955f4cb76e9c849815ba95d`)

### Phase 5: Detect Priority (Bugs Only)

If card type is Bug:
1. If `--priority` flag provided → Use that value
2. Otherwise map from Jira priority:
   - Highest → P0 - Blocker (`6955ee3a596a0fffd0a572a0`)
   - High → P1 - Critical (`6955ee3a596a0fffd0a5729f`)
   - Medium → P2 - Medium (`6955ee3a596a0fffd0a5729e`)
   - Low → P3 - Low (`6955ee3a596a0fffd0a572a3`)
   - Lowest → P4 - Never (`6955ee3a596a0fffd0a572a2`)

### Phase 6: Build Card Content

**Title Formats:**
| Type | Format | Example |
|------|--------|---------|
| Bug | `[Bug-P{n}] {JIRA-ID} {summary}` | `[Bug-P1] PDF-2129 Fix Linux dependency issue` |
| Feature | `[Feature] {JIRA-ID} {summary}` | `[Feature] OCR-456 Add batch processing` |
| Docs | `[Docs] {summary}` | `[Docs] Update API reference for SaveAs` |
| Verify | `[Verify] {JIRA-ID} {summary}` | `[Verify] PDF-1234 Fix PDF crash` |

**Description Templates:**

#### Bug Template
```
## Jira Link
🎫 Jira: {JIRA-ID}
🔗 https://ironsoftware.atlassian.net/browse/{JIRA-ID}

## Details
📦 **Product:** {Product}
🐛 **Steps to Reproduce:** [From Jira description if available]
📝 **Notes:** [Additional context from Jira]

## Release Note
📣 [One-line summary for release notes - fill when done]
```

#### Feature Template
```
## Jira Link
🎫 Jira: {JIRA-ID}
🔗 https://ironsoftware.atlassian.net/browse/{JIRA-ID}

## Details
📦 **Product:** {Product}
🎯 **Scope:** {Summary from Jira description}
📝 **Notes:** [Additional context from Jira]

## Release Note
📣 [One-line summary for release notes - fill when done]
```

#### Documentation Template
```
## Related Change
🎫 Jira: {JIRA-ID} (if applicable)
🔗 PR: {PR-URL}

## Details
📦 **Product:** {Product}
📝 **What to Document:** {From Jira description}
📍 **Where:** [Which docs page to update]

## Example Code
[Code snippet showing usage - provided by dev]

## Notes
[Additional context from dev]
```

#### Verification Template
```
## Jira Link
🎫 Jira: {JIRA-ID}
🔗 https://ironsoftware.atlassian.net/browse/{JIRA-ID}

## Details
📦 **Product:** {Product}
🧪 **What to Test:** {From Jira description}
✅ **Expected Result:** {Expected behavior from Jira}

## Test Result
🔘 **Status:** [ ] Pass / [ ] Fail
📝 **Notes:** [Test findings]
```

### Phase 7: Create Trello Card

1. Set active board using `mcp__trello__set_active_board`:
   - `boardId`: `6955ee3a596a0fffd0a5722b`

2. Create card using `mcp__trello__add_card_to_list`:
   - `listId`: `6955ee3a596a0fffd0a57224` (Backlog)
   - `name`: Generated title
   - `description`: Generated description from template
   - `labels`: Array of label IDs (type + product + priority if bug)

### Phase 8: Display Result

Show success message with:
```
✅ Trello Card Created Successfully!
═══════════════════════════════════════

**Card:** [Title]
**URL:** [Trello card URL]
**List:** Backlog
**Labels:** [Type], [Product], [Priority if bug]

**Jira Link:** https://ironsoftware.atlassian.net/browse/{JIRA-ID}

═══════════════════════════════════════
```

## Error Handling

| Error | Message |
|-------|---------|
| Missing Jira ID | "Error: Jira ID required. Usage: /legacy-card PDF-2129" |
| Jira not found | "Error: Jira issue {ID} not found. Please check the ID." |
| Docs without PR | "Error: Documentation cards require --pr flag. Usage: /legacy-card PDF-2129 --type docs --pr https://..." |
| Invalid type | "Error: Invalid type. Valid options: bug, feature, docs, verify" |
| Invalid priority | "Error: Invalid priority. Valid options: P0, P1, P2, P3, P4" |
| Trello API error | "Error creating card: {error message}. Please try again." |

## Example Usage

```bash
# Auto-detect type from Jira issue type
/legacy-card PDF-2129

# Override to create bug card with specific priority
/legacy-card PDF-2129 --type bug --priority P1

# Create feature card (override auto-detection)
/legacy-card OCR-456 --type feature

# Create documentation card (requires PR link)
/legacy-card XL-789 --type docs --pr https://github.com/iron-software/IronXL/pull/123

# Create verification card (explicit only)
/legacy-card PDF-1234 --type verify

# Add custom notes to the card
/legacy-card PDF-1133 --notes "Investigate first, might be font-related"

# Combine multiple flags
/legacy-card PDF-2000 --type bug --priority P2 --notes "Customer escalation - urgent"
```

## Behavior Notes

- Always fetch fresh Jira data before creating card
- Respect user overrides (--type, --priority) when provided
- Default to Feature if Jira issue type cannot be mapped
- Extract meaningful content from Jira description for card details
- Include direct links to both Jira and the created Trello card
- For Documentation cards, PR link is mandatory
- For Verification cards, must explicitly specify --type verify
