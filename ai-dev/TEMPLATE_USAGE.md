# Template Usage Guide

**Purpose**: How to use prompt templates and shortcuts in Cursor for efficient development workflows.

---

## Available Templates

All templates are located in `ai-dev/prompts/`:

1. **`feature_spec.md`** - Feature specification template
2. **`plan.md`** - Planning template
3. **`refactor.md`** - Refactoring template
4. **`release.md`** - Release template
5. **`review.md`** - Review template
6. **`tdd_bugfix.md`** - TDD bugfix template

---

## How to Use Templates

### Method 1: Reference in Chat (Recommended)

In Cursor chat, reference the template:

```
@ai-dev/prompts/tdd_bugfix.md

Bug report:
- Repro steps: [steps]
- Expected: [expected]
- Actual: [actual]
```

The AI will automatically:
1. Load the template structure
2. Reference relevant rules (from `.cursor/rules/`)
3. Follow the workflow protocol
4. Apply appropriate checklists

### Method 2: Copy Template Content

1. Open `ai-dev/prompts/[template].md`
2. Copy the template structure
3. Paste into chat and fill in details

### Method 3: Use Template as Starting Point

1. Read the template to understand the structure
2. Ask the AI: "Help me create a [feature/bugfix/etc] following the [template] pattern"

---

## Cursor Shortcuts

### Inline Edit
- **Mac**: `Cmd+K`
- **Windows/Linux**: `Ctrl+K`
- **Use**: Edit code or ask questions directly in the editor

### Chat Interface
- **Mac**: `Cmd+L`
- **Windows/Linux**: `Ctrl+L`
- **Use**: Open chat for AI conversations

### Composer
- **Mac**: `Cmd+I`
- **Windows/Linux**: `Ctrl+I`
- **Use**: Complex code generation across multiple files

### Quick Questions
- **Mac**: `Alt+Enter` (or select code and right-click)
- **Use**: Ask questions about selected code

---

## Template Workflows

### Bug Fix Workflow

1. **Reference template**:
   ```
   @ai-dev/prompts/tdd_bugfix.md
   ```

2. **Provide bug details**:
   ```
   Bug report:
   - Repro steps: Click button, app crashes
   - Expected: Button should work
   - Actual: App crashes with error
   - Error/log: [error message]
   - Suspected files: [files]
   ```

3. **AI follows**:
   - TDD workflow (repro test first)
   - Relevant rules from `.cursor/rules/`
   - Testing checklist
   - Security checklist

### Feature Development Workflow

1. **Reference template**:
   ```
   @ai-dev/prompts/feature_spec.md
   ```

2. **Provide feature details**:
   ```
   Feature: [Name]
   Purpose: [Why]
   Behavior: [What]
   ```

3. **AI follows**:
   - Workflow protocol (Spec → Critique → Plan → Execute → Verify)
   - Project constitution
   - Platform-specific rules
   - Code review checklist

### Code Review Workflow

1. **Reference template**:
   ```
   @ai-dev/prompts/review.md
   ```

2. **Provide code context**:
   ```
   Review this code: [code/files]
   ```

3. **AI follows**:
   - Code review checklist
   - Security checklist
   - Testing checklist
   - Architecture compliance

---

## Custom Template Creation

To create a new template:

1. Create file in `ai-dev/prompts/[name].md`
2. Follow existing template structure:
   - Clear purpose
   - Required inputs
   - Expected outputs
   - References to relevant rules/checklists
3. Add to `ai-dev/prompts/README.md`
4. Update `ai-dev/INDEX.md`

---

## Best Practices

### 1. Always Reference Templates

Instead of:
```
Fix this bug: [description]
```

Do:
```
@ai-dev/prompts/tdd_bugfix.md
Bug: [description]
```

### 2. Combine with Rules

Templates work best when combined with rule references:
```
@ai-dev/prompts/feature_spec.md
@project_constitution.md
@workflow_protocol.md

Feature: [details]
```

### 3. Use Platform-Specific Context

For platform work, also reference platform guide:
```
@ai-dev/prompts/feature_spec.md
@ai-dev/platform_guides/flutter.md

Feature: [details]
```

---

## Template + Rules Integration

Templates automatically trigger relevant rules:

- **Feature spec** → Loads workflow rules, architecture rules
- **Bug fix** → Loads testing rules, error handling rules
- **Review** → Loads all checklists, code review rules
- **Release** → Loads release checklists, security rules

The AI will:
1. Load the template structure
2. Auto-load relevant rules based on file paths
3. Reference appropriate checklists
4. Follow workflow protocol

---

## Examples

### Example 1: Bug Fix

```
@ai-dev/prompts/tdd_bugfix.md

Bug report:
- Repro steps: User clicks "Create Todo" button
- Expected: Todo should be created
- Actual: Error "Title is required" even when title is entered
- Error/log: ValidationError: Title is required
- Suspected files: apps/mobile/flutter/lib/core/application/use_cases/create_todo_use_case.dart
```

### Example 2: Feature Development

```
@ai-dev/prompts/feature_spec.md
@ai-dev/platform_guides/flutter.md

Feature: Add todo priority
Purpose: Allow users to set priority levels (low, medium, high) for todos
Behavior: User can select priority when creating/editing todo, todos can be filtered by priority
Constraints: Must use fpdart Either pattern, must have tests
Acceptance Criteria:
- User can set priority when creating todo
- User can filter todos by priority
- Priority is displayed in todo list
```

### Example 3: Code Review

```
@ai-dev/prompts/review.md
@ai-dev/checklists/code_review_checklist.md

Review this pull request:
- Files changed: [list]
- Description: [description]
```

---

## Troubleshooting

### Template Not Loading

1. Check file path: `ai-dev/prompts/[template].md`
2. Verify file exists
3. Try full path: `@/Users/.../ai-dev/prompts/[template].md`

### Rules Not Applying

1. Check file paths match glob patterns in rules
2. Verify `00_scope.mdc` files list the rules
3. Check platform guide for rule mapping

### Checklist Not Referenced

1. Explicitly reference: `@ai-dev/checklists/[checklist].md`
2. Check checklist exists in `ai-dev/checklists/`

---

## Summary

- ✅ Templates in `ai-dev/prompts/` - Reference with `@ai-dev/prompts/[name].md`
- ✅ Shortcuts: `Cmd+K` (edit), `Cmd+L` (chat), `Cmd+I` (composer)
- ✅ Templates auto-load relevant rules based on context
- ✅ Combine templates with rule references for best results
- ✅ See `ai-dev/INDEX.md` for complete file index

---

**For complete file index, see `ai-dev/INDEX.md`**

