# Habit & Todo App

A cross-platform Habit & Todo application built with Flutter, following Hexagonal Architecture principles.

## Platforms Supported

- Android
- iOS
- Web
- macOS
- Linux (Ubuntu)
- Windows

## Architecture

This project follows **Hexagonal Architecture** (Ports & Adapters) with strict dependency rules:

- **Domain Layer**: Pure business logic, zero external dependencies
- **Application Layer**: Use cases and orchestration
- **Infrastructure Layer**: External adapters (database, APIs, services)
- **Presentation Layer**: UI components and state management

## Directory Structure

```
lib/
├── core/
│   ├── domain/          # Business entities, repositories (interfaces), services
│   └── application/     # Use cases, DTOs, mappers
├── infrastructure/      # Adapters, data sources, config
└── presentation/        # Screens, widgets, state, navigation

test/
├── unit/                # Unit tests
├── integration/         # Integration tests
└── e2e/                 # End-to-end tests
```

## Getting Started

### Prerequisites

- Flutter SDK (latest stable)
- Dart SDK (3.0+)

### Installation

1. Install dependencies:
```bash
flutter pub get
```

2. Run the app:
```bash
flutter run
```

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage
```

## Development

This project follows strict development principles:

- **Atomic Changes**: Maximum 1-3 files per change
- **Test-Driven**: All code must have tests
- **Documentation**: All public APIs must be documented
- **Architecture Compliance**: All code must follow Hexagonal Architecture

See `project_constitution.md` and `workflow_protocol.md` for detailed guidelines.

## License

Private project - All rights reserved.

