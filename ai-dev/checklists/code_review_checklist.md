# Code Review Checklist (Human Gate)

## Architecture

- Dependency direction follows `project_constitution.md` (inward only).
- No business logic in UI/presentation.
- No infrastructure imports in domain.

## Correctness

- Clear error handling for all external calls.
- Edge cases handled (null/empty/timeout/offline).

## Testing

- New logic has tests.
- Bug fixes include a repro test that fails before the fix.
- Coverage meets project targets (see `.cursorrules`).

## Security

- No secrets, tokens, or credentials in code.
- Auth/authz changes are explicitly reviewed.
- Logs do not include PII or secrets.

## Maintainability

- Small cohesive changes (atomic).
- Naming is clear; minimal comments; no redundant comments.

