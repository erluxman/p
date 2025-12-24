# Canonical Code Layout

**Goal**: Make file paths self-describing so the right rules load automatically (platform + layer + concern).

Aligned with `project_constitution.md` (Hexagonal Architecture) and `.cursor/rules/**` glob scoping.

---

## Top-level Layout

```text
apps/
  flutter/                 # canonical Flutter app path (use symlink if needed)
  web/                     # canonical React Web app path
  react_native/            # canonical React Native app path
  android/                 # canonical Native Android app path
  ios/                     # canonical Native iOS app path
services/
  node/                    # canonical Node backend service path
  firebase_functions/      # canonical Firebase Functions path
  spring_boot/             # canonical Spring Boot service path
ai-dev/                    # portable AI governance + checklists + logs
.cursor/rules/             # Cursor enforcement rules (scoped)
```

**Notes**: Treat these as the only roots referenced by docs/rules. If real folder differs, create symlink to canonical path. Single-platform repos can omit unused folders.

---

## Layer-First Layout (Inside Each Platform/Service)

### Flutter / React Native / React Web

```text
<platform_root>/
  lib/ or src/
    core/
      domain/              # entities/value objects/ports (no infra deps)
      application/         # use-cases, orchestration, mappers
    infrastructure/        # adapters (API clients, persistence, Firebase SDK)
    presentation/
      screens/             # pages
      widgets/             # reusable UI
      state/               # bloc/riverpod/zustand/redux
      navigation/          # routing, routers
```

### Node.js Service

```text
<service_root>/
  src/
    core/
      domain/
      application/
    infrastructure/
    presentation/          # HTTP routes/controllers
  test/
```

### Firebase Functions

```text
<service_root>/
  src/
    functions/             # entrypoints/triggers
    core/
      domain/
      application/
    infrastructure/
  test/
```

### Spring Boot

```text
<service_root>/
  src/main/java/<org>/<app>/
    core/
      domain/
      application/
    infrastructure/
    presentation/          # controllers + DTOs
  src/test/java/<org>/<app>/
```

---

## Concern Folders (Optional, for Large Modules)

Within a layer, introduce concern folders when module grows large:

- `presentation/state/auth/**` vs `presentation/state/todos/**`
- `infrastructure/networking/**` vs `infrastructure/storage/**`

Improves rule scoping and keeps AI from mixing concerns.
