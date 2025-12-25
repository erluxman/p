# AI-Dev Directory Optimization Plan

**Purpose**: Reduce context token usage while maintaining all essential information for LLM calls.

**Date**: 2025-01-XX

---

## Files to Delete/Merge (Review First)

### 1. `checklists/release/README.md` → **DELETE**
**Current Content** (8 lines):
```
# Release Checklists (Platform-Specific)

Use these checklists **in addition to** `ai-dev/checklists/release_checklist.md`.

Pick only the platform(s) you are shipping.
```

**Action**: Merge this instruction into `checklists/release_checklist.md` (add 2 lines at top).

**Impact**: Saves 8 lines, eliminates redundant file.

---

### 2. `mobile_platform_enhancement_summary.md` → **ARCHIVE**
**Current Content**: 234 lines - Historical completion summary from 2025

**Why Archive**: 
- Historical document, not operational guidance
- Documents completed work, not ongoing rules
- Takes significant context space (234 lines)

**Action**: 
- Move to `ai-dev/archive/mobile_platform_enhancement_summary.md`
- Remove from `INDEX.md` references
- Keep for historical reference but exclude from LLM context

**Impact**: Saves 234 lines from frequent context inclusion.

---

### 3. `specs/todo_app_spec.md` → **MOVE TO EXAMPLES**
**Current Content** (6 lines, poorly formatted):
```
**Feature**: Todo Management Application **Purpose**: Allow users to create, delete, edit, and toggle completion status of todos...
[Single-line spec, hard to read]
```

**Why Move**:
- Example spec, not active project spec
- Poorly formatted (single line)
- Should be reference material, not active guidance

**Action**:
- Move to `ai-dev/examples/todo_app_spec.md`
- Format properly as reference example
- Remove from `INDEX.md` active specs section
- Only include in context when showing spec examples

**Impact**: Saves 6 lines from frequent context, better organization.

---

### 4. Continuity Logs → **CONDITIONAL INCLUSION**
**Files**: 
- `architecture_decisions_log.md` (19 lines, empty template)
- `tech_debt_ledger.md` (14 lines, empty template)
- `exceptions_log.md` (19 lines, empty template)
- `milestones.md` (19 lines, empty template)

**Current Status**: All are empty templates with "TBD" entries.

