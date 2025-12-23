# Security Checklist (Human Gate)

## Secrets

- No secrets in code, commits, logs, or screenshots.
- Configuration uses environment/config mechanisms.

## Authentication / Authorization

- Auth is verified at boundaries (API endpoints / functions / deep links).
- Principle of least privilege (only required permissions).
- No weakening of auth requirements without explicit approval.

## Input validation

- All external inputs validated/sanitized at the boundary.

## Logging

- No tokens, passwords, or PII in logs.

## Dependencies

- New dependencies justified; avoid “drive-by” packages.

