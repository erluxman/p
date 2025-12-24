# AI Development System - Master Index

**Purpose**: This file ensures all rules, documentation, and guides are discoverable when querying the LLM. Reference this file or its sections to ensure comprehensive context.

**Last Updated**: 2025

---

## Quick Reference

### Core Governance (Always Read First)
- `project_constitution.md` - Architecture "law" (Hexagonal Architecture)
- `workflow_protocol.md` - Process "law" (Spec → Critique → Plan → Execute → Verify)
- `.cursorrules` - Main Cursor rules file

### AI-Dev System Overview
- `ai-dev/README.md` - System overview and structure
- `ai-dev/INDEX.md` - **This file** - Master index of all resources
- `ai-dev/QUICK_REFERENCE.md` - Fast lookup for common tasks
- `ai-dev/TEMPLATE_USAGE.md` - How to use templates and shortcuts

---

## 1. Cursor Rules Structure

### Core Rules (Always-On)
Located in: `.cursor/rules/core/`
- `00_core.mdc` - Core constraints, permissions, assumptions
- `10_workflow.mdc` - Workflow enforcement
- `20_security.mdc` - Security constraints

### Frontend Rules
Located in: `.cursor/rules/frontend/react/`
- `00_scope.mdc` - React web rules index
- `components.mdc` - Component patterns
- `state.mdc` - State management
- `error_handling.mdc` - Result/Either pattern
- `accessibility.mdc` - A11y requirements
- `testing.mdc` - Testing expectations

### Backend Rules

#### Node.js
Located in: `.cursor/rules/backend/node/`
- `00_scope.mdc` - Node.js rules index
- `api_validation.mdc` - Input validation
- `error_handling.mdc` - Error mapping
- `testing.mdc` - Testing expectations

#### Firebase Functions
Located in: `.cursor/rules/backend/firebase_functions/`
- `00_scope.mdc` - Firebase Functions rules index
- `auth.mdc` - Authentication/authorization
- `functions_structure.mdc` - Structure patterns
- `logging.mdc` - Logging rules

#### Spring Boot
Located in: `.cursor/rules/backend/spring_boot/`
- `00_scope.mdc` - Spring Boot rules index
- `controllers.mdc` - Controller conventions
- `exceptions.mdc` - Exception handling
- `testing.mdc` - Testing expectations
- `validation.mdc` - Bean Validation

### Mobile Rules

#### Flutter
Located in: `.cursor/rules/mobile/flutter/`
- `00_scope.mdc` - Flutter rules index
- `state_bloc.mdc` - BLoC patterns
- `state_riverpod.mdc` - Riverpod patterns
- `ui_widgets.mdc` - Widget composition
- `navigation.mdc` - Navigation/go_router
- `networking.mdc` - API clients
- `auth.mdc` - Authentication
- `animations.mdc` - Animation guidance
- `performance.mdc` - Performance optimization
- `error_handling.mdc` - fpdart Either pattern
- `accessibility.mdc` - A11y support
- `testing.mdc` - Unit/widget/integration + golden tests

#### React Native
Located in: `.cursor/rules/mobile/react_native/`
- `00_scope.mdc` - React Native rules index
- `components.mdc` - Component patterns
- `performance.mdc` - Optimization
- `navigation.mdc` - React Navigation
- `networking.mdc` - API clients
- `state.mdc` - Zustand/Redux Toolkit
- `error_handling.mdc` - Error boundaries, fp-ts
- `accessibility.mdc` - Screen readers
- `testing.mdc` - Jest, Testing Library, Detox
- `security.mdc` - Secure storage

#### Android Native
Located in: `.cursor/rules/mobile/android/`
- `00_scope.mdc` - Android rules index
- `architecture.mdc` - Layer boundaries
- `ui.mdc` - UI boundaries
- `performance.mdc` - Coroutines, memory
- `networking.mdc` - Retrofit, OkHttp
- `state.mdc` - ViewModel, LiveData, StateFlow
- `error_handling.mdc` - Sealed classes, Result
- `accessibility.mdc` - TalkBack support
- `testing.mdc` - Testing expectations
- `security.mdc` - Security rules

#### iOS Native
Located in: `.cursor/rules/mobile/ios/`
- `00_scope.mdc` - iOS rules index
- `architecture.mdc` - Layer boundaries
- `ui.mdc` - UI boundaries
- `performance.mdc` - Async/await, memory
- `networking.mdc` - URLSession, Codable
- `state.mdc` - SwiftUI, Combine, MVVM
- `error_handling.mdc` - Error types, Result
- `accessibility.mdc` - VoiceOver support
- `testing.mdc` - Testing expectations
- `security.mdc` - Security rules

---

## 2. Platform Guides

Located in: `ai-dev/platform_guides/`

- `flutter.md` - Flutter platform guide
- `react_native.md` - React Native platform guide
- `native_android.md` - Android native guide
- `native_ios.md` - iOS native guide
- `react_web.md` - React web guide
- `backend_node.md` - Node.js backend guide
- `backend_firebase_functions.md` - Firebase Functions guide
- `backend_spring_boot.md` - Spring Boot guide

