---
description: Create weekly ticket log and move cards from "Done This Week" to "Ready for Testing"
argument-hint: [--dry-run] [--log-only] [--move-only]
---

# Weekly Release Command

Create a weekly ticket log from cards in "Done This Week (merged)" list, then move all cards to "Ready for Testing" for QA validation.

## Input

**Optional Flags:**
- `--dry-run` - Preview what will happen without making changes
- `--log-only` - Only create the log file, don't move cards
- `--move-only` - Only move cards, don't create log file

**Full Arguments:** $ARGUMENTS

## Configuration

### MCP Tools Required
- **Trello MCP:** `mcp__trello__set_active_board`, `mcp__trello__get_cards_by_list_id`, `mcp__trello__move_card`

### Board Configuration
```yaml
Board ID: 6955ee3a596a0fffd0a5722b
Done This Week List ID: 6955f39baafb10f308297a84
Ready for Testing List ID: 6955ee3a596a0fffd0a5722a
```

### Label Reference
```yaml
# Type Labels
Bug: 6957381ce11b2a35ce36bf39
Feature/Improvement: 695738329a4122e0b36b1f88
Documentation: 6957384282c2926234af76d0
Verification: 69573857be49245d277bf3a3

# Product Labels
IronPdf: 6955f479e20958907e125a66
IronOcr: 6955f48c5066b105d00b0378
IronXL: 6955f4a776ff32828a3bf299
Other: 6955f4cb76e9c849815ba95d

# Priority Labels
P0 - Blocker: 6955ee3a596a0fffd0a572a0
P1 - Critical: 6955ee3a596a0fffd0a5729f
P2 - Medium: 6955ee3a596a0fffd0a5729e
P3 - Low: 6955ee3a596a0fffd0a572a3
P4 - Never: 6955ee3a596a0fffd0a572a2
```

### Log File Location
```yaml
Path: /mnt/c/Ideaverse/Calendar/Logs/
Filename Format: Weekly Tickets DD-DD Mon YYYY.md
```

## Workflow

### Phase 1: Parse Arguments

1. Check for `--dry-run` flag
2. Check for `--log-only` flag
3. Check for `--move-only` flag
4. If no flags, execute full workflow (log + move)

### Phase 2: Calculate Week Range

1. Get current date
2. Calculate Monday of current week (start date)
3. Calculate Friday of current week (end date)
4. Format as "DD-DD Mon YYYY" (e.g., "06-10 Jan 2026")

### Phase 3: Fetch Cards from "Done This Week"

1. Set active board using `mcp__trello__set_active_board`:
   - `boardId`: `6955ee3a596a0fffd0a5722b`

2. Get cards using `mcp__trello__get_cards_by_list_id`:
   - `listId`: `6955f39baafb10f308297a84`

3. For each card, extract:
   - **Name** (card title)
   - **Labels** (to determine type, product, priority)
   - **URL** (Trello card link)
   - **Jira ID** (extract from title if present, e.g., PDF-1234)

### Phase 4: Categorize Cards

Group cards by type label:
- **Bug** - Cards with Bug label
- **Feature** - Cards with Feature/Improvement label
- **Documentation** - Cards with Documentation label
- **Verification** - Cards with Verification label
- **Other** - Cards without type label

Within each category, further group by product:
- IronPdf
- IronOcr
- IronXL
- Other

### Phase 5: Generate Weekly Log File

**If `--move-only` is NOT specified:**

Create file at `/mnt/c/Ideaverse/Calendar/Logs/Weekly Tickets DD-DD Mon YYYY.md`

