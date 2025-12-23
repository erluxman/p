<!-- markdownlint-disable MD013 MD033 MD041 MD024 MD029 MD030  MD040 MD036 -->

# Workflow Protocol

**Purpose**: Mandatory lifecycle for every change in this project.

This protocol ensures consistency, quality, and maintainability. **No code is written outside this workflow.**

## Related governance docs (used by the workflow)

- `project_constitution.md` (architecture constraints)
- `ai-dev/checklists/code_review_checklist.md` (human review gate)
- `ai-dev/checklists/security_checklist.md` (security gate)
- `ai-dev/exceptions_log.md` (approved exceptions to hard constraints)
- `ai-dev/tech_debt_ledger.md` (record shortcuts + paydown plan)

---

## Overview

Every change follows these 5 stages:

1. **Spec** → 2. **Critique** → 3. **Plan** → 4. **Execute** → 5. **Verify**

---

## Stage 1: Spec

### Input

The Product Owner (user) provides a **10-line requirement** describing:

- What needs to be built
- Why it's needed
- Expected behavior

### Format

```
**Feature**: [Name]
**Purpose**: [Why]
**Behavior**: [What it does]
**Constraints**: [Any limitations]
**Acceptance Criteria**: [How to verify]
```

### Example

```
**Feature**: Create Todo
**Purpose**: Allow users to add new todos to their list
**Behavior**: User enters title and description, clicks "Create", todo appears in list
**Constraints**: Title is required, max 100 chars
**Acceptance Criteria**:
- User can create a todo with valid input
- Error shown if title is empty
- Todo appears in list after creation
```

### AI Action

- **Read** the spec carefully
- **Acknowledge** receipt
- **Proceed** to Stage 2

---

## Stage 2: Critique

### Purpose

Validate the spec against `project_constitution.md` and identify potential issues before coding.

### Checklist

#### Architecture Compliance

- [ ] Does this follow Hexagonal Architecture?
- [ ] Are dependencies pointing inward?
- [ ] Is business logic separated from UI?

#### Scope Validation

- [ ] Is the scope atomic (1-3 files max)?
- [ ] Can this be broken down further?
- [ ] Are there dependencies on unimplemented features?

#### Technical Feasibility

- [ ] Are all required technologies available?
- [ ] Are there any platform-specific constraints?
- [ ] Is the approach maintainable?

#### Missing Information

- [ ] Are all inputs/outputs defined?
- [ ] Are error cases covered?
- [ ] Are edge cases considered?

### Output

AI provides:

1. **Validation**: ✅ Spec is valid OR ❌ Issues found
2. **Issues**: List of concerns (if any)
3. **Questions**: Clarifying questions (if any)
4. **Recommendations**: Suggestions for improvement

### Example Critique

```
✅ Spec is valid and follows architecture.

**Issues:**
- Need to clarify: Should todos be user-specific or global?
- Missing: What happens if network fails during creation?

**Recommendations:**
- Consider adding a "priority" field for future sorting
- Suggest using optimistic UI updates for better UX
```

### Decision Point

- **If valid**: Proceed to Stage 3
- **If issues**: User addresses concerns, return to Stage 1 or 2

---

## Stage 3: Plan

### Purpose

List **exact files** to create/edit before writing any code.

### Format

#### Files to Create

```
1. core/domain/entities/todo_entity.dart
   - Purpose: Define Todo entity
   - Dependencies: None (domain layer)

2. core/domain/repositories/todo_repository.dart
   - Purpose: Define repository interface (port)
   - Dependencies: todo_entity.dart

3. core/application/use_cases/create_todo_use_case.dart
   - Purpose: Implement create todo logic
   - Dependencies: todo_repository.dart, todo_entity.dart
```

#### Files to Edit

```
1. infrastructure/adapters/repositories/todo_repository_impl.dart
   - Changes: Implement create method
   - Dependencies: todo_repository.dart (interface)
```

#### Files to Test

```
1. tests/unit/domain/entities/todo_entity_test.dart
2. tests/unit/application/use_cases/create_todo_use_case_test.dart
3. tests/integration/infrastructure/repositories/todo_repository_impl_test.dart
```

### Dependency Graph

```
todo_entity.dart (domain)
    ↑
todo_repository.dart (domain interface)
    ↑
create_todo_use_case.dart (application)
    ↑
todo_repository_impl.dart (infrastructure)
```

