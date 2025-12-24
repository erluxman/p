# Platform Guide: Native Android

## Root (canonical)

- **Use this root everywhere**: `apps/mobile/android/`
- If the real folder name differs, create a symlink so docs/rules do not change.

## Code layout (recommended)

Recommended “from day 1” layout (layer-first, hexagonal):

```text
apps/mobile/android/
  app/
    src/main/
      java|kotlin/<org>/<app>/
        core/
          domain/
          application/
        infrastructure/
        presentation/
      res/
    src/test/
    src/androidTest/
```

## Cursor rule mapping

- Always-on:
  - `.cursor/rules/core/*`
- Scoped Native Android rules:
  - `.cursor/rules/mobile/native_android/*`

## Rule intent

- Keep UI in `presentation/`
- Keep business logic in `core/`
- Keep Android/framework details in `infrastructure/` + `presentation/`
