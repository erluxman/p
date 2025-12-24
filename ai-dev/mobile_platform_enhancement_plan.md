# Mobile Platform Enhancement Plan

**Status**: Planning/Brainstorming Phase  
**Date**: 2025  
**Purpose**: Comprehensive evaluation and enhancement of mobile development rules, documentation, and Cursor integration

---

## Executive Summary

This document catalogs all existing files, identifies gaps in mobile development coverage (especially React Native, Android native, and iOS native), and proposes a comprehensive enhancement plan based on industry best practices.

---

## Part 1: Complete File Inventory

### 1.1 Root-Level Markdown Files

1. **`project_constitution.md`** - Architecture "law" (Hexagonal Architecture)
2. **`workflow_protocol.md`** - Process "law" (Spec → Critique → Plan → Execute → Verify)
3. **`promotsamples.md`** - Prompt patterns and templates
4. **`ENHANCEMENT_PLAN.md`** - Cursor best practices integration plan
5. **`IDE_PORTABILITY_GUIDE.md`** - IDE-agnostic guidelines
6. **`cursor_best_practices_study.md`** - Research findings
7. **`AGENTS.md`** - Agent instructions
8. **`CLAUDE.md`** - Claude-specific notes

### 1.2 AI-Dev Directory Structure

#### Core Documentation
- `ai-dev/README.md` - System overview
- `ai-dev/architecture_decisions_log.md` - ADR log
- `ai-dev/context_management.md` - Context strategies
- `ai-dev/exceptions_log.md` - Approved exceptions
- `ai-dev/layout_conventions.md` - Code layout paths
- `ai-dev/mcp_guide.md` - MCP integration guide
- `ai-dev/milestones.md` - Long-term tracking
- `ai-dev/tech_debt_ledger.md` - Technical debt tracking

#### Rules Governance
- `ai-dev/rules/README.md` - Rules overview
- `ai-dev/rules/rule_lifecycle.md` - Rule management
- `ai-dev/rules/rule_taxonomy.md` - Rule classification

#### Checklists
- `ai-dev/checklists/code_review_checklist.md` - Code review gate
- `ai-dev/checklists/security_checklist.md` - Security gate
- `ai-dev/checklists/testing_checklist.md` - Testing requirements
- `ai-dev/checklists/release_checklist.md` - Release gate
- `ai-dev/checklists/release/` - Platform-specific release checklists
  - `backend_firebase_functions.md`
  - `backend_node.md`
  - `backend_spring_boot.md`
  - `flutter.md`
  - `native_android.md`
  - `native_ios.md`
  - `web.md`
  - `README.md`

#### Prompt Templates
- `ai-dev/prompts/README.md` - Prompts overview
- `ai-dev/prompts/feature_spec.md` - Feature specification template
- `ai-dev/prompts/plan.md` - Planning template
- `ai-dev/prompts/refactor.md` - Refactoring template
- `ai-dev/prompts/release.md` - Release template
- `ai-dev/prompts/review.md` - Review template
- `ai-dev/prompts/tdd_bugfix.md` - TDD bugfix template

#### Platform Guides
- `ai-dev/platform_guides/backend_firebase_functions.md`
- `ai-dev/platform_guides/backend_node.md`
- `ai-dev/platform_guides/backend_spring_boot.md`
- `ai-dev/platform_guides/flutter.md`
- `ai-dev/platform_guides/native_android.md`
- `ai-dev/platform_guides/native_ios.md`
- `ai-dev/platform_guides/react_native.md` ⚠️ **MINIMAL**
- `ai-dev/platform_guides/react_web.md`

#### Specs
- `ai-dev/specs/todo_app_spec.md` - Example spec

### 1.3 Cursor Rules Directory Structure

#### Core Rules (Always-On)
- `.cursor/rules/core/00_core.mdc` - Core constraints
- `.cursor/rules/core/10_workflow.mdc` - Workflow enforcement
- `.cursor/rules/core/20_security.mdc` - Security constraints

#### Frontend Rules
- `.cursor/rules/frontend/react/00_scope.mdc` - React web index
- `.cursor/rules/frontend/react/accessibility.mdc`
- `.cursor/rules/frontend/react/components.mdc`
- `.cursor/rules/frontend/react/error_handling.mdc`
- `.cursor/rules/frontend/react/state.mdc`
- `.cursor/rules/frontend/react/testing.mdc`

