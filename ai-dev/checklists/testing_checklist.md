# Testing Checklist (Human Gate)

## Scope

- Tests are required for non-trivial logic and for every bugfix.
- Prefer test-first: repro test fails → fix → regression suite.

## Unit tests

- Domain: entities/value objects/domain services covered.
- Application: use-cases covered (mock ports, verify behavior).
- Presentation: widget/component tests for non-trivial flows (as appropriate).

## Integration tests

- Verify critical integrations at boundaries:
  - repositories/adapters
  - API clients
  - database / Firestore interactions (where applicable)

## E2E / flow tests (when applicable)

- Core user flows have at least one end-to-end test (login, create/update, critical navigation).

## Test quality

- Assertions verify behavior, not implementation details.
- Covers: happy path, edge cases, and failure modes (timeouts, null/empty, invalid input).
- Deterministic: no flaky timing assumptions; stable test data.

## Coverage & reporting

- Meets or exceeds coverage targets in `.cursorrules`.
- New code is not introduced without tests unless explicitly approved (and logged as tech debt).


