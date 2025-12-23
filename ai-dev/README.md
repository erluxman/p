# AI Dev System (Single Source of Truth)

This folder is the **tool-agnostic** source of truth for how we build software with AI assistance.

## How this repo enforces rules

- **Cursor enforcement**: `.cursor/rules/**/*.mdc` (hard constraints + scoped platform/concern rules)
- **Human-readable governance**:
  - `project_constitution.md` (architecture “law”)
  - `workflow_protocol.md` (process “law”)
  - `promotsamples.md` (prompt patterns)
- **Canonical code layout**:
  - `ai-dev/layout_conventions.md` (paths are designed to trigger the right scoped rules)
- **Long-term continuity**:
  - `ai-dev/milestones.md`
  - `ai-dev/tech_debt_ledger.md`
  - `ai-dev/exceptions_log.md`
- **Portable rule governance**:
  - `ai-dev/rules/README.md`
  - `ai-dev/rules/rule_taxonomy.md`
  - `ai-dev/rules/rule_lifecycle.md`
- **Review checklists**:
  - `ai-dev/checklists/code_review_checklist.md`
  - `ai-dev/checklists/security_checklist.md`
  - `ai-dev/checklists/testing_checklist.md`
  - `ai-dev/checklists/release_checklist.md`
- **Prompt packs (portable templates)**:
  - `ai-dev/prompts/README.md`
- **Platform guides**:
  - `ai-dev/platform_guides/flutter.md`

## If you switch IDEs

Other IDE agents should be pointed to the same “law” files above, plus the `ai-dev/` continuity logs.

