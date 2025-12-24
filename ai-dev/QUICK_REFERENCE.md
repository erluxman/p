# Quick Reference Guide

**Purpose**: Fast lookup for common tasks and file locations.

---

## 🚀 Common Tasks

### Starting a New Feature
1. Read: `workflow_protocol.md`
2. Use template: `@ai-dev/prompts/feature_spec.md`
3. Follow: Spec → Critique → Plan → Execute → Verify

### Fixing a Bug
1. Use template: `@ai-dev/prompts/tdd_bugfix.md`
2. Follow: Repro test → Fix → Regression tests
3. Check: `ai-dev/checklists/testing_checklist.md`

### Code Review
1. Use template: `@ai-dev/prompts/review.md`
2. Check: `ai-dev/checklists/code_review_checklist.md`
3. Check: `ai-dev/checklists/security_checklist.md`

### Platform-Specific Work

#### Flutter
- Guide: `ai-dev/platform_guides/flutter.md`
- Rules: `.cursor/rules/mobile/flutter/`
- Key: Use `fpdart` for Either, `golden_toolkit` for golden tests

#### React Native
- Guide: `ai-dev/platform_guides/react_native.md`
- Rules: `.cursor/rules/mobile/react_native/`
- Key: Use `fp-ts` for Either, Zustand/Redux Toolkit for state

#### Android Native
- Guide: `ai-dev/platform_guides/native_android.md`
- Rules: `.cursor/rules/mobile/android/`
- Key: Use ViewModel, LiveData/StateFlow, sealed classes for errors

#### iOS Native
- Guide: `ai-dev/platform_guides/native_ios.md`
- Rules: `.cursor/rules/mobile/ios/`
- Key: Use SwiftUI state, Combine, async/await, Result types

---

## 📁 File Locations

### Core Governance
- Architecture: `project_constitution.md`
- Process: `workflow_protocol.md`
- Main Rules: `.cursorrules`

### Rules by Platform
- Flutter: `.cursor/rules/mobile/flutter/`
- React Native: `.cursor/rules/mobile/react_native/`
- Android: `.cursor/rules/mobile/android/`
- iOS: `.cursor/rules/mobile/ios/`
- React Web: `.cursor/rules/frontend/react/`
- Node.js: `.cursor/rules/backend/node/`
- Firebase Functions: `.cursor/rules/backend/firebase_functions/`
- Spring Boot: `.cursor/rules/backend/spring_boot/`

### Templates
- All templates: `ai-dev/prompts/`
- Bug fix: `ai-dev/prompts/tdd_bugfix.md`
- Feature: `ai-dev/prompts/feature_spec.md`
- Review: `ai-dev/prompts/review.md`

### Checklists
- Code review: `ai-dev/checklists/code_review_checklist.md`
- Security: `ai-dev/checklists/security_checklist.md`
- Testing: `ai-dev/checklists/testing_checklist.md`
- Release: `ai-dev/checklists/release_checklist.md`

### Platform Guides
- All guides: `ai-dev/platform_guides/`

---

## 🔍 Finding Rules

### By Concern
- **Architecture**: `[platform]/architecture.mdc`
- **UI/Components**: `[platform]/ui.mdc` or `components.mdc`
- **State**: `[platform]/state.mdc` or `state_[library].mdc`
- **Networking**: `[platform]/networking.mdc`
- **Error Handling**: `[platform]/error_handling.mdc`
- **Testing**: `[platform]/testing.mdc`
- **Performance**: `[platform]/performance.mdc`
- **Accessibility**: `[platform]/accessibility.mdc`
- **Security**: `[platform]/security.mdc`

### By Platform
Check the `00_scope.mdc` file in each platform's rules directory for complete list.

---

## ⌨️ Cursor Shortcuts

- `Cmd+K` / `Ctrl+K` - Inline edit
- `Cmd+L` / `Ctrl+L` - Open chat
- `Cmd+I` / `Ctrl+I` - Composer
- `Alt+Enter` - Quick questions

---

## 📚 Full Documentation

- **Master Index**: `ai-dev/INDEX.md` - Complete file catalog
- **Template Usage**: `ai-dev/TEMPLATE_USAGE.md` - How to use templates
- **System Overview**: `ai-dev/README.md` - AI dev system overview

---

## 🎯 Rule Auto-Loading

Rules automatically load based on file paths:
- Editing `apps/mobile/flutter/lib/presentation/**` → Loads Flutter UI rules
- Editing `apps/mobile/react_native/src/state/**` → Loads React Native state rules
- Editing `apps/backend/node/src/**` → Loads Node.js backend rules

Check platform guides for path→rule mappings.

---

**For complete details, see `ai-dev/INDEX.md`**

