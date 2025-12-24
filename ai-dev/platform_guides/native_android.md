# Platform Guide: Native Android

This guide describes how Native Android work is organized and how rules apply.

## Root (canonical)

- **Use this root everywhere**: `apps/mobile/android/`
- If the real folder name differs, create a symlink so docs/rules do not change.

## Code layout (recommended)

This layout is aligned with `project_constitution.md` and designed to trigger the right scoped rules:

Recommended "from day 1" layout (layer-first, hexagonal):

```text
apps/mobile/android/
  app/
    src/main/
      java|kotlin/<org>/<app>/
        core/
          domain/
            entities/
            value_objects/
            repositories/      # Repository interfaces (ports)
            services/          # Domain service interfaces (ports)
          application/
            use_cases/
            dto/
            mappers/
        infrastructure/
          adapters/
            repositories/      # Repository implementations
            services/          # External service implementations
            api/               # API clients (Retrofit)
          data/
            local/             # Room database, SharedPreferences
            remote/            # Remote data sources
          config/              # Dependency injection modules
        presentation/
          screens/             # Activities, Fragments, Compose screens
          viewmodels/          # ViewModels (state management)
          ui/                  # UI components (Views, Compose)
          navigation/          # Navigation logic
      res/
        layout/
        values/
        drawable/
    src/test/                  # Unit tests
    src/androidTest/          # Instrumented tests
```

## Cursor rule mapping

- Always-on:
  - `.cursor/rules/core/*`
- Scoped Native Android rules (by concern):
  - `.cursor/rules/mobile/android/architecture.mdc`
  - `.cursor/rules/mobile/android/ui.mdc`
  - `.cursor/rules/mobile/android/performance.mdc`
  - `.cursor/rules/mobile/android/networking.mdc`
  - `.cursor/rules/mobile/android/state.mdc`
  - `.cursor/rules/mobile/android/error_handling.mdc`
  - `.cursor/rules/mobile/android/accessibility.mdc`
  - `.cursor/rules/mobile/android/testing.mdc`
  - `.cursor/rules/mobile/android/security.mdc`

## Rule intent

- **Architecture rules**: Only load when editing core/infrastructure/presentation boundaries
- **UI rules**: Only load when editing presentation layer
- **Performance rules**: Apply to all code, especially presentation
- **Networking rules**: Only load when editing infrastructure/adapters/api or data/remote
- **State rules**: Only load when editing presentation/viewmodels or state management
- **Error handling rules**: Apply to all layers
- **Accessibility rules**: Only load when editing presentation layer
- **Testing rules**: Apply to test files
- **Security rules**: Apply to all code

## Path→Rule alignment (why this layout matters)

Because the layout is layer-first, Cursor can scope rules tightly:

- `core/domain/**` triggers architecture rules (no framework imports)
- `core/application/**` triggers architecture + error handling rules
- `infrastructure/adapters/api/**` triggers networking rules
- `presentation/viewmodels/**` triggers state management rules
- `presentation/screens/**` triggers UI + accessibility rules

## Technology Stack

- **Language**: Kotlin (preferred) or Java
- **Architecture**: MVVM or Clean Architecture
- **State Management**: ViewModel + LiveData or StateFlow
- **Dependency Injection**: Hilt (preferred) or Dagger
- **Networking**: Retrofit + OkHttp
- **Database**: Room (if needed)
- **UI**: Jetpack Compose (preferred) or Views
- **Navigation**: Navigation Component
- **Testing**: JUnit, Mockito, Espresso
