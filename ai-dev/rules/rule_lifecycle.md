# Rule Lifecycle

## Principles

- Core constraints are hard rules; exceptions require explicit approval and must be logged.
- Platform/concern rules are scoped via globs and should stay small.
- If a rule is frequently violated, improve clarity/scope rather than adding more rules.

## Adding a rule

1. Identify failure mode (what went wrong, where, and why).
2. Decide layer:
   - enforceable? → `.cursor/rules/**`
   - explanatory? → `project_constitution.md` / `workflow_protocol.md` / `ai-dev/rules/**`
3. Keep it narrow:
   - single concern per file
   - narrow globs
4. Add examples/reference links only if needed.

## Changing a rule

- Changes must preserve the overall intent: reliability + permission-to-break model.
- Avoid backwards-incompatible changes unless explicitly approved.

## Deprecating a rule

- Mark it as deprecated in the `.mdc` header description and remove after a cooling period.

## Exception process (permission-to-break)

When a hard constraint must be violated:

1. AI states: which rule, why, and alternatives.
2. Project Owner approves explicitly.
3. Record in `ai-dev/exceptions_log.md` with expiry.
