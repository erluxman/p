# .cursorrules Analysis

## Current Status

- **File**: `.cursorrules` (320 lines)
- **Status**: Legacy/deprecated format
- **Recommendation**: Delete or convert to thin wrapper

---

## Why Delete/Convert?

### 1. Legacy Format
- Cursor documentation marks `.cursorrules` as **deprecated**
- Modern format: `.cursor/rules/*.mdc` with conditional triggering
- Second evaluation explicitly recommends deletion

### 2. Content Duplication
The `.cursorrules` file contains:
- ✅ **Technology Stack** → Already in `ai-dev/platform_guides/`
- ✅ **Negative Constraints** → Already in `.cursor/rules/core/00_core.mdc`
- ✅ **File Creation Rules** → Could be in core rules
- ✅ **Testing Requirements** → Already in `ai-dev/checklists/testing_checklist.md`
- ✅ **Code Review Checklist** → Already in `ai-dev/checklists/code_review_checklist.md`
- ✅ **Platform Guidelines** → Already in `.cursor/rules/` by platform
- ✅ **Git Commit Messages** → Could be in core rules

### 3. Inefficiency
- **Monolithic**: 320 lines always loaded
- **No conditional triggering**: Loads everything regardless of context
- **Token waste**: Duplicates content already in modular `.mdc` files

### 4. Modern Alternative
- `.cursor/rules/core/*.mdc` - Core constraints (always-on)
- `.cursor/rules/[platform]/*.mdc` - Platform-specific (conditional)
- `.cursor/rules/[concern]/*.mdc` - Concern-specific (conditional)

---

## Recommendation

### Option 1: Delete Entirely (Recommended)
**If all content is covered in `.mdc` files:**
- Delete `.cursorrules`
- Update references in:
  - `ai-dev/INDEX.md`
  - `ai-dev/QUICK_REFERENCE.md`
  - `workflow_protocol.md`
  - `promotsamples.md`
  - Checklists

### Option 2: Thin Wrapper (If needed for compatibility)
**If Cursor still requires it for some reason:**
- Convert to 10-20 line wrapper
- References `.cursor/rules/` structure
- Points to portable files

---

## Action Plan

1. **Verify coverage**: Ensure all `.cursorrules` content is in `.mdc` files
2. **Update references**: Remove `.cursorrules` mentions from docs
3. **Delete or convert**: Based on verification
4. **Test**: Verify Cursor still works without `.cursorrules`

---

## Files That Reference .cursorrules

- `ai-dev/INDEX.md` - Line 14
- `ai-dev/QUICK_REFERENCE.md` - Line 45
- `workflow_protocol.md` - Multiple references
- `promotsamples.md` - Line 5
- `ai-dev/checklists/testing_checklist.md` - Line 33
- `ai-dev/checklists/code_review_checklist.md` - Line 18

All need updating if `.cursorrules` is deleted.

