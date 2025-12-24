# Platform Guide: React Native

This guide describes how React Native work is organized and how rules apply.

## Root (canonical)

- **Use this root everywhere**: `apps/mobile/react_native/`
- If the real folder name differs, create a symlink so docs/rules do not change.

## Code layout (recommended)

This layout is aligned with `project_constitution.md` and designed to trigger the right scoped rules:

Recommended "from day 1" layout (layer-first):

```text
apps/mobile/react_native/
  src/
    core/
      domain/
        entities/
        value_objects/
        repositories/      # Repository interfaces (ports)
        services/        # Domain service interfaces (ports)
      application/
        use_cases/
        dto/
        mappers/
    infrastructure/
      adapters/
        repositories/    # Repository implementations
        services/        # External service implementations
        api/            # API clients (axios/fetch)
      data/
        local/          # AsyncStorage, SQLite
        remote/         # Remote data sources
      config/           # Configuration
    presentation/
      screens/          # Screen components
      components/       # Reusable UI components
      state/            # State management (Zustand/Redux)
      navigation/       # Navigation configuration
      hooks/            # Custom hooks
```

## Cursor rule mapping

- Always-on:
  - `.cursor/rules/core/*`
- Scoped React Native rules (by concern):
  - `.cursor/rules/mobile/react_native/components.mdc`
  - `.cursor/rules/mobile/react_native/performance.mdc`
  - `.cursor/rules/mobile/react_native/navigation.mdc`
  - `.cursor/rules/mobile/react_native/networking.mdc`
  - `.cursor/rules/mobile/react_native/state.mdc`
  - `.cursor/rules/mobile/react_native/error_handling.mdc`
  - `.cursor/rules/mobile/react_native/accessibility.mdc`
  - `.cursor/rules/mobile/react_native/testing.mdc`
  - `.cursor/rules/mobile/react_native/security.mdc`

## Rule intent

- **Component rules**: Only load when editing presentation/components or screens
- **Performance rules**: Apply to all code, especially presentation
- **Navigation rules**: Only load when editing presentation/navigation
- **Networking rules**: Only load when editing infrastructure/adapters/api or data/remote
- **State rules**: Only load when editing presentation/state
- **Error handling rules**: Apply to all layers
- **Accessibility rules**: Only load when editing presentation layer
- **Testing rules**: Apply to test files
- **Security rules**: Apply to all code

## Path→Rule alignment (why this layout matters)

Because the layout is layer-first, Cursor can scope rules tightly:

- `core/domain/**` triggers architecture rules (no framework imports)
- `core/application/**` triggers architecture + error handling rules
- `infrastructure/adapters/api/**` triggers networking rules
- `presentation/state/**` triggers state management rules
- `presentation/components/**` triggers component + accessibility rules
- `presentation/navigation/**` triggers navigation rules

## Technology Stack

- **Language**: TypeScript (preferred) or JavaScript
- **State Management**: Zustand (preferred) or Redux Toolkit
- **Navigation**: React Navigation
- **Networking**: Axios or fetch with interceptors
- **Functional Programming**: fp-ts for Either/Result types
- **Testing**: Jest, React Native Testing Library, Detox
- **Secure Storage**: react-native-keychain
