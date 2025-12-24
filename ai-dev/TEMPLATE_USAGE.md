<!-- markdownlint-disable MD033 -->
# Template Usage Guide

**Purpose**: Use prompt templates and shortcuts efficiently.

---

## Available Templates

`ai-dev/prompts/`: `feature_spec.md`, `plan.md`, `refactor.md`, `release.md`, `review.md`, `tdd_bugfix.md`

---

## Usage Methods

### Method 1: Reference in Chat (Recommended)

```markdown
@ai-dev/prompts/tdd_bugfix.md

Bug report:
- Repro steps: [steps]
- Expected: [expected]
- Actual: [actual]
```

AI auto-loads template structure, relevant rules, and applies checklists.

### Method 2: Copy Template Content

1. Open `ai-dev/prompts/[template].md`
2. Copy structure
3. Paste into chat and fill details

### Method 3: Use as Starting Point

Ask: "Create [feature/bugfix] following [template] pattern"

---

## Cursor Shortcuts

- **Mac**: `Cmd+K` (edit), `Cmd+L` (chat), `Cmd+I` (composer), `Alt+Enter` (quick questions)
- **Windows/Linux**: `Ctrl+K`, `Ctrl+L`, `Ctrl+I`

---

## Template Workflows

### Bug Fix

1. Reference: `@ai-dev/prompts/tdd_bugfix.md`
2. Provide: Repro steps, expected, actual, error/log, suspected files
3. AI follows: TDD workflow, relevant rules, testing/security checklists

### Feature Development

1. Reference: `@ai-dev/prompts/feature_spec.md`
2. Provide: Feature name, purpose, behavior, constraints, acceptance criteria
3. AI follows: Workflow protocol, project constitution, platform rules, code review checklist

### Code Review

1. Reference: `@ai-dev/prompts/review.md`
2. Provide code context
3. AI follows: Code review, security, testing checklists, architecture compliance

---

## Best Practices

<rule>
1. Always reference templates: Use `@ai-dev/prompts/[name].md` instead of plain text
2. Combine with rules: Reference templates + `@project_constitution.md` + `@workflow_protocol.md`
3. Use platform context: For platform work, also reference `@ai-dev/platform_guides/[platform].md`
</rule>

---

## Template + Rules Integration

Templates auto-trigger relevant rules:

- **Feature spec** → Workflow rules, architecture rules
- **Bug fix** → Testing rules, error handling rules
- **Review** → All checklists, code review rules
- **Release** → Release checklists, security rules

---

## Examples

Bug Fix

```markdown
@ai-dev/prompts/tdd_bugfix.md

Bug report:
- Repro steps: User clicks "Create Todo" button
- Expected: Todo should be created
- Actual: Error "Title is required" even when title is entered
- Error/log: ValidationError: Title is required
- Suspected files: apps/mobile/flutter/lib/core/application/use_cases/create_todo_use_case.dart
```

Feature Development

```markdown
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

---

**For complete file index, see `ai-dev/INDEX.md`**
