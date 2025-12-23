# Platform Guide: Backend (Spring Boot)

This guide describes how Spring Boot work should be organized and how rules apply.

## Root (canonical)

- **Use this root everywhere**: `services/spring_boot/`
- If the real folder name differs, create a symlink so docs/rules do not change.

## Code layout (recommended)

Recommended “from day 1” layout (layer-first):

```text
services/spring_boot/
  src/main/java/<org>/<app>/
    core/
      domain/
      application/
    infrastructure/
    presentation/
  src/test/java/<org>/<app>/
```

## Cursor rule mapping

- Always-on:
  - `.cursor/rules/core/*`
- Scoped Spring Boot rules:
  - `.cursor/rules/backend/spring_boot/*`

