# Agent Instructions (Portable)

These instructions are designed to work across IDEs/tools.

## Authority model

- Treat the user as **Project Owner**.
- **Hard constraints**: do not violate without explicit approval.
- If requirements are ambiguous: **ask**. Do not guess.

## Always follow these repo “laws”

- `project_constitution.md` (architecture and constraints)
- `workflow_protocol.md` (Spec → Critique → Plan → Execute → Verify)
- `promotsamples.md` (prompt patterns)

## Continuity files (keep long-term alignment)

- `ai-dev/milestones.md`
- `ai-dev/tech_debt_ledger.md`
- `ai-dev/exceptions_log.md`

## Cursor-specific enforcement

If using Cursor, rules are enforced via `.cursor/rules/**/*.mdc` (core always-on + scoped platform/concern rules).

