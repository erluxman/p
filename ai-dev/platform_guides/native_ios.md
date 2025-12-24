# Platform Guide: Native iOS

This guide describes how Native iOS work is organized and how rules apply.

## Root (canonical)

- **Use this root everywhere**: `apps/mobile/ios/`
- If the real folder name differs, create a symlink so docs/rules do not change.

## Code layout (recommended)

This layout is aligned with `project_constitution.md` and designed to trigger the right scoped rules:

Recommended "from day 1" layout (layer-first, hexagonal):

```text
apps/mobile/ios/
  App/                      # Xcode project/workspace (or SPM package wrapper)
  Sources/
    Core/
      Domain/
        entities/
        value_objects/
        repositories/      # Repository interfaces (ports)
        services/          # Domain service interfaces (ports)
      Application/
        use_cases/
        dto/
        mappers/
    Infrastructure/
      adapters/
        repositories/      # Repository implementations
        services/         # External service implementations
        api/              # API clients (URLSession)
      data/
        local/            # Core Data, UserDefaults
        remote/           # Remote data sources
      config/             # Configuration
    Presentation/
      screens/            # SwiftUI Views or UIKit ViewControllers
      viewmodels/         # ViewModels (MVVM)
      components/         # Reusable UI components
      navigation/         # Navigation logic
  Tests/
    unit/
    integration/
```

## Cursor rule mapping

- Always-on:
  - `.cursor/rules/core/*`
- Scoped Native iOS rules (by concern):
  - `.cursor/rules/mobile/ios/architecture.mdc`
  - `.cursor/rules/mobile/ios/ui.mdc`
  - `.cursor/rules/mobile/ios/performance.mdc`
  - `.cursor/rules/mobile/ios/networking.mdc`
  - `.cursor/rules/mobile/ios/state.mdc`
  - `.cursor/rules/mobile/ios/error_handling.mdc`
  - `.cursor/rules/mobile/ios/accessibility.mdc`
  - `.cursor/rules/mobile/ios/testing.mdc`
  - `.cursor/rules/mobile/ios/security.mdc`

## Rule intent

- **Architecture rules**: Only load when editing Core/Infrastructure/Presentation boundaries
- **UI rules**: Only load when editing Presentation layer
- **Performance rules**: Apply to all code, especially presentation
- **Networking rules**: Only load when editing Infrastructure/adapters/api or data/remote
- **State rules**: Only load when editing Presentation/viewmodels or state management
- **Error handling rules**: Apply to all layers
- **Accessibility rules**: Only load when editing Presentation layer
- **Testing rules**: Apply to test files
- **Security rules**: Apply to all code

## Path→Rule alignment (why this layout matters)

Because the layout is layer-first, Cursor can scope rules tightly:

- `Core/Domain/**` triggers architecture rules (no framework imports)
- `Core/Application/**` triggers architecture + error handling rules
- `Infrastructure/adapters/api/**` triggers networking rules
- `Presentation/viewmodels/**` triggers state management rules
- `Presentation/screens/**` triggers UI + accessibility rules

## Technology Stack

- **Language**: Swift (preferred) or Objective-C
- **UI Framework**: SwiftUI (preferred) or UIKit
- **Architecture**: MVVM or Clean Architecture
- **State Management**: SwiftUI @State/@Binding/@ObservedObject or Combine
- **Networking**: URLSession
- **JSON**: Codable
- **Testing**: XCTest