**File Template:**
```markdown
---
created: "YYYY-MM-DD"
week: "DD-DD Mon YYYY"
---

# Weekly Tickets (DD-DD Mon YYYY)

Summary of tickets completed and ready for testing.

## Summary

| Type | Count |
|------|-------|
| Bug | X |
| Feature | X |
| Documentation | X |
| Verification | X |
| **Total** | **X** |

## Bug Fixes

### IronPdf
- [Bug-P{n}] {JIRA-ID} {summary} - [Card]({trello-url})

### IronOcr
- [Bug-P{n}] {JIRA-ID} {summary} - [Card]({trello-url})

### IronXL
- [Bug-P{n}] {JIRA-ID} {summary} - [Card]({trello-url})

## Features & Improvements

### IronPdf
- [Feature] {JIRA-ID} {summary} - [Card]({trello-url})

### IronOcr
- [Feature] {JIRA-ID} {summary} - [Card]({trello-url})

### IronXL
- [Feature] {JIRA-ID} {summary} - [Card]({trello-url})

## Documentation

- [Docs] {summary} - [Card]({trello-url})

## Verification

- [Verify] {JIRA-ID} {summary} - [Card]({trello-url})
```

**Notes:**
- Only include sections that have cards
- Omit empty product subsections
- Extract Jira ID from card title using regex pattern `(PDF|OCR|XL)-\d+`
- For priority, look for P0/P1/P2/P3/P4 in labels

### Phase 6: Move Cards to "Ready for Testing"

**If `--log-only` is NOT specified:**

For each card in "Done This Week (merged)":
1. Use `mcp__trello__move_card`:
   - `cardId`: [card ID]
   - `listId`: `6955ee3a596a0fffd0a5722a` (Ready for Testing)

2. Track success/failure for each card

### Phase 7: Display Result

**For `--dry-run`:**
```
🔍 Dry Run - Weekly Release Preview
═══════════════════════════════════════

**Week:** DD-DD Mon YYYY
**Cards Found:** X

Would create log file:
  /mnt/c/Ideaverse/Calendar/Logs/Weekly Tickets DD-DD Mon YYYY.md

Would move X cards to "Ready for Testing":
  - [Card 1 title]
  - [Card 2 title]
  ...

Run without --dry-run to execute.
═══════════════════════════════════════
```

**For full execution:**
```
✅ Weekly Release Complete!
═══════════════════════════════════════

**Week:** DD-DD Mon YYYY

📝 **Log Created:**
   /mnt/c/Ideaverse/Calendar/Logs/Weekly Tickets DD-DD Mon YYYY.md

📦 **Cards Moved:** X cards → Ready for Testing

**Summary:**
| Type | Count |
|------|-------|
| Bug | X |
| Feature | X |
| Documentation | X |
| Verification | X |

═══════════════════════════════════════
```

**For `--log-only`:**
```
✅ Weekly Log Created!
═══════════════════════════════════════

**Week:** DD-DD Mon YYYY

📝 **Log Created:**
   /mnt/c/Ideaverse/Calendar/Logs/Weekly Tickets DD-DD Mon YYYY.md

**Cards Logged:** X (not moved)

═══════════════════════════════════════
```

**For `--move-only`:**
```
✅ Cards Moved!
═══════════════════════════════════════

**Week:** DD-DD Mon YYYY

📦 **Cards Moved:** X cards → Ready for Testing

═══════════════════════════════════════
```

## Error Handling

| Error | Message |
|-------|---------|
| No cards found | "No cards in 'Done This Week (merged)' list. Nothing to process." |
| Trello API error | "Error: {error message}. Please check MCP connection." |
| File write error | "Error creating log file: {error}. Please check permissions." |
| Move failure | "Warning: Failed to move card '{name}': {error}" |

## Example Usage

```bash
# Full workflow: create log and move cards
/weekly-release

# Preview what will happen
/weekly-release --dry-run

# Only create the log file
/weekly-release --log-only

# Only move cards (skip log creation)
/weekly-release --move-only
```

## Behavior Notes

- Always fetches fresh card data from Trello
- Creates log file before moving cards (ensures log is created even if move fails)
- Skips empty sections in the log file
- Extracts Jira IDs from card titles for better tracking
- Groups cards by type and product for organized log
- Shows summary counts for quick overview
- Safe by default - use `--dry-run` to preview changes
