# Platform Guide: React Web

This guide describes how React Web work should be organized and how rules apply.

## Root (canonical)

- **Use this root everywhere**: `apps/web/`
- If the real folder name differs, create a symlink so docs/rules do not change.

## Code layout (recommended)

Recommended “from day 1” layout (layer-first):

```text
apps/web/
  src/
    core/
      domain/
      application/
    infrastructure/
    presentation/
      components/
      state/
      routes/
```

## Cursor rule mapping

- Always-on:
  - `.cursor/rules/core/*`
- Scoped React rules:
  - `.cursor/rules/frontend/react/*`

## Rule intent

- Component rules apply only to component paths.
- State rules apply only to state paths.
- Accessibility rules apply to UI files.

