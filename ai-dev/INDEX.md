# AI Development System - Master Index

**Purpose**: Master index of all rules, documentation, and guides for LLM discoverability.

**Last Updated**: 2025

---

## Quick Reference

### Core Governance (Always Read First)

- `project_constitution.md` - Architecture "law" (Hexagonal Architecture)
- `workflow_protocol.md` - Process "law" (Spec → Critique → Plan → Execute → Verify)
- `.cursor/rules/core/*.mdc` - Core Cursor rules (always-on)

### AI-Dev System Overview

- `ai-dev/README.md` - System overview
- `ai-dev/INDEX.md` - **This file**
- `ai-dev/QUICK_REFERENCE.md` - Fast lookup
- `ai-dev/TEMPLATE_USAGE.md` - Template usage guide

---

## 1. Cursor Rules Structure

### Core Rules (Always-On)

`.cursor/rules/core/`: `00_core.mdc`, `10_workflow.mdc`, `20_security.mdc`

### Frontend Rules

`.cursor/rules/frontend/react/`: `00_scope.mdc`, `components.mdc`, `state.mdc`, `error_handling.mdc`, `accessibility.mdc`, `testing.mdc`

### Backend Rules

| Platform | Location | Key Files |
| Node.js | `.cursor/rules/backend/node/` | `00_scope.mdc`, `api_validation.mdc`, `error_handling.mdc`, `testing.mdc` |
| Firebase Functions | `.cursor/rules/backend/firebase_functions/` | `00_scope.mdc`, `auth.mdc`, `functions_structure.mdc`, `logging.mdc` |
| Spring Boot | `.cursor/rules/backend/spring_boot/` | `00_scope.mdc`, `controllers.mdc`, `exceptions.mdc`, `testing.mdc`, `validation.mdc` |

### Mobile Rules

| Platform | Location | Key Files |
| Flutter | `.cursor/rules/mobile/flutter/` | `00_scope.mdc`, `state_riverpod.mdc`, `state_bloc.mdc`, `ui_widgets.mdc`, `navigation.mdc`, `networking.mdc`, `auth.mdc`, `animations.mdc`, `performance.mdc`, `error_handling.mdc` (fpdart), `accessibility.mdc`, `testing.mdc` (golden) |
| React Native | `.cursor/rules/mobile/react_native/` | `00_scope.mdc`, `components.mdc`, `performance.mdc`, `navigation.mdc`, `networking.mdc`, `state.mdc`, `error_handling.mdc` (fp-ts), `accessibility.mdc`, `testing.mdc`, `security.mdc` |
| Android | `.cursor/rules/mobile/android/` | `00_scope.mdc`, `architecture.mdc`, `ui.mdc`, `performance.mdc`, `networking.mdc`, `state.mdc`, `error_handling.mdc`, `accessibility.mdc`, `testing.mdc`, `security.mdc` |
| iOS | `.cursor/rules/mobile/ios/` | `00_scope.mdc`, `architecture.mdc`, `ui.mdc`, `performance.mdc`, `networking.mdc`, `state.mdc`, `error_handling.mdc`, `accessibility.mdc`, `testing.mdc`, `security.mdc` |

---

## 2. Platform Guides

`ai-dev/platform_guides/`: `flutter.md`, `react_native.md`, `native_android.md`, `native_ios.md`, `react_web.md`, `backend_node.md`, `backend_firebase_functions.md`, `backend_spring_boot.md`

**Purpose**: Code layout, rule mapping, platform-specific conventions.

**Note**: Conditional inclusion - only include when working on that platform.

---

## 3. Prompt Templates

`ai-dev/prompts/`: `README.md`, `feature_spec.md`, `plan.md`, `refactor.md`, `release.md`, `review.md`, `tdd_bugfix.md`

**Usage**: Reference in chat with `@ai-dev/prompts/filename.md`. See `TEMPLATE_USAGE.md` for details.

---

## 4. Checklists

### Core Checklists

`ai-dev/checklists/`: `code_review_checklist.md`, `security_checklist.md`, `testing_checklist.md`, `release_checklist.md`

### Platform-Specific Release Checklists

`ai-dev/checklists/release/`: `flutter.md`, `native_android.md`, `native_ios.md`, `web.md`, `backend_firebase_functions.md`, `backend_node.md`, `backend_spring_boot.md` (conditional: only include when releasing that platform)

---

## 5. Rules Governance

`ai-dev/rules/`: `README.md`, `rule_lifecycle.md`, `rule_taxonomy.md`

---

## 6. Continuity Files

⚠️ **Conditional Inclusion**: Only include in LLM context when entries exist.

`ai-dev/`: `milestones.md` (Standup format), `tech_debt_ledger.md` (TDR format), `exceptions_log.md`, `architecture_decisions_log.md`, `GOTCHAS.md` (project quirks)

---

## 7. Configuration & Conventions

`ai-dev/`: `layout_conventions.md`, `context_management.md`, `mcp_guide.md` (conditional: only when using MCP)

---

## 8. Examples & Archive

- `ai-dev/examples/` - Example specs and templates (conditional inclusion)
- `ai-dev/archive/` - Historical documents and optimization analysis (exclude from context)

---

## How to Use This Index

### For LLM Queries

- **Architecture**: `project_constitution.md`
- **Process**: `workflow_protocol.md`
- **Platform-specific**: `ai-dev/platform_guides/[platform].md`
- **Rules**: `.cursor/rules/[platform]/[concern].mdc`
- **Templates**: `ai-dev/prompts/[template].md`
- **Checklists**: `ai-dev/checklists/[checklist].md`

### For Developers

1. **New feature**: `workflow_protocol.md` → `@ai-dev/prompts/feature_spec.md`
2. **Bug fix**: `@ai-dev/prompts/tdd_bugfix.md`
3. **Code review**: `ai-dev/checklists/code_review_checklist.md`
4. **Platform work**: `ai-dev/platform_guides/[platform].md`

---

## File Discovery

Rules auto-load via glob patterns:

- `apps/mobile/flutter/lib/presentation/**` → Flutter UI rules
- `apps/backend/node/src/**` → Node.js backend rules
- `apps/web/src/**` → React web rules

Each `00_scope.mdc` lists related rules. Platform guides map paths to rules.

---

## Updates

When adding files:

1. Add to this index
2. Update relevant `00_scope.mdc` if it's a rule
3. Update platform guide if platform-specific
4. Update `ai-dev/README.md` if major addition

---

**This index ensures comprehensive discoverability of all rules, documentation, and guides.**
