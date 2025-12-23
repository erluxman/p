# Canonical Code Layout (Best Practice)

Goal: make file paths self-describing so the right rules load automatically (platform + layer + concern).

This layout is aligned with `project_constitution.md` (Hexagonal Architecture) and with `.cursor/rules/**` glob scoping.

## Top-level layout

Prefer a stable, discoverable structure:

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

Notes:

- Treat these canonical roots as the **only** roots referenced by docs and rules.
- If the real folder has a different name (e.g., `flutter_app/`), create a symlink to the canonical path (e.g., `apps/flutter/`) using `scripts/platform_paths.json` + `scripts/apply_symlinks.py`.
- Single-platform repos can omit unused folders; the goal is consistency when you add more platforms later.

## Inside each platform/service: layer-first layout

Within each platform root, prefer **layer-first** structure so paths imply “what kind of code this is”.

### Flutter / React Native / React Web

```text
<platform_root>/
  lib/ or src/
    core/
      domain/              # entities/value objects/ports (no infra deps)
      application/         # use-cases, orchestration, mappers
    infrastructure/        # adapters (API clients, persistence, Firebase SDK, etc.)
    presentation/
      screens/             # pages
      widgets/             # reusable UI
      state/               # bloc/riverpod/zustand/redux, etc.
      navigation/          # routing, routers
```

### Node.js service

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

## Concern folders (optional, when it helps scoping)

If a module grows large, introduce **concern folders** *within a layer*:

- `presentation/state/auth/**` vs `presentation/state/todos/**`
- `infrastructure/networking/**` vs `infrastructure/storage/**`

This improves rule scoping and keeps AI from mixing concerns.


