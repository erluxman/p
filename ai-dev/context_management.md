# Context Management (AI + Human)

Goal: keep AI performance and correctness high by preventing context drift and rule dilution.

## When to start a new session

- After completing a milestone or large feature.
- When instructions are repeated and the AI still forgets.
- When the AI proposes changes that violate architecture unexpectedly.

## What to paste / reference at the start of a session

- `AGENTS.md`
- `project_constitution.md`
- `workflow_protocol.md`
- Relevant `.cursor/rules/**` files (open a file in that area so scoped rules apply)
- Any relevant entries from:
  - `ai-dev/milestones.md`
  - `ai-dev/tech_debt_ledger.md`
  - `ai-dev/exceptions_log.md`

## Keep scope tight

- Work in atomic steps.
- Prefer 1–3 files per step.
- Stop when scope expands and re-plan.
