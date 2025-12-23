# Platform Guide: Backend (Node.js)

This guide describes how Node.js backend work should be organized and how rules apply.

## Root (canonical)

- **Use this root everywhere**: `services/node/`
- If the real folder name differs, create a symlink so docs/rules do not change.

## Code layout (recommended)

Recommended “from day 1” layout (layer-first):

```text
services/node/
  src/
    core/
      domain/
      application/
    infrastructure/
    presentation/
  test/
```

## Cursor rule mapping

- Always-on:
  - `.cursor/rules/core/*`
- Scoped Node rules:
  - `.cursor/rules/backend/node/*`
