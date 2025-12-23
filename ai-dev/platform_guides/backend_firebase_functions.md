# Platform Guide: Backend (Firebase Functions)

This guide describes how Firebase Functions work should be organized and how rules apply.

## Root (canonical)

- **Use this root everywhere**: `services/firebase_functions/`
- If the real folder name differs, create a symlink so docs/rules do not change.

## Code layout (recommended)

Recommended “from day 1” layout (layer-first):

```text
services/firebase_functions/
  src/
    functions/
    core/
      domain/
      application/
    infrastructure/
  test/
```

## Cursor rule mapping

- Always-on:
  - `.cursor/rules/core/*`
- Scoped Firebase Functions rules:
  - `.cursor/rules/backend/firebase_functions/*`