#### Backend Rules
- `.cursor/rules/backend/firebase_functions/` - 4 files
- `.cursor/rules/backend/node/` - 4 files
- `.cursor/rules/backend/spring_boot/` - 5 files

#### Mobile Rules

**Flutter** ✅ **GOOD COVERAGE**
- `.cursor/rules/mobile/flutter/00_scope.mdc` - Index
- `.cursor/rules/mobile/flutter/animations.mdc`
- `.cursor/rules/mobile/flutter/auth.mdc`
- `.cursor/rules/mobile/flutter/navigation.mdc`
- `.cursor/rules/mobile/flutter/networking.mdc`
- `.cursor/rules/mobile/flutter/state_bloc.mdc`
- `.cursor/rules/mobile/flutter/state_riverpod.mdc`
- `.cursor/rules/mobile/flutter/ui_widgets.mdc`

**React Native** ❌ **CRITICAL GAP**
- `.cursor/rules/mobile/react_native/00_scope.mdc` - **ONLY FILE** (lists missing files!)
  - Missing: `components.mdc`
  - Missing: `performance.mdc`
  - Missing: `navigation.mdc`
  - Missing: `networking.mdc`
  - Missing: `state.mdc`
  - Missing: `error_handling.mdc`
  - Missing: `accessibility.mdc`
  - Missing: `testing.mdc`
  - Missing: `security.mdc`

**Android Native** ⚠️ **BASIC COVERAGE**
- `.cursor/rules/mobile/android/00_scope.mdc` - Index
- `.cursor/rules/mobile/android/architecture.mdc`
- `.cursor/rules/mobile/android/security.mdc`
- `.cursor/rules/mobile/android/testing.mdc`
- `.cursor/rules/mobile/android/ui.mdc`
- **Missing**: `performance.mdc`, `networking.mdc`, `state.mdc`, `error_handling.mdc`, `accessibility.mdc`

**iOS Native** ⚠️ **BASIC COVERAGE**
- `.cursor/rules/mobile/ios/00_scope.mdc` - Index
- `.cursor/rules/mobile/ios/architecture.mdc`
- `.cursor/rules/mobile/ios/security.mdc`
- `.cursor/rules/mobile/ios/testing.mdc`
- `.cursor/rules/mobile/ios/ui.mdc`
- **Missing**: `performance.mdc`, `networking.mdc`, `state.mdc`, `error_handling.mdc`, `accessibility.mdc`

---

## Part 2: Gap Analysis

### 2.1 React Native - Critical Gaps

#### Missing Cursor Rules
1. **`components.mdc`** - Component patterns, hooks usage, reusability
2. **`performance.mdc`** - FlatList optimization, memoization, re-render control
3. **`navigation.mdc`** - React Navigation structure, typed routes
4. **`networking.mdc`** - API client boundaries, error mapping, interceptors
5. **`state.mdc`** - Zustand/Redux patterns, state organization
6. **`error_handling.mdc`** - Error boundaries, try-catch patterns, Result types
7. **`accessibility.mdc`** - Screen reader support, a11y props
8. **`testing.mdc`** - Jest, React Native Testing Library patterns
9. **`security.mdc`** - Secure storage, token management, SSL pinning

