---
description: Test Iron Software Python packages as QA Engineer
argument-hint: [product] [version] [release-notes-file]
---

# RC Testing Command (Python)

Test Iron Software Python package Release Candidate as a QA Engineer.

## Arguments

- `$1` - Product name (e.g., Pdf, Xl, Ocr)
- `$2` - Version (e.g., 2025.12.0.2)
- `$3` - Release notes file path (optional if in standard location)

## Configuration

- **Tests Location:** `/mnt/c/IronSoftware/IronRCTests/`
- **Project Pattern:** `python-test-iron{product}/`
- **License Key Placeholder:** `IRONXL_LICENSE_KEY_HERE` (replace with actual key)

### Release Notes Location
- **New project:** `/mnt/c/IronSoftware/IronRCTests/Iron{Product}-python-release-notes-{month}-{year}.txt`
- **Existing project:** `python-test-iron{product}/docs/release-notes/`

### Private PyPI Feeds

Private feed URLs are not stored in this command for security reasons.

**Behavior:**
- If `pip.ini` (Windows) or `pip.conf` (Linux) doesn't exist, ask user for:
  - Azure Artifacts feed URL
  - Authentication method (keyring or PAT)
- Store in project's `venv/pip.ini` or `venv/pip.conf`

### Product Example URLs (Entry Points)

| Product | Python Docs URL |
|---------|-----------------|
| Pdf | https://ironpdf.com/python/ |
| Xl | https://ironsoftware.com/python/excel/ |
| Ocr | https://ironsoftware.com/python/ocr/ |

**Note:** Research the Python-specific documentation for API differences.

## Workflow

### Phase 0: Environment Check

1. **Check Python version:** `python --version` (requires 3.8+)

2. **Check virtual environment:**
   - If `venv/` doesn't exist, create it: `python -m venv venv`
   - Activate: `source venv/bin/activate` (Linux) or `venv\Scripts\activate` (Windows)

3. **Check pip config exists:**
   - Windows: `venv/pip.ini`
   - Linux: `venv/pip.conf`
   - If not exists, ask user for Azure Artifacts feed URL and create config

4. **Check keyring/auth:**
   - Windows: `pip install keyring artifacts-keyring`
   - Linux: May need PAT token in pip.conf

5. **Check License Key in test.py:**
   - Look for: `iron{product}.License.LicenseKey = "..."`
   - If placeholder detected, ask user to provide actual license key

### Phase 1: Project Setup

1. **Check if test project exists:** `python-test-iron{product}/`
2. **If not exists:**
   - Create project structure (test.py, requirements.txt, .gitignore)
   - Create venv and pip config
   - Create docs folders (release-notes, test-steps, test-results)
   - Move release notes file to `docs/release-notes/`
   - Add to requirements.txt: `iron{product}=={version}`

3. **If exists:**
   - Verify pip config has correct feed
   - Verify release notes in `docs/release-notes/`
   - Update package version in requirements.txt if needed
   - Run: `pip install -r requirements.txt --upgrade`

### Phase 2: Test Planning

1. **Read release notes** and identify test items:
   - New features
   - Enhancements
   - Bug fixes
   - Platform-specific issues (Windows/Linux/macOS)

2. **Research API usage:**
   - Fetch Python-specific documentation
   - Note API differences from .NET (e.g., `.IntValue` vs `.Value`)

3. **Create test steps documentation:**
   - Location: `docs/test-steps/IRON{PRODUCT}_PYTHON_YYYY_MM_TEST_STEPS.md`
   - Include: Test ID, description, steps, expected result, platform requirements

### Phase 3: Test Implementation

1. **Create test.py** with test functions
2. **Implement tests** with:
   - Platform detection (Windows/Linux/macOS)
   - TestResult tracking
   - Output file generation for visual validation
   - Console output for progress

### Phase 4: Test Execution

1. **Run tests on Windows:** `python test.py`
2. **Run tests on Linux (WSL2):** `python test.py`
3. **Capture results:**
   - Automated: Pass/fail status per platform
   - Manual: Request user to validate output files

### Phase 5: Validation

For tests requiring visual validation:
1. List output files that need manual review
2. Ask user to confirm each output is correct
3. Capture validation results per platform

### Phase 6: Reporting

1. **Generate test summary** in message for user feedback
2. **Wait for user approval**
3. **Write final report:** `docs/test-results/IRON{PRODUCT}_PYTHON_YYYY_MM_RC_TEST_SUMMARY.md`
4. **Generate Slack message** for release announcement:
   - Ask user for Action Items (who does what)
   - Ask user for CC list (who to notify)
   - Include platform-specific status (Windows/Linux/macOS)

### Slack Message Format

**Notes:**
- If user says "I will handle it" for Action Items, use `@Meee` as the tag
- Default action is "create new release package" - user will specify additional actions if needed
- Include platform status for Python packages

```
:white_check_mark: Iron{Product} Python {version} PASSED
- Windows: {status}
- Linux: {status}
- {Feature/bug fix summary}
Action Items:
- @Meee will create new release package (default if user handles it)
Full report attached
Ready for release :rocket:
CC: @{names}
```

Or if partial pass:
```
:warning: Iron{Product} Python {version} PARTIAL PASS
- Windows: :white_check_mark: PASSED
- Linux: :x: FAILED - {issue}
- macOS: :warning: UNTESTED
Action Items:
- {Fix required}
CC: @{names}
```

## Output Format

### Test Results Summary
```markdown
# Iron{Product} Python YYYY.MM.x RC Test Summary

**Version:** {version}
**Test Date:** {date}
**Status:** {Ready for Release / Partial Pass / Needs Fixes}

## Platform Results

| Platform | Status | Notes |
|----------|--------|-------|
| Windows | PASS/FAIL | {details} |
| Linux | PASS/FAIL | {details} |
| macOS | PASS/FAIL/UNTESTED | {details} |

## Test Results

| Test | Windows | Linux | macOS |
|------|---------|-------|-------|
| {test name} | PASS/FAIL | PASS/FAIL | PASS/FAIL |

## Issues Found
...

## Conclusion
...
```

## Example Usage

```bash
# Test IronXL Python
/rc-test-python Xl 2025.12.0.2

# Test IronPdf Python with custom release notes
/rc-test-python Pdf 2025.12.1 /path/to/release-notes.txt
```

## Behavior

- If project exists, focus on testing
- If project doesn't exist, create structure first
- Always test on both Windows and Linux (via WSL2)
- Note macOS status as untested unless user confirms
- Request user validation for visual outputs
- Only write final report after user approval

## Python API Notes

Common differences from .NET API:

| .NET | Python | Notes |
|------|--------|-------|
| `cell.Value = 30` | `cell.IntValue = 30` | Use specific type setters |
| `cell.Value = 12.5` | `cell.DoubleValue = 12.5` | Use DoubleValue for floats |
| `cell.Value` | `cell.StringValue` | Use specific type getters |