**Purpose**: Each guide describes code layout, rule mapping, and platform-specific conventions.

---

## 3. Prompt Templates

Located in: `ai-dev/prompts/`

- `README.md` - Prompts overview
- `feature_spec.md` - Feature specification template
- `plan.md` - Planning template
- `refactor.md` - Refactoring template
- `release.md` - Release template
- `review.md` - Review template
- `tdd_bugfix.md` - TDD bugfix template

**Usage**: Reference these in chat with `@ai-dev/prompts/filename.md`

---

## 4. Checklists

Located in: `ai-dev/checklists/`

### Core Checklists
- `code_review_checklist.md` - Code review gate
- `security_checklist.md` - Security gate
- `testing_checklist.md` - Testing requirements
- `release_checklist.md` - Release gate

### Platform-Specific Release Checklists
Located in: `ai-dev/checklists/release/`
- `flutter.md`
- `native_android.md`
- `native_ios.md`
- `web.md`
- `backend_firebase_functions.md`
- `backend_node.md`
- `backend_spring_boot.md`
- `README.md`

---

## 5. Rules Governance

Located in: `ai-dev/rules/`

- `README.md` - Rules overview
- `rule_lifecycle.md` - Rule management process
- `rule_taxonomy.md` - Rule classification

---

## 6. Continuity Files

Located in: `ai-dev/`

- `milestones.md` - Long-term tracking
- `tech_debt_ledger.md` - Technical debt tracking
- `exceptions_log.md` - Approved exceptions to hard constraints
- `architecture_decisions_log.md` - ADR log

---

## 7. Configuration & Conventions

Located in: `ai-dev/`

- `layout_conventions.md` - Canonical code layout paths
- `context_management.md` - Context strategies
- `mcp_guide.md` - MCP integration guide

---

## 8. Enhancement Documentation

- `ai-dev/mobile_platform_enhancement_plan.md` - Mobile enhancement planning
- `ai-dev/mobile_platform_enhancement_summary.md` - Mobile enhancement completion
- `ENHANCEMENT_PLAN.md` - Cursor best practices integration
- `IDE_PORTABILITY_GUIDE.md` - IDE-agnostic guidelines

---

## How to Use This Index

### For LLM Queries

When asking about:
- **Architecture**: Reference `project_constitution.md`
- **Process**: Reference `workflow_protocol.md`
- **Platform-specific**: Reference `ai-dev/platform_guides/[platform].md`
- **Rules**: Reference `.cursor/rules/[platform]/[concern].mdc`
- **Templates**: Reference `ai-dev/prompts/[template].md`
- **Checklists**: Reference `ai-dev/checklists/[checklist].md`

### For Developers

1. **Starting a new feature**: Read `workflow_protocol.md` → Use `ai-dev/prompts/feature_spec.md`
2. **Fixing a bug**: Use `ai-dev/prompts/tdd_bugfix.md`
3. **Code review**: Check `ai-dev/checklists/code_review_checklist.md`
4. **Platform work**: Read relevant `ai-dev/platform_guides/[platform].md`

---

## File Discovery Strategy

### For LLMs

All important files are:
1. **Indexed here** - This master index
2. **Referenced in scope files** - Each `00_scope.mdc` lists related rules
3. **Linked in platform guides** - Guides reference relevant rules
4. **Mentioned in core rules** - Core rules reference governance docs

### Path Patterns

Cursor rules use glob patterns to auto-load based on file paths:
- Editing `apps/mobile/flutter/lib/presentation/**` → Loads Flutter UI rules
- Editing `apps/backend/node/src/**` → Loads Node.js backend rules
- Editing `apps/web/src/**` → Loads React web rules

---

## Template Usage

### Current Approach

Templates are stored in `ai-dev/prompts/` and can be referenced in chat:

```
@ai-dev/prompts/tdd_bugfix.md Fix this bug: [description]
```

### Cursor Shortcuts

- `Ctrl+K` (Cmd+K) - Inline edit
- `Ctrl+L` (Cmd+L) - Open chat
- `Ctrl+I` (Cmd+I) - Composer

### Template Workflow

1. **Bug Fix**: Reference `@ai-dev/prompts/tdd_bugfix.md` in chat
2. **Feature**: Reference `@ai-dev/prompts/feature_spec.md` in chat
3. **Review**: Reference `@ai-dev/prompts/review.md` in chat

The AI will automatically follow the template structure and reference relevant rules.

---

## Verification

To ensure nothing is missed:

1. ✅ All rule files listed in their `00_scope.mdc` files
2. ✅ All platform guides reference their rules
3. ✅ All templates documented in `ai-dev/prompts/README.md`
4. ✅ All checklists listed in this index
5. ✅ Core governance files referenced in multiple places

---

## Updates

When adding new files:
1. Add to this index
2. Update relevant `00_scope.mdc` if it's a rule
3. Update platform guide if it's platform-specific
4. Update `ai-dev/README.md` if it's a major addition

---

**This index ensures comprehensive discoverability of all rules, documentation, and guides.**