#### Platform Guide Issues
- `ai-dev/platform_guides/react_native.md` is minimal (34 lines vs Flutter's 55 lines)
- Missing detailed code layout examples
- Missing state management guidance
- Missing testing strategy

### 2.2 Android Native - Moderate Gaps

#### Missing Cursor Rules
1. **`performance.mdc`** - Memory management, coroutines, background work
2. **`networking.mdc`** - Retrofit/OkHttp patterns, error handling
3. **`state.mdc`** - ViewModel, LiveData, StateFlow patterns
4. **`error_handling.mdc`** - Exception handling, Result types
5. **`accessibility.mdc`** - TalkBack support, content descriptions

#### Platform Guide Issues
- `ai-dev/platform_guides/native_android.md` is minimal (39 lines)
- Missing Kotlin-specific best practices
- Missing Jetpack Compose guidance (if applicable)
- Missing dependency injection patterns (Hilt/Dagger)

### 2.3 iOS Native - Moderate Gaps

#### Missing Cursor Rules
1. **`performance.mdc`** - Memory management, async/await, background tasks
2. **`networking.mdc`** - URLSession patterns, error handling
3. **`state.mdc`** - SwiftUI @State/@Binding, Combine, MVVM
4. **`error_handling.mdc`** - Error types, Result types, throwing functions
5. **`accessibility.mdc`** - VoiceOver support, accessibility labels

#### Platform Guide Issues
- `ai-dev/platform_guides/native_ios.md` is minimal (34 lines)
- Missing Swift-specific best practices
- Missing SwiftUI vs UIKit guidance
- Missing Combine patterns

### 2.4 Flutter - Good but Could Be Enhanced

#### Potential Enhancements
1. **`performance.mdc`** - Could be more detailed (build optimization, const constructors)
2. **`error_handling.mdc`** - Missing (should exist)
3. **`accessibility.mdc`** - Missing (should exist)
4. **`testing.mdc`** - Missing (should exist)

---

## Part 3: Best Practices Research Summary

### 3.1 React Native Best Practices

#### Architecture & Code Organization
- Functional components with hooks (no class components)
- Component reusability and composition
- Separation of concerns (business logic out of components)
- TypeScript for type safety

#### Performance
- Use `FlatList`/`SectionList` for long lists (virtualization)
- Memoization: `React.memo`, `useMemo`, `useCallback`
- Minimize JavaScript execution in UI thread
- Image optimization and caching
- Code splitting and lazy loading

#### State Management
- Zustand or Redux Toolkit (preferred)
- Keep state management in `presentation/state/`
- Avoid prop drilling (use context or state management)
- Normalize state structure

#### Navigation
- React Navigation (typed routes preferred)
- Deep linking support
- Navigation state persistence
- Screen options configuration

#### Networking
- Centralized API client
- Request/response interceptors
- Error mapping and handling
- Retry logic for network failures
- Offline-first architecture (local storage + sync)

#### Error Handling
- Error boundaries for React components
- Try-catch for async operations
- Result/Either pattern for operations
- User-friendly error messages
- Error logging and reporting

#### Accessibility
- Screen reader support (accessibilityLabel, accessibilityHint)
- Dynamic Type support
- Color contrast compliance
- Keyboard navigation
- Focus management

#### Testing
- Jest for unit tests
- React Native Testing Library for component tests
- Detox for E2E tests
- Test coverage targets (60%+ for presentation)

#### Security
- Secure storage for tokens (react-native-keychain)
- SSL pinning for production
- Code obfuscation
- No hardcoded secrets
- Token refresh logic

### 3.2 Android Native Best Practices

#### Architecture
- MVVM or Clean Architecture
- Jetpack components (ViewModel, LiveData, Room)
- Dependency injection (Hilt preferred)
- Separation of layers (domain/application/presentation)

#### Performance
- Coroutines for async work
- Background work with WorkManager
- Memory leak prevention
- Efficient list rendering (RecyclerView)
- Image loading with Glide/Coil

#### State Management
- ViewModel for UI-related data
- LiveData or StateFlow for reactive state
- SavedStateHandle for process death recovery

#### Networking
- Retrofit for REST APIs
- OkHttp interceptors
- Error handling with sealed classes/Result types
- Network security config

#### Error Handling
- Sealed classes for success/error states
- Exception handling in coroutines
- User-friendly error messages
- Crash reporting (Firebase Crashlytics)

#### Accessibility
- Content descriptions for all interactive elements
- TalkBack support
- Dynamic Type support
- Color contrast compliance

### 3.3 iOS Native Best Practices

#### Architecture
- MVVM or Clean Architecture
- SwiftUI for declarative UI (preferred) or UIKit
- Combine for reactive programming
- Dependency injection

#### Performance
- Async/await for concurrency
- Background tasks with Task/async
- Memory management (ARC)
- Efficient list rendering (LazyVStack/LazyHStack)
- Image caching

#### State Management
- SwiftUI: @State, @Binding, @ObservedObject, @StateObject
- Combine: Publishers, Subscribers
- ViewModel pattern for business logic

#### Networking
- URLSession for HTTP requests
- Codable for JSON parsing
- Error handling with Result types
- Network monitoring

#### Error Handling
- Swift Error protocol
- Result types for operations
- Do-catch for error handling
- User-friendly error messages

#### Accessibility
- VoiceOver support (accessibilityLabel, accessibilityHint)
- Dynamic Type support
- Color contrast compliance
- Accessibility traits

---

## Part 4: Proposed Cursor Rules Structure

### 4.1 React Native Rules (NEW - 9 files)

```
.cursor/rules/mobile/react_native/
├── 00_scope.mdc                    # UPDATE: Add links to all rules
├── components.mdc                   # NEW: Component patterns, hooks
├── performance.mdc                  # NEW: Optimization, memoization
├── navigation.mdc                   # NEW: React Navigation patterns
├── networking.mdc                   # NEW: API clients, error mapping
├── state.mdc                        # NEW: Zustand/Redux patterns
├── error_handling.mdc               # NEW: Error boundaries, Result types
├── accessibility.mdc                # NEW: Screen reader, a11y props
├── testing.mdc                      # NEW: Jest, Testing Library
└── security.mdc                     # NEW: Secure storage, tokens
```

### 4.2 Android Native Rules (ENHANCE - 5 new files)

```
.cursor/rules/mobile/android/
├── 00_scope.mdc                     # UPDATE: Add links to new rules
├── architecture.mdc                 # EXISTS
├── performance.mdc                  # NEW: Memory, coroutines, background
├── networking.mdc                   # NEW: Retrofit, OkHttp, error handling
├── state.mdc                        # NEW: ViewModel, LiveData, StateFlow
├── error_handling.mdc               # NEW: Sealed classes, Result types
├── accessibility.mdc                 # NEW: TalkBack, content descriptions
├── security.mdc                     # EXISTS
├── testing.mdc                      # EXISTS
└── ui.mdc                           # EXISTS
```

### 4.3 iOS Native Rules (ENHANCE - 5 new files)

```
.cursor/rules/mobile/ios/
├── 00_scope.mdc                     # UPDATE: Add links to new rules
├── architecture.mdc                 # EXISTS
├── performance.mdc                  # NEW: Memory, async/await, background
├── networking.mdc                   # NEW: URLSession, Codable, error handling
├── state.mdc                        # NEW: SwiftUI state, Combine
├── error_handling.mdc                # NEW: Error types, Result types
├── accessibility.mdc                 # NEW: VoiceOver, accessibility labels
├── security.mdc                     # EXISTS
├── testing.mdc                      # EXISTS
└── ui.mdc                           # EXISTS
```

### 4.4 Flutter Rules (ENHANCE - 3 new files)

```
.cursor/rules/mobile/flutter/
├── 00_scope.mdc                     # UPDATE: Add links to new rules
├── animations.mdc                   # EXISTS
├── auth.mdc                         # EXISTS
├── navigation.mdc                   # EXISTS
├── networking.mdc                   # EXISTS
├── state_bloc.mdc                   # EXISTS
├── state_riverpod.mdc               # EXISTS
├── ui_widgets.mdc                   # EXISTS
├── performance.mdc                  # NEW: Build optimization, const constructors
├── error_handling.mdc               # NEW: Exception handling, Result types
├── accessibility.mdc                 # NEW: Semantics, screen readers
└── testing.mdc                      # NEW: Unit, widget, integration tests
```

---

## Part 5: Cursor Templates & Shortcuts

### 5.1 Current Cursor Capabilities

Based on research:
- **Inline Edit**: `Ctrl+K` (Cmd+K on Mac) - Edit code or ask questions
- **Chat**: `Ctrl+L` (Cmd+L on Mac) - Open chat interface
- **Composer**: `Ctrl+I` (Cmd+I on Mac) - Complex code generation
- **Rules**: `.cursor/rules/**/*.mdc` - Scoped rules by path/glob
- **Memories**: Store project context and decisions

### 5.2 Template Options

#### Option A: Prompt Templates in `ai-dev/prompts/`
- ✅ **Current**: We have templates like `tdd_bugfix.md`, `feature_spec.md`
- ✅ **Usage**: Reference in chat: `@ai-dev/prompts/tdd_bugfix.md`
- ✅ **Advantage**: Already works, portable across IDEs

#### Option B: Cursor Rules with Template Sections
- Create rules that include template prompts
- Example: `.cursor/rules/core/bugfix_template.mdc` with prompt structure
- Usage: Reference rule in chat

#### Option C: Custom Snippets (VS Code compatible)
- Create `.vscode/snippets.json` with template snippets
- Cursor supports VS Code snippets
- Usage: Type snippet prefix, Tab to expand

#### Option D: Composer Templates
- Use Cursor Composer (`Ctrl+I`) with saved template prompts
- Store templates in `ai-dev/prompts/` and reference them
- Advantage: Can include file context automatically

### 5.3 Recommended Approach

**Hybrid Strategy:**
1. **Keep prompt templates** in `ai-dev/prompts/` (portable, IDE-agnostic)
2. **Enhance with Cursor rules** that reference templates
3. **Create VS Code snippets** for common patterns (optional)
4. **Document usage** in platform guides

**Example Workflow:**
```
User: "Fix this bug: [description]"
AI: References @ai-dev/prompts/tdd_bugfix.md + @project_constitution.md + @workflow_protocol.md
AI: Follows TDD workflow automatically
```

---

## Part 6: Implementation Plan

### Phase 1: React Native (HIGH PRIORITY)

**Tasks:**
1. Create 9 missing React Native cursor rules files
2. Enhance `ai-dev/platform_guides/react_native.md`
3. Update `.cursor/rules/mobile/react_native/00_scope.mdc`

**Estimated Files:** 10 files (9 new + 1 update)

### Phase 2: Android Native (MEDIUM PRIORITY)

**Tasks:**
1. Create 5 missing Android cursor rules files
2. Enhance `ai-dev/platform_guides/native_android.md`
3. Update `.cursor/rules/mobile/android/00_scope.mdc`

**Estimated Files:** 7 files (5 new + 1 update + 1 enhance)

### Phase 3: iOS Native (MEDIUM PRIORITY)

**Tasks:**
1. Create 5 missing iOS cursor rules files
2. Enhance `ai-dev/platform_guides/native_ios.md`
3. Update `.cursor/rules/mobile/ios/00_scope.mdc`

**Estimated Files:** 7 files (5 new + 1 update + 1 enhance)

### Phase 4: Flutter Enhancements (LOW PRIORITY)

**Tasks:**
1. Create 3 missing Flutter cursor rules files
2. Update `.cursor/rules/mobile/flutter/00_scope.mdc`

**Estimated Files:** 4 files (3 new + 1 update)

### Phase 5: Template & Documentation

**Tasks:**
1. Enhance prompt templates with mobile-specific examples
2. Create usage guide for templates
3. Document Cursor shortcuts and workflows

**Estimated Files:** 2-3 files

---

## Part 7: Quality Assurance

### 7.1 Rule File Standards

Each rule file should:
- Be < 500 lines (composable)
- Include concrete examples
- Use globs for scoping
- Reference related rules
- Follow the pattern of existing rules

### 7.2 Platform Guide Standards

Each platform guide should:
- Define canonical root path
- Show recommended code layout
- Map cursor rules to paths
- Include platform-specific notes
- Be 50+ lines (comprehensive)

### 7.3 Testing the Rules

After implementation:
1. Test with sample queries for each platform
2. Verify rules load correctly (check globs)
3. Ensure no conflicts between rules
4. Validate examples are accurate

---

## Part 8: Next Steps

### Immediate Actions

1. **Review this plan** - Confirm priorities and approach
2. **Approve Phase 1** - React Native rules creation
3. **Begin implementation** - Start with React Native (highest gap)

### Questions to Answer

1. **Priority order**: React Native → Android → iOS → Flutter? Or different?
2. **Template approach**: Which option (A/B/C/D) do you prefer?
3. **Rule depth**: How detailed should rules be? (Follow Flutter pattern?)
4. **Testing**: Should we create test files to validate rules work?

---

## Part 9: References

### Internal References
- `project_constitution.md` - Architecture constraints
- `workflow_protocol.md` - Process constraints
- `.cursor/rules/mobile/flutter/` - Reference implementation
- `.cursor/rules/frontend/react/` - Reference implementation

### External References
- React Native Best Practices (multiple sources)
- Android Kotlin Best Practices
- iOS Swift Best Practices
- Cursor Documentation (docs.cursor.com)

---

**Ready for review and approval before implementation.**

