# Rule Taxonomy

Goal: maximize reliability by enforcing rules at multiple layers without bloating any single layer.

## Layers

### 1) Enforced rules (Cursor)

- **Location**: `.cursor/rules/**/*.mdc`
- **Purpose**: hard constraints + scoped platform/concern rules
- **Style**: short, imperative, low-ambiguity

### 2) Repo “laws” (portable)

- **Location**: repo root
- **Files**:
  - `project_constitution.md` (architecture)
  - `workflow_protocol.md` (process)
  - `promotsamples.md` (prompt interface)
- **Purpose**: stable principles + workflows the whole project follows

### 3) Operational continuity (portable)

- **Location**: `ai-dev/`
- **Files**:
  - `ai-dev/milestones.md`
  - `ai-dev/tech_debt_ledger.md`
  - `ai-dev/exceptions_log.md`
- **Purpose**: keep long-term intent and tradeoffs visible across sessions

### 4) Checklists (portable)

- **Location**: `ai-dev/checklists/`
- **Purpose**: human review gates (security, architecture, testing, UX)

## Scope axes (prevents irrelevant rules loading)

Rules should be split along multiple axes:

- **Platform**: flutter / react / react-native / node / firebase_functions / spring_boot
- **Layer**: domain / application / infrastructure / presentation
- **Concern**: state, auth, networking, animations, validation, logging, testing, accessibility

This matches your intent: when editing Flutter BLoC state, animation/auth rules should not load.

## Rule selection / precedence (practical model)

Cursor effectively considers:

- **Always-on rules** (`alwaysApply: true`) — we use this only for `.cursor/rules/core/*`
- **Scoped rules** (`globs`) — platform/layer/concern
- **Manual inclusion** (when you explicitly reference a file or rule)

Source reference: see `ai-dev/upstream/cursor-best-practices/README.md`.

