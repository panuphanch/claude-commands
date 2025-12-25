---
description: Test Iron Software product RC releases as QA Engineer
argument-hint: [product] [version] [release-notes-file]
---

# RC Testing Command

Test Iron Software product Release Candidate as a QA Engineer.

## Arguments

- `$1` - Product name (e.g., Word, Pdf, Ocr, Barcode, Xl)
- `$2` - Version (e.g., 2025.11.39-prerelease)
- `$3` - Release notes file path (optional if in standard location)

## Configuration

- **Tests Location:** `/mnt/c/IronSoftware/IronRCTests/`
- **Project Pattern:** `{Product}Tests/`
- **PAT Environment Variable:** `IRON_NUGET_PAT`
- **License Key Placeholder:** `IRONWORD_LICENSE_KEY_HERE` (replace with actual key)

### Release Notes Location
- **New project:** `/mnt/c/IronSoftware/IronRCTests/Iron{Product}-release-notes-{month}-{year}.txt`
- **Existing project:** `{Product}Tests/docs/release-notes/Iron{Product}-release-notes-{month}-{year}.txt`

### Private NuGet Feeds

Private NuGet feed URLs are not stored in this command for security reasons.

**Behavior:**
- If `nuget.config` doesn't exist, ask user for the private feed URL
- User provides: `https://pkgs.dev.azure.com/{org}/{project}/_packaging/{feed}/nuget/v3/index.json`
- Store in project's `nuget.config` with PAT credentials

### Product Example URLs (Entry Points)

| Product | Examples URL |
|---------|--------------|
| Pdf | https://ironpdf.com/examples/using-html-to-create-a-pdf/ |
| Word | https://ironsoftware.com/csharp/word/examples/create-empty-word/ |
| Xl | https://ironsoftware.com/csharp/excel/examples/read-excel/ |
| Ppt | https://ironsoftware.com/csharp/ppt/examples/create-empty-presentation/ |
| Ocr | https://ironsoftware.com/csharp/ocr/examples/simple-csharp-ocr-tesseract/ |
| Barcode | https://ironsoftware.com/csharp/barcode/examples/barcode-quickstart/ |
| Qr | https://ironsoftware.com/csharp/qr/examples/qr-quickstart/ |
| Print | https://ironsoftware.com/csharp/print/examples/print/ |
| Zip | https://ironsoftware.com/csharp/zip/examples/create-zip/ |
| WebScraper | https://ironsoftware.com/csharp/webscraper/examples/c-sharp-web-scraper/ |

**Note:** Each entry point may link to multiple API examples. Research the examples page to understand relevant APIs.

## Workflow

### Phase 0: Environment Check

1. **Check PAT environment variable:** `IRON_NUGET_PAT`
   - If not set, ask user for PAT and guide them to set it:
     ```bash
     export IRON_NUGET_PAT="your-personal-access-token"
     ```

2. **Check nuget.config exists:**
   - If not exists, ask user for private feed URL and create nuget.config
   - Format: `https://pkgs.dev.azure.com/{org}/{project}/_packaging/{feed}/nuget/v3/index.json`

3. **Check License Key in Program.cs:**
   - Look for license application line: `Iron{Product}.License.LicenseKey = "..."`
   - If not exists, add placeholder:
     ```csharp
     Iron{Product}.License.LicenseKey = "IRON{PRODUCT}_LICENSE_KEY_HERE";
     ```
   - If placeholder detected (`_LICENSE_KEY_HERE`), ask user to provide actual license key
   - Products use pattern: `IronWord.License.LicenseKey`, `IronPdf.License.LicenseKey`, etc.

### Phase 1: Project Setup

1. **Check if test project exists:** `{Product}Tests/`
2. **If not exists:**
   - Create project structure (csproj, Program.cs, Models.cs)
   - Create nuget.config with private feed
   - Create docs folders (release-notes, test-steps, test-results)
   - Move release notes file to `docs/release-notes/`
   - Add package reference: `Iron{Product}` version `$2`

3. **If exists:**
   - Verify nuget.config has correct feed
   - Verify release notes in `docs/release-notes/`
   - Update package version if needed

### Phase 2: Test Planning

1. **Read release notes** and identify test items:
   - New features
   - Enhancements
   - Bug fixes

2. **Research API usage:**
   - Fetch code examples from product examples URL
   - Understand relevant APIs for testing

3. **Create test steps documentation:**
   - Location: `docs/test-steps/IRON{PRODUCT}_YYYY_MM_TEST_STEPS.md`
   - Include: Test ID, description, steps, expected result, validation method

### Phase 3: Test Implementation

1. **Create test classes** based on release notes categories
2. **Implement tests** with:
   - TestResult tracking
   - Output file generation for visual validation
   - Console output for progress

### Phase 4: Test Execution

1. **Run tests:** `dotnet run`
2. **Capture results:**
   - Automated: Pass/fail status, metrics
   - Manual: Request user to validate output files

### Phase 5: Validation

For tests requiring visual validation:
1. List output files that need manual review
2. Ask user to confirm each output is correct
3. Capture validation results

### Phase 6: Reporting

1. **Generate test summary** in message for user feedback
2. **Wait for user approval**
3. **Write final report:** `docs/test-results/IRON{PRODUCT}_YYYY_MM_RC_TEST_SUMMARY.md`
4. **Generate Slack message** for release announcement:
   - Ask user for Action Items (who does what)
   - Ask user for CC list (who to notify)
   - Generate concise message in format below

### Slack Message Format

**Notes:**
- If user says "I will handle it" for Action Items, use `@Meee` as the tag
- Default action is "create new release package" - user will specify additional actions if needed

```
:white_check_mark: Iron{Product} {version} PASSED
- {Feature summary}
- {Bug fix summary}
Known Issue (Future Release): (if any)
- {Issue description}
Action Items:
- @Meee will create new release package (default if user handles it)
- @{person} will {action} (if user specifies other)
Full report attached
Ready for release :rocket:
CC: @{names}
```

Or if failed:
```
:x: Iron{Product} {version} FAILED
- {Failed items}
- {What needs fixing}
Action Items:
- {What dev team needs to do}
CC: @{names}
```

## Output Format

### Test Steps Document
```markdown
# Iron{Product} YYYY.MM.x Test Steps

## Version: {version}
## Test Period: {date range}

### Feature Tests

#### TEST-001: {Feature Name}
**Release Note:** {quote from release notes}
**Steps:**
1. {step}
2. {step}
**Expected Result:** {expected}
**Validation:** {automated/manual}

### Bug Fix Tests

#### TEST-002: {Bug Fix Name}
...
```

### Test Results Summary
```markdown
# Iron{Product} YYYY.MM.x RC Test Summary

**Version:** {version}
**Test Period:** {dates}
**Status:** {Ready for Release / Needs Fixes}

## Release Notes Coverage

| Item | Type | Status |
|------|------|:------:|
| {feature} | Feature | PASS/FAIL |

## Detailed Results
...

## Conclusion
...
```

## Example Usage

```bash
# Test IronWord with specific version
/rc-test Word 2025.11.39-prerelease

# Test IronPdf with custom release notes
/rc-test Pdf 2025.12.1 /path/to/release-notes.txt

# Test IronOcr
/rc-test Ocr 2025.12.2-prerelease39687
```

## Behavior

- If project exists, focus on testing
- If project doesn't exist, create structure first
- Always generate test steps before implementing tests
- Request user validation for visual outputs
- Only write final report after user approval
