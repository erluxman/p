# Platform Guide: Native iOS

## Root (canonical)

- **Use this root everywhere**: `apps/ios/`
- If the real folder name differs, create a symlink so docs/rules do not change.

## Code layout (recommended)

Recommended “from day 1” layout (layer-first, hexagonal):

```text
apps/ios/
  App/                      # Xcode project/workspace (or SPM package wrapper)
  Sources/
    Core/
      Domain/
      Application/
    Infrastructure/
    Presentation/
  Tests/
```

## Cursor rule mapping

- Always-on:
  - `.cursor/rules/core/*`
- Scoped Native iOS rules:
  - `.cursor/rules/mobile/native_ios/*`

