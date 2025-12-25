---
description: Generate a Jira bug ticket with proper format (Summary, Environment, Description, Reproduction, Expected/Actual, Workaround, Severity)
argument-hint: [brief-issue-description]
---

# Jira Bug Ticket Generator

Generate a well-structured Jira bug ticket based on the current context or provided description.

## Required Fields

### Summary
- Clear, concise title describing the bug
- Format: "[Feature/Method] - [Issue Description]"
- Example: "SaveAsSearchablePdf - Scale() and EnhanceResolution() Filters Cause Exception During Batch Text Rendering"

### Affects Version/s
- Specify the version(s) where this bug exists
- Example: "2025.6 and later" or specific version numbers

### Environment
- Operating system, software platform, application type, hardware specifications
- Example: "Windows 11, .NET 9.0, Console App, x64"

### Issue Description
- Clear and concise details of the issue behavior
- What is happening vs what should happen
- Include any error messages

### Minimal Reproduction Code
- Provide minimal code to reproduce the issue
- If no code needed, state "NONE"
- Keep it as simple as possible while still reproducing the bug

### Expected and Actual Outputs
- **Expected:** What should happen
- **Actual:** What actually happens
- Include screenshots, logs, or output samples if available

### Workaround (optional)
- Any temporary solution users can apply
- State "None available" if no workaround exists

### Bug Severity
Measure the impact on development or functioning:
- **Low:** Bug won't result in any noticeable breakdown of the system
- **Minor:** Results in some unexpected behavior, but not enough to disrupt system function
- **Average:** Unexpected behavior that disrupts system function but has a workaround
- **Major:** Bug capable of collapsing large parts of the system
- **Critical:** Bug capable of triggering complete system shutdown

### Priority (optional)
- Urgency of the fix: Highest, High, Medium, Low, Lowest

### Difficulty
- Estimated difficulty level: Extremely Difficult, Difficult, Average, Easy, Extremely Easy

### Scope of Work
- Estimated scope: Huge, Big, Average, Small, Tiny

### Components
- Affected product components or modules

---

## Context to Analyze

If I have context from:
- Recent test results or logs
- Code analysis
- Error messages
- Previous conversation

I will use this information to populate the bug ticket fields.

## Output Format

Generate the ticket in this exact format:

```
**Summary:** [Title]

**Affects Version/s:** [versions]

**Environment:** [OS, runtime, app type, architecture]

**Issue Description:**
[Clear description]

**Minimal Reproduction Code:**
```[language]
[code]
```

**Expected Output:**
[what should happen]

**Actual Output:**
[what actually happens]

**Workaround:** [if any, otherwise "None available"]

**Bug Severity:** [Low/Minor/Average/Major/Critical]

**Priority:** [Highest/High/Medium/Low/Lowest]

**Difficulty:** [Extremely Difficult/Difficult/Average/Easy/Extremely Easy]

**Scope of Work:** [Huge/Big/Average/Small/Tiny]

**Components:** [affected components]
```

---

If the user provides `$ARGUMENTS`, use that as the starting point for the bug description. Otherwise, analyze the current conversation context to identify the bug details.
