# Release Checklist: Backend (Firebase Functions)

## Build & smoke

- Build/typecheck succeeds.
- Unit/integration tests pass.

## Deployment safety

- Function triggers and permissions reviewed.
- Input validation present at boundaries.
- Logging reviewed (no tokens/PII).

## Rollout

- Plan for safe rollout (staged if possible).
- Rollback plan documented for risky changes.