**Action**:
- Keep files (they're needed when populated)
- Add note at top: "⚠️ Template file - only include in LLM context when entries exist"
- Update `INDEX.md` to mark these as "conditional inclusion"
- Don't include in default context until they have content

**Impact**: Saves ~70 lines from default context inclusion.

---

## Files to Condense (High Priority)

### Priority 1: Large Files (>200 lines)

#### `INDEX.md` (307 lines → ~200 lines)
**Current**: Comprehensive but verbose
**Action**: 
- Remove redundant explanations
- Use tables more extensively
- Remove duplicate sections
- Keep structure, condense prose

#### `TEMPLATE_USAGE.md` (289 lines → ~150 lines)
**Current**: Verbose with many examples
**Action**:
- Cut examples in half
- Remove troubleshooting section
- Keep core usage patterns
- Use bullet points instead of paragraphs

### Priority 2: Medium Files (100-200 lines)

#### `QUICK_REFERENCE.md` (130 lines → ~70 lines)
**Action**: 
- Remove verbose explanations
- Focus on actions only
- Use compact formatting

#### `layout_conventions.md` (99 lines → ~60 lines)
**Action**:
- Keep all layout examples
- Remove verbose notes
- Use compact code blocks

### Priority 3: Small Files (<100 lines)

#### `README.md` (49 lines → ~30 lines)
**Action**: 
- Remove redundant file listings (INDEX.md covers this)
- Make more actionable
- Point to INDEX.md prominently

#### `context_management.md` (28 lines → ~20 lines)
**Action**: 
- Add quick checklist format
- Remove verbose explanations

#### `prompts/feature_spec.md` (41 lines → ~25 lines)
**Action**: 
- Remove duplicate example
- Keep template structure

---

## Files to Optimize (Medium Priority)

### Platform Guides (8 files)
**Current**: Varying lengths, some verbose
**Action**: 
- Standardize to 50-70 lines each
- Add "Quick Reference" section at top (10 lines)
- Condense explanations
- Keep structure examples

**Files**:
- `platform_guides/flutter.md`
- `platform_guides/react_native.md`
- `platform_guides/native_android.md`
- `platform_guides/native_ios.md`
- `platform_guides/react_web.md`
- `platform_guides/backend_node.md`
- `platform_guides/backend_firebase_functions.md`
- `platform_guides/backend_spring_boot.md`

### Rules Documentation
- `rules/README.md` (15 lines → ~10 lines)
- `rules/rule_lifecycle.md` (37 lines → ~25 lines)
- `rules/rule_taxonomy.md` (56 lines → ~35 lines)

### Release Checklists
- `checklists/release_checklist.md` (43 lines → ~35 lines)
- Platform-specific release checklists: Standardize format, condense to 15-20 lines each

### Prompts
- `prompts/README.md` → Make it a true index, reference TEMPLATE_USAGE.md

---

## Files Already Optimal (No Changes)

✅ **Core Checklists** (Perfect as-is):
- `checklists/code_review_checklist.md`
- `checklists/security_checklist.md`
- `checklists/testing_checklist.md`

✅ **Prompt Templates** (Well-structured):
- `prompts/plan.md`
- `prompts/refactor.md`
- `prompts/release.md`
- `prompts/review.md`
- `prompts/tdd_bugfix.md`

---

## Conditional Inclusion Strategy

### Only Include When Relevant:
1. **Platform Guides** - Only when working on that platform
2. **Platform Release Checklists** - Only when releasing that platform
3. **Continuity Logs** - Only when they have content (not empty templates)
4. **MCP Guide** - Only when using MCP
5. **Example Specs** - Only when showing spec examples

### Always Include:
- Core checklists
- Core prompt templates
- INDEX.md (condensed version)
- QUICK_REFERENCE.md (condensed version)
- README.md (condensed version)

---

## Estimated Context Savings

### Immediate Savings (Delete/Archive):
- `checklists/release/README.md`: 8 lines
- `mobile_platform_enhancement_summary.md`: 234 lines
- `specs/todo_app_spec.md`: 6 lines
- Empty continuity logs (conditional): ~70 lines
- **Subtotal**: ~318 lines

### Condensation Savings:
- `INDEX.md`: ~107 lines (307 → 200)
- `TEMPLATE_USAGE.md`: ~139 lines (289 → 150)
- `QUICK_REFERENCE.md`: ~60 lines (130 → 70)
- `layout_conventions.md`: ~39 lines (99 → 60)
- `README.md`: ~19 lines (49 → 30)
- `context_management.md`: ~8 lines (28 → 20)
- `prompts/feature_spec.md`: ~16 lines (41 → 25)
- Platform guides (8 files): ~80-120 lines total
- Rules docs: ~20 lines total
- **Subtotal**: ~488 lines

### Total Estimated Savings: ~806 lines (~30-35% reduction)

---

## Implementation Order

### Phase 1: Delete/Move (Quick Wins)
1. ✅ Delete `checklists/release/README.md` (merge into parent)
2. ✅ Archive `mobile_platform_enhancement_summary.md`
3. ✅ Move `specs/todo_app_spec.md` to examples/
4. ✅ Add conditional inclusion notes to continuity logs

### Phase 2: Condense Large Files (High Impact)
1. ✅ Condense `INDEX.md` (307 → 200 lines)
2. ✅ Condense `TEMPLATE_USAGE.md` (289 → 150 lines)
3. ✅ Condense `QUICK_REFERENCE.md` (130 → 70 lines)

### Phase 3: Condense Medium Files
1. ✅ Condense `layout_conventions.md` (99 → 60 lines)
2. ✅ Condense `README.md` (49 → 30 lines)
3. ✅ Condense `context_management.md` (28 → 20 lines)
4. ✅ Condense `prompts/feature_spec.md` (41 → 25 lines)

### Phase 4: Standardize Platform Files
1. ✅ Standardize all platform guides (50-70 lines each)
2. ✅ Standardize all release checklists (15-20 lines each)
3. ✅ Condense rules documentation

### Phase 5: Update References
1. ✅ Update `INDEX.md` to reflect new structure
2. ✅ Update `README.md` to point to condensed files
3. ✅ Remove archived files from `INDEX.md`

---

## Notes

- All changes preserve essential information
- Structure and organization maintained
- Only verbosity removed, not content
- Conditional inclusion strategy reduces default context load
- Historical documents preserved in archive/

---

**Status**: Ready for implementation

