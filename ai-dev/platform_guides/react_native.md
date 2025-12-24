# Platform Guide: React Native

This guide describes how React Native work should be organized and how rules apply.

## Root (canonical)

- **Use this root everywhere**: `apps/react_native/`
- If the real folder name differs, create a symlink so docs/rules do not change.

## Code layout (recommended)

Recommended “from day 1” layout (layer-first):

```text
apps/react_native/
  src/
    core/
      domain/
      application/
    infrastructure/
    presentation/
      screens/
      components/
      state/
      navigation/
```

## Cursor rule mapping

- Always-on:
  - `.cursor/rules/core/*`
- Scoped React Native rules:
  - `.cursor/rules/mobile/react_native/*`
