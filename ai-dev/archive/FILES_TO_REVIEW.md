# Files to Review Before Deletion/Merging

This document shows the exact content of files that will be deleted, archived, or merged.

---

## 1. Files to DELETE

### `checklists/release/README.md`
**Action**: Delete (merge into parent file)

**Current Content**:
```markdown
# Release Checklists (Platform-Specific)

Use these checklists **in addition to** `ai-dev/checklists/release_checklist.md`.

Pick only the platform(s) you are shipping.
```

**Reason**: Redundant - this instruction can be added to the parent `release_checklist.md` file.

---

## 2. Files to ARCHIVE

### `mobile_platform_enhancement_summary.md`
**Action**: Move to `ai-dev/archive/`

**Current Content**: 234 lines - Historical completion summary

**Key Sections**:
- Overview of completed mobile platform enhancements
- Statistics of rules created/updated
- File structure documentation
- Verification checklist
- Status: ✅ COMPLETED

**Reason**: 
- Historical document (completion summary from 2025)
- Not operational guidance
- Takes 234 lines of context
- Should be preserved but not in active context

**New Location**: `ai-dev/archive/mobile_platform_enhancement_summary.md`

---

## 3. Files to MOVE

### `specs/todo_app_spec.md`
**Action**: Move to `ai-dev/examples/`

**Current Content** (6 lines, poorly formatted):
```
**Feature**: Todo Management Application **Purpose**: Allow users to create, delete, edit, and toggle completion status of todos with additional fields (title, description, priority, dueDate, createdAt, updatedAt) **Behavior**: Responsive web application displaying a list of todos sorted by due date (completed todos at bottom); add, edit (via modal dialog), delete, and toggle completion functionality; todos persist in browser localStorage; architecture ready for backend API integration later; optimistic updates for better UX **Constraints**: Must follow Hexagonal Architecture (domain/application/infrastructure/presentation layers), no business logic in UI components, use Redux Toolkit for state management, use MUI (Material-UI) for components, use Either/Result pattern for use cases, follow all React conventions from .cursor/rules, no hardcoded values, all errors must be handled, comprehensive validation logic for all fields **Acceptance Criteria**: User can create todos with title (required, min 1 char, max 200 chars), description (optional, max 1000 chars), priority (low/medium/high, default medium), dueDate (optional, ISO 8601 string, must be future date if provided); edit todos via modal dialog; delete todos (with confirmation); toggle completion status; todos sorted by due date (completed at bottom); UI follows Material Design principles via MUI; application is responsive; todos persist across page refreshes; all operations use Either/Result pattern; all operations have error handling and user feedback; validation prevents invalid data entry; todos have UUID, createdAt, and updatedAt fields

Shall have unit and ui tests

Shall have integration test in browser
```

**Reason**: 
- Example spec, not active project spec
- Poorly formatted (single line, hard to read)
- Should be reference material, not active guidance

**New Location**: `ai-dev/examples/todo_app_spec.md` (will be formatted properly)

---

## 4. Files to MARK AS CONDITIONAL

### Continuity Logs (Empty Templates)

These files are currently empty templates. They should only be included in LLM context when they have actual content.

#### `architecture_decisions_log.md` (19 lines)
**Current**: Empty template with "TBD"
**Action**: Add note: "⚠️ Template - only include when entries exist"

#### `tech_debt_ledger.md` (14 lines)
**Current**: Empty template with "TBD"
**Action**: Add note: "⚠️ Template - only include when entries exist"

#### `exceptions_log.md` (19 lines)
**Current**: Empty template with "TBD"
**Action**: Add note: "⚠️ Template - only include when entries exist"

#### `milestones.md` (19 lines)
**Current**: Empty template with "TBD"
**Action**: Add note: "⚠️ Template - only include when entries exist"

**Reason**: 
- All are empty templates
- Should not consume context until populated
- Will be updated when actual entries are added

---

## 5. Files to MERGE

### `checklists/release/README.md` → `checklists/release_checklist.md`

**What will be merged**:
The instruction from `checklists/release/README.md`:
```
Use these checklists **in addition to** `ai-dev/checklists/release_checklist.md`.

Pick only the platform(s) you are shipping.
```

**Will be added to** `checklists/release_checklist.md` at the top, after the title.

---

## Summary

| File | Action | Reason | Lines Saved |
|------|--------|--------|-------------|
| `checklists/release/README.md` | Delete | Redundant instruction | 8 |
| `mobile_platform_enhancement_summary.md` | Archive | Historical doc | 234 |
| `specs/todo_app_spec.md` | Move to examples | Example spec | 6 |
| Continuity logs (4 files) | Conditional inclusion | Empty templates | ~70 |

**Total immediate savings**: ~318 lines

---

## Next Steps

1. **Review** these files to confirm deletion/archive decisions
2. **Approve** the optimization plan
3. **Execute** Phase 1 (delete/move operations)
4. **Proceed** with Phase 2 (condensation)

---

**Ready to proceed?** See `OPTIMIZATION_PLAN.md` for full implementation details.

