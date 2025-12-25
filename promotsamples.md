<!-- markdownlint-disable MD013 MD033 MD041 MD024 -->

# AI-Driven Development Prompt Templates (Test-First)

Cross-platform Habit & Todo App. **TESTS ARE MANDATORY FOR EVERY CHANGE**. Use with Cursor (auto-loads `.cursor/rules/**/*.mdc`).

## Usage Rules

- Always start with `@project_constitution.md @workflow_protocol.md`
- For completion gates, also consult:
  - `@ai-dev/checklists/code_review_checklist.md`
  - `@ai-dev/checklists/security_checklist.md`
- **TESTS FIRST** - No code without accompanying tests
- Fill `[brackets]` exactly - be specific
- Follow **STOP** commands - never let AI skip steps
- Copy **ONE** template per task

## 1. Feature Planning Template

@project_constitution.md @workflow_protocol.md

### Task: [Plan "Habit List" Feature]

### Specification

[Describe high-level feature in 3 sentences]

- Core Entities: [e.g., Habit, HabitList]
- User Flows: [e.g., Create → View → Edit]
- Success Metrics: [e.g., List renders 3 habits]

### Constraint Checklist

- [ ] Aligns with Hexagonal Architecture?
- [ ] Decomposes into < 5 atomic tasks **with tests**?
- [ ] No implementation details yet?

### Request

1. critique_spec(): Identify gaps/missing edge cases.
2. decompose_atomic(): Break into 3-5 tiny tasks **with test files**.
3. prioritize_sequence(): Order for incremental builds. STOP. Wait for approval.

## 2. Feature Building Template

@project_constitution.md @workflow_protocol.md

### Task: [Build "Habit Entity"]

### Specification

[2-3 sentences of exact requirements]

- Input: [Title, Frequency, Icon]
- Output: [Validated Habit object]
- Edge Cases: [Empty title → ValidationError]

### Constraint Checklist

- [ ] Atomic? (< 3 files + **TEST FILE**)
- [ ] Domain layer only? (No UI imports)
- [ ] **Includes unit tests** for all cases?

### Request

1. critique_spec(): Flag gaps against constitution.
2. plan_execution(): Exact files **+ test file** + line estimates.
3. generate_tests(): Write **tests FIRST** with expected failures.
4. generate_code(): Write code to make tests pass.
5. self_verify(): Confirm 100% test coverage. STOP after each step.

## 3. Code Review Template

@project_constitution.md @workflow_protocol.md

### Task: [Review HabitEntity.dart]

### Code Context

[Paste code or @filename.dart]

### Specification

Review against these standards:

- Architecture compliance
- Style guide adherence
- **Test coverage** (must be 95%+)
- Performance concerns

### Constraint Checklist

- [ ] Follows Dependency Rule?
- [ ] **Has accompanying test file**?
- [ ] No magic numbers?
- [ ] Error handling **tested**?

### Request

1. systematic_audit(): Line-by-line violations + **missing tests**.
2. test_coverage(): Missing test cases list.
3. fix_proposals(): Atomic fixes **with test updates**.
4. confidence_check(): % alignment + test coverage %. Output fixes + **new test cases** as diff patches.

## 4. Bug Fixing Template

@project_constitution.md @workflow_protocol.md

### Task: [Fix "Empty Habit Title Crash"]

### Bug Description

[Exact reproduction steps]

- File: [habit_repository.dart:42]
- Error: [NullPointerException]
- Expected: [Validation error shown]

### Constraint Checklist

- [ ] Fix is atomic? (No refactors)
- [ ] **Adds repro test** that currently fails
- [ ] **Fix makes test pass**
- [ ] No behavior changes elsewhere?

### Request

1. root_cause(): Trace exact failure path.
2. repro_test(): **Write failing test FIRST** proving bug exists.
3. minimal_fix(): Single change to make test pass.
4. regression_suite(): Additional tests preventing regression.
5. deploy_safe(): Confirm no side effects + 100% coverage. Apply fix + **tests only**.

## 5. Refactoring Template

@project_constitution.md @workflow_protocol.md

### Task: [Refactor HabitRepository to Ports & Adapters]

### Specification

[Why refactor + exact goal]

- Before: [Current smell, e.g., DB calls in domain]
- After: [Clean separation]
- Scope: [1 class only]

### Constraint Checklist

- [ ] No behavior change? (**Tests prove this**)
- [ ] < 2 files touched + **test updates**
- [ ] **100% test coverage preserved**?

### Request

1. refactor_analysis(): Show before/after structure.
2. test_safety_net(): **Existing tests still pass**?
3. generate_refactor(): Code + **test updates**.
4. verify_equivalence(): **All tests pass unchanged** + new coverage.

## 6. Testing Template

@project_constitution.md @workflow_protocol.md

### Task: [Test "Habit Validation"]

### Specification

Cover these cases:

- Happy path: Valid habit creation
- Edge cases: [Empty title, invalid frequency]
- Coverage goal: **95% lines/branches**

### Constraint Checklist

- [ ] Unit tests only? (No E2E)
- [ ] Mocks for external deps?
- [ ] Follows test naming convention?
- [ ] **Tests implementation-independent**?

### Request

1. test_plan(): List all test cases needed.
2. generate_suite(): **Complete test file** with mocks.
3. coverage_report(): Expected coverage metrics.
4. mock_setup(): Required test doubles + setup code.

### Test-First Enforcement Rules

✅ **TESTS BEFORE CODE** - Always generate tests first ✅ **Repro Tests for Bugs** - Prove bug exists before fixing  
✅ **100% Coverage for New Code** - No untested lines allowed ✅ **Regression Tests** - Prevent breaking existing features ✅ **Test Names**: "should [action] when [condition]"

### Markdown Lint Compliance

✅ No trailing whitespace  
✅ No multiple blank lines  
✅ Consistent heading levels  
✅ Proper list indentation  
✅ **TESTS MANDATORY** in every template

**Save as `prompt_templates.md`** - Ready for your project root.

**Key Changes Made:**

- Added **"TESTS FIRST"** philosophy to every template
- **Bug fixes**: Repro test → Fix → Regression tests
- **Features**: Tests before code generation
- **Reviews**: Missing tests flagged as violations
- **Refactors**: Tests prove no behavior change
- Explicit coverage requirements (95-100%)
