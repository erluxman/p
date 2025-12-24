# Adoption Matrix (Upstream → This Repo)

This is the “why” behind what we adopt from upstream sources.

## Guiding constraints (from this repo)

- **Hard constraints** + permission-to-break model
- **Scoped rules** (platform + layer + concern) to prevent irrelevant instructions loading
- **Test-first** and atomic changes
- **Single AI agent + human review**
- **Hexagonal architecture** is the architectural law (`project_constitution.md`)

## Upstream sources

### 1) `digitalchild/cursor-best-practices`

- **Adopt**
  - **Rule precedence model** (manual vs auto-attached vs always) as conceptual guidance
  - Encouragement to keep rules composable and to use `.cursorignore`
  - “instructions/roadmap” idea → we implemented equivalents via `ai-dev/*` continuity logs
- **Map into**
  - `ai-dev/rules/rule_taxonomy.md` (rule layers & precedence)
  - `ai-dev/context_management.md` (session hygiene and scoping)
  - `.cursor/rules/core/*` (always-on core enforcement)
- **Avoid**
  - Any stack defaults that conflict with our constitution (we’re multi-platform, not Next.js-centric)

### 2) `PatrickJS/awesome-cursorrules`

- **Adopt**
  - Treat as a **pattern library**: pick only high-signal ideas per platform (Android Compose, SwiftUI/UIKit, Flutter)
  - Platform folder structures are useful inspiration when aligned with our layer-first layout
- **Map into**
  - `.cursor/rules/mobile/native_android/*` (Compose-inspired structure ideas)
  - `.cursor/rules/mobile/native_ios/*` (SwiftUI/UIKit-inspired constraints, if we add those concerns later)
  - `ai-dev/layout_conventions.md` (canonical layout)
- **Avoid**
  - Copy-pasting full `.cursorrules` prompts (too large and often not aligned with our architecture)

### 3) `sanjeed5/awesome-cursor-rules-mdc`

- **Adopt**
  - The **idea** of generating many scoped rules from structured inputs (useful if we later need per-library rule packs)
- **Map into**
  - Future: add an optional generator pipeline under `scripts/` if rule volume becomes large
- **Avoid**
  - Pulling in the generated rules wholesale (they’re library-centric and may not match our architecture)

### 4) `tmhsdigital/CursorRulesFiles`

- **Adopt**
  - The **taxonomy** of rule categories (core / frontend / backend / testing / security / devops)
  - The “template” mindset (easy starting points)
- **Map into**
  - `ai-dev/rules/*` (portable governance taxonomy)
  - `ai-dev/checklists/*` (human gates)
- **Avoid**
  - Their stack assumptions and style guides where they conflict with our multi-platform constitution

## What we already implemented (aligned with upstream)

- Scoped `.mdc` rules by platform + concern
- Always-on core workflow + security + constraints
- Portable SSOT docs + checklists + continuity logs
- Canonical symlink roots + script-driven mapping
