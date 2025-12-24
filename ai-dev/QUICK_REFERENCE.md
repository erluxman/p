# Quick Reference Guide

**Purpose**: Fast lookup for common tasks and file locations.

---

## Common Tasks

### Starting a New Feature

1. Read: `workflow_protocol.md`
2. Use: `@ai-dev/prompts/feature_spec.md`
3. Follow: Spec → Critique → Plan → Execute → Verify

### Fixing a Bug

1. Use: `@ai-dev/prompts/tdd_bugfix.md`
2. Follow: Repro test → Fix → Regression tests
3. Check: `ai-dev/checklists/testing_checklist.md`

### Code Review

1. Use: `@ai-dev/prompts/review.md`
2. Check: `ai-dev/checklists/code_review_checklist.md`, `ai-dev/checklists/security_checklist.md`

---

## Platform-Specific Work

| Platform | Guide | Rules Location | Key Technologies |
| Flutter | `ai-dev/platform_guides/flutter.md` | `.cursor/rules/mobile/flutter/` | fpdart (Either), golden_toolkit |
| React Native | `ai-dev/platform_guides/react_native.md` | `.cursor/rules/mobile/react_native/` | fp-ts (Either), Zustand/Redux Toolkit |
| Android | `ai-dev/platform_guides/native_android.md` | `.cursor/rules/mobile/android/` | ViewModel, LiveData/StateFlow, sealed classes |
| iOS | `ai-dev/platform_guides/native_ios.md` | `.cursor/rules/mobile/ios/` | SwiftUI, Combine, async/await, Result types |
| React Web | `ai-dev/platform_guides/react_web.md` | `.cursor/rules/frontend/react/` | React 18+, TypeScript |
| Node.js | `ai-dev/platform_guides/backend_node.md` | `.cursor/rules/backend/node/` | Express/Fastify, Zod/Joi |
| Firebase Functions | `ai-dev/platform_guides/backend_firebase_functions.md` | `.cursor/rules/backend/firebase_functions/` | Functions Framework, Admin SDK |
| Spring Boot | `ai-dev/platform_guides/backend_spring_boot.md` | `.cursor/rules/backend/spring_boot/` | Spring Web, Spring Data JPA |

---

## File Locations

### Core Governance

- Architecture: `project_constitution.md`
- Process: `workflow_protocol.md`
- Core Rules: `.cursor/rules/core/*.mdc`

### Templates

`ai-dev/prompts/`: `tdd_bugfix.md`, `feature_spec.md`, `review.md`, `plan.md`, `refactor.md`, `release.md`

### Checklists

`ai-dev/checklists/`: `code_review_checklist.md`, `security_checklist.md`, `testing_checklist.md`, `release_checklist.md`

### Platform Guides

`ai-dev/platform_guides/`: All platform guides

---

## Finding Rules

### By Concern

- Architecture: `[platform]/architecture.mdc`
- UI/Components: `[platform]/ui.mdc` or `components.mdc`
- State: `[platform]/state.mdc` or `state_[library].mdc`
- Networking: `[platform]/networking.mdc`
- Error Handling: `[platform]/error_handling.mdc`
- Testing: `[platform]/testing.mdc`
- Performance: `[platform]/performance.mdc`
- Accessibility: `[platform]/accessibility.mdc`
- Security: `[platform]/security.mdc`

Check `00_scope.mdc` in each platform's rules directory for complete list.

---

## Cursor Shortcuts

- `Cmd+K` / `Ctrl+K` - Inline edit
- `Cmd+L` / `Ctrl+L` - Open chat
- `Cmd+I` / `Ctrl+I` - Composer
- `Alt+Enter` - Quick questions

---

## Rule Auto-Loading

Rules auto-load based on file paths:

- `apps/mobile/flutter/lib/presentation/**` → Flutter UI rules
- `apps/mobile/react_native/src/state/**` → React Native state rules
- `apps/backend/node/src/**` → Node.js backend rules

Check platform guides for path→rule mappings.

---

## Full Documentation

- **Master Index**: `ai-dev/INDEX.md`
- **Template Usage**: `ai-dev/TEMPLATE_USAGE.md`
- **System Overview**: `ai-dev/README.md`

---

**For complete details, see `ai-dev/INDEX.md`**
