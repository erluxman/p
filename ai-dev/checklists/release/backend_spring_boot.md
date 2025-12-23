# Release Checklist: Backend (Spring Boot)

## Build & smoke

- Build succeeds.
- Unit/integration tests pass.

## API safety

- DTOs and validation reviewed for request changes.
- Exception handling still returns safe errors (no stack traces).

## Deployment safety

- Migrations reviewed (if any) + rollback plan.
- Observability checks (logs/metrics) for critical paths.


