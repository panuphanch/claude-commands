---
description: Generate weekly log for Slack sharing (auto-detects current/next week)
---

# Weekly Notes Generator

Generate a weekly update log for Slack sharing based on daily notes.

## Configuration

- **Notes Location:** `/mnt/c/Ideaverse/Calendar/Notes/`
- **Daily Log Format:** `YYYY-MM-DD.md`
- **Reference Format:** `Weekly Logs 15-19 Dec 2025.md`
- **Current Date:** !`date +%Y-%m-%d`

## Instructions

1. **Calculate date ranges:**
   - This week: Monday to Friday of the current week
   - Next week: Monday to Friday of the following week

2. **Read daily logs** from `/mnt/c/Ideaverse/Calendar/Notes/` for this week's dates (Mon-Fri)

3. **Extract from daily logs:**
   - Completed tasks (marked with ✅)
   - In-progress tasks (marked with 🔄 or unmarked ongoing work)
   - Leave/holidays (marked with 🏖️)
   - Key accomplishments and findings

4. **Find next week's tasks** from the latest daily note (today's note or most recent)
   - Look for "Next week" sections or planned tasks
   - Apply priority ordering: [Highest] → [High] → [Low]

5. **Convert for Slack output:**
   - Keep ✅ for completed
   - Convert 🔄 or in-progress → `:loading:`
   - Keep 🏖️ for leave/holidays

## Output Format

Generate output in this exact format (short & concise):

```markdown
## @Meee's Weekly Update (Mon DD - Fri DD, Mon YYYY)

### Last Week's Tasks

- ✅ Task 1: [Brief description]
	- [Key detail or sub-item if needed]
- :loading: Task 2: [In-progress work]
- 🏖️ Leave: [Days if applicable]

### This Week's Tasks

- [Highest] Task 1: [Description]
- [High] Task 2: [Description]
- [Low] Task 3: [Description]
```

## Guidelines

- Keep descriptions **short & concise** - no long details
- Group related items under main task bullets
- Use tab indentation for sub-items
- Priority order for next week: Highest → High → Low
- Include leave/holidays if applicable
- Focus on what was done, not how it was done
