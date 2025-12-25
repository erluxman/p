# Rule Taxonomy

**Goal**: Maximize reliability by enforcing rules at multiple layers without bloating any single layer.

## Layers

### 1) Enforced Rules (Cursor)

- **Location**: `.cursor/rules/**/*.mdc`
- **Purpose**: Hard constraints + scoped platform/concern rules
- **Style**: Short, imperative, low-ambiguity

### 2) Repo "Laws" (Portable)

- **Location**: Repo root
- **Files**: `project_constitution.md` (architecture), `workflow_protocol.md` (process), `promotsamples.md` (prompt interface)
- **Purpose**: Stable principles + workflows the whole project follows

### 3) Operational Continuity (Portable)

- **Location**: `ai-dev/`
- **Files**: `milestones.md`, `tech_debt_ledger.md`, `exceptions_log.md` (conditional inclusion)
- **Purpose**: Keep long-term intent and tradeoffs visible across sessions

### 4) Checklists (Portable)

- **Location**: `ai-dev/checklists/`
- **Purpose**: Human review gates (security, architecture, testing, UX)

## Scope Axes (Prevents Irrelevant Rules Loading)

Rules should be split along multiple axes:

- **Platform**: flutter / react / react-native / node / firebase_functions / spring_boot
- **Layer**: domain / application / infrastructure / presentation
- **Concern**: state, auth, networking, animations, validation, logging, testing, accessibility

This matches your intent: when editing Flutter BLoC state, animation/auth rules should not load.

## Rule Selection / Precedence

Cursor effectively considers:

- **Always-on rules** (`alwaysApply: true`) — only for `.cursor/rules/core/*`
- **Scoped rules** (`globs`) — platform/layer/concern
- **Manual inclusion** (when you explicitly reference a file or rule)