### AI Action

- **List** all files explicitly
- **Show** dependency relationships
- **Confirm** with user before proceeding

### User Approval

- User must **approve** the plan
- User can **modify** the plan
- Once approved, proceed to Stage 4

---

## Stage 4: Execute

### Purpose

Write code according to the approved plan.

### Rules

#### Order of Execution

1. **Domain** first (entities, value objects, interfaces)
2. **Application** second (use cases, mappers)
3. **Infrastructure** third (implementations, adapters)
4. **Presentation** last (UI, state management)

#### Code Quality

- ✅ Follows `project_constitution.md`
- ✅ Follows `.cursorrules`
- ✅ Minimal comments (only for non-obvious/tricky code)
- ✅ Handles errors
- ✅ No hardcoded values

#### Atomic Changes

- **Maximum**: 1-3 files per execution
- **If more files needed**: Break into multiple executions
- **Each execution**: Must be testable in isolation

### AI Action

- **Write** code file by file
- **Explain** key decisions
- **Flag** any deviations from plan
- **Complete** all files in the plan

### Output

```
✅ Created: core/domain/entities/todo_entity.dart
✅ Created: core/domain/repositories/todo_repository.dart
✅ Created: core/application/use_cases/create_todo_use_case.dart
✅ Updated: infrastructure/adapters/repositories/todo_repository_impl.dart
```

---

## Stage 5: Verify

### Purpose

Prove the implementation works through tests.

### Test Requirements

#### Unit Tests

- **Domain**: Test entities, value objects, domain logic
- **Application**: Test use cases with mocked repositories
- **Infrastructure**: Test adapters with mocked external services

#### Integration Tests

- **Infrastructure**: Test real database/API interactions
- **End-to-End**: Test full user flows (if applicable)

### Test Format

#### Example Test

```dart
// tests/unit/application/use_cases/create_todo_use_case_test.dart

void main() {
  group('CreateTodoUseCase', () {
    test('should create todo with valid input', () async {
      // Arrange
      final repository = MockTodoRepository();
      final useCase = CreateTodoUseCase(repository);

      // Act
      final result = await useCase.execute(
        title: 'Test Todo',
        description: 'Test Description',
      );

      // Assert
      expect(result.isSuccess, true);
      verify(repository.save(any)).called(1);
    });

    test('should fail when title is empty', () async {
      // Arrange
      final useCase = CreateTodoUseCase(MockTodoRepository());

      // Act
      final result = await useCase.execute(title: '');

      // Assert
      expect(result.isFailure, true);
      expect(result.error, 'Title cannot be empty');
    });
  });
}
```

### AI Action

- **Generate** tests for all new code
- **Run** tests (if possible)
- **Report** test results
- **Fix** any failing tests

### Verification Checklist

- [ ] All tests pass
- [ ] Code coverage meets requirements (see `.cursorrules`)
- [ ] No linter errors
- [ ] Code follows architecture
- [ ] Documentation is complete

### Output

```
✅ Tests written: 3 unit tests, 1 integration test
✅ All tests passing: 4/4
✅ Code coverage: 95%
✅ No linter errors
✅ Implementation verified
```

---

## Exception Handling

### If Spec is Unclear

- **Stop** at Stage 1 or 2
- **Ask** clarifying questions
- **Wait** for user response
- **Resume** workflow

### If Plan Needs Changes

- **Stop** at Stage 3
- **Revise** plan with user
- **Re-approve** plan
- **Resume** at Stage 4

### If Tests Fail

- **Stop** at Stage 5
- **Fix** implementation
- **Re-run** tests
- **Complete** when all pass

### If Architecture Violation Detected

- **Stop** immediately
- **Report** violation
- **Fix** before proceeding
- **Re-verify** compliance

---

## Workflow Summary

```
User provides spec
    ↓
AI critiques spec
    ↓
User approves/revises
    ↓
AI creates plan
    ↓
User approves plan
    ↓
AI writes code
    ↓
AI writes tests
    ↓
AI verifies tests pass
    ↓
✅ Complete
```

---

## Best Practices

1. **Never skip stages** - Each stage is mandatory
2. **Document decisions** - Explain why, not just what
3. **Keep atomic** - Small, verifiable changes
4. **Test first** - Write tests alongside code
5. **Verify always** - Never mark complete without verification

---

**End of Protocol**
