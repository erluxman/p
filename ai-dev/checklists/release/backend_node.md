# Release Checklist: Backend (Node.js)

## Build & smoke

- Build/typecheck succeeds.
- Unit/integration tests pass.

## Config

- Environment variables documented and set for the target environment.
- No secrets committed; no secrets logged.

## Deployment safety

- Timeouts/retries reviewed for external calls.
- Rollback plan documented if the change is risky.
