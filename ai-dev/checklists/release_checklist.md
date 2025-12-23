# Release Checklist (Pre-Ship Gate)

Use this before publishing to App Store / Play Store / web production or deploying backend services.

## Change control

- Version/tag planned (or release identifier recorded).
- Release notes drafted (user-facing + technical summary).
- Any approved exceptions are reviewed and still acceptable:
  - `ai-dev/exceptions_log.md`
  - `ai-dev/tech_debt_ledger.md`

## Quality gates

- All tests pass (unit + integration + e2e where applicable).
- No critical warnings/lints outstanding.
- Crash-free startup verified on target platforms/environments.

## Security gates

- Secrets not present in code or logs.
- Auth/authz changes reviewed explicitly.
- Logging verified: no tokens/PII in logs.

## Platform checks (as applicable)

Use the relevant platform checklist(s):

- Flutter: `ai-dev/checklists/release/flutter.md`
- Native Android: `ai-dev/checklists/release/native_android.md`
- Native iOS: `ai-dev/checklists/release/native_ios.md`
- Web: `ai-dev/checklists/release/web.md`
- Backend Node.js: `ai-dev/checklists/release/backend_node.md`
- Backend Firebase Functions: `ai-dev/checklists/release/backend_firebase_functions.md`
- Backend Spring Boot: `ai-dev/checklists/release/backend_spring_boot.md`

## Observability & rollback

- Monitoring/alerts in place for key paths.
- Rollback procedure documented and tested where feasible.


