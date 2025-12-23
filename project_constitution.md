<!-- markdownlint-disable MD024 MD026 MD022 MD012 MD029 MD030  MD040 MD036 -->

# Project Constitution

**Version:** 1.0  
**Last Updated:** 2024  
**Status:** Active

This document is the **source of truth** for all architectural decisions, patterns, and constraints. All code must conform to these principles.

## Related governance docs (read first)

- `workflow_protocol.md` (mandatory change lifecycle)
- `ai-dev/layout_conventions.md` (canonical code layout paths to keep AI + rules aligned)
- `ai-dev/checklists/code_review_checklist.md` (human review gate)
- `ai-dev/checklists/security_checklist.md` (security review gate)

---

## 1. Architecture: Hexagonal Architecture (Ports & Adapters)

### Core Principle

The application core (business logic) must be **completely independent** of frameworks, UI libraries, databases, and external services. The core defines **ports** (interfaces), and infrastructure implements **adapters**.

### Dependency Rule (Golden Rule)

**Source code dependencies can only point INWARD.**

```
┌─────────────────────────────────────────┐
│         Infrastructure Layer            │
│  (Flutter/React Native/Web/Backends)    │
│                                         │
│  ┌───────────────────────────────────┐  │
│  │      Application Layer            │  │
│  │  (Use Cases / Application Services)│  │
│  │                                     │  │
│  │  ┌─────────────────────────────┐   │  │
│  │  │      Domain Layer           │   │  │
│  │  │  (Entities / Value Objects) │   │  │
│  │  └─────────────────────────────┘   │  │
│  └───────────────────────────────────┘  │
└─────────────────────────────────────────┘
```

**Enforcement:**

- Domain layer has **zero dependencies** on infrastructure
- Application layer depends only on Domain
- Infrastructure depends on Application and Domain (via ports/interfaces)

### Ports (Interfaces)

- **Input Ports**: Define what the core needs from the outside (e.g., `IAuthenticationService`, `ITodoRepository`)
- **Output Ports**: Define what the core provides to the outside (e.g., `ITodoUseCase`)

### Adapters (Implementations)

- **Primary Adapters**: UI, API controllers, CLI
- **Secondary Adapters**: Database, external APIs, file systems

---

## 2. Directory Structure

### Standard Structure (applies to ALL platforms)

```
<platform-root>/
├── core/
│   ├── domain/
│   │   ├── entities/          # Pure business objects (no framework code)
│   │   ├── value_objects/     # Immutable value objects
│   │   ├── repositories/      # Repository interfaces (ports)
│   │   └── services/          # Domain service interfaces (ports)
│   │
│   └── application/
│       ├── use_cases/         # Application logic (orchestrates domain)
│       ├── dto/               # Data transfer objects
│       └── mappers/           # Domain ↔ DTO mappers
│
├── infrastructure/
│   ├── adapters/
│   │   ├── repositories/      # Repository implementations
│   │   ├── services/          # External service implementations
│   │   └── api/               # API clients
│   │
│   ├── data/
│   │   ├── local/              # Local storage (SQLite, SharedPreferences, etc.)
│   │   └── remote/             # Remote data sources
│   │
│   └── config/                # Platform-specific configuration
│
└── presentation/
    ├── screens/               # UI screens/pages
    ├── widgets/               # Reusable UI components
    ├── state/                 # State management (Riverpod, BLoC, etc.)
    └── navigation/            # Navigation logic
```

### Platform-Specific Notes

- **Flutter**: Use `lib/` as root, follow above structure
- **React Native**: Use `src/` as root, follow above structure
- **React Web**: Use `src/` as root, follow above structure
- **Backends (Node/Spring Boot)**: Use `src/` as root, `presentation/` becomes `controllers/` or `routes/`

---

### 2.2 Platform-Specific Roots

Each platform has its own root directory:

```
project-root/
├── flutter_app/              # Flutter (iOS/Android/Web/Desktop)
├── react_native_app/         # React Native (iOS/Android)
├── react_web/                # React Web frontend
├── native_android/           # Native Android (Kotlin/Java)
├── native_ios/               # Native iOS (Swift)
├── backend_firebase/         # Firebase Functions
├── backend_nodejs/           # Node.js microservice
└── backend_spring/           # Spring Boot microservice
```

## 3. State Management Patterns

### Mobile (Flutter)

- **Primary**: Riverpod (for dependency injection and state)
- **Alternative**: BLoC (if complex state machines needed)
- **Rule**: State management lives in `presentation/state/`, never in widgets

### Mobile (React Native)

- **Primary**: Zustand or Redux Toolkit
- **Rule**: State management lives in `presentation/state/`, never in components

### Web (React)

- **Primary**: Zustand or Redux Toolkit
- **Rule**: State management lives in `presentation/state/`, never in components

### Backend

- **Stateless**: All backend services are stateless
- **State**: Managed via database/cache (Redis if needed)

---

## 4. Authentication Strategy

### Single Source of Truth

- **Provider**: Firebase Authentication
- **All platforms** authenticate through Firebase
- **Backends** verify tokens via Firebase Admin SDK

### Implementation Pattern

```typescript
// Port (in core/domain/services/)
interface IAuthenticationService {
  signIn(email: string, password: string): Promise<AuthResult>;
  signOut(): Promise<void>;
  getCurrentUser(): Promise<User | null>;
}

// Adapter (in infrastructure/adapters/services/)
class FirebaseAuthenticationService implements IAuthenticationService {
  // Implementation uses Firebase SDK
}
```

---

## 5. Microservices Architecture

### Backend Services

- **Firebase Functions**: Event-driven, lightweight tasks
- **Node.js**: RESTful APIs, real-time features
- **Spring Boot**: Heavy computation, complex business logic

### Communication

- **Protocol**: REST APIs (JSON)
- **Authentication**: Firebase tokens in Authorization header
- **Service Discovery**: Environment-based (can be optimized later)

### Data Consistency

- **Pattern**: Eventual consistency (optimize later if needed)
- **Shared Data**: Firebase Firestore or PostgreSQL (to be decided per service)

---

## 6. Code Organization Rules

### File Naming

- **Entities**: `todo_entity.dart` (or `.ts`, `.kt`, `.swift`)
- **Use Cases**: `create_todo_use_case.dart`
- **Repositories**: `todo_repository_impl.dart` (implementation), `todo_repository.dart` (interface)
- **Screens**: `todo_list_screen.dart`

### Import Rules

- **Never** import infrastructure into domain
- **Never** import presentation into domain or application
- **Always** use absolute imports (relative to `core/` or `infrastructure/`)

### Testing

- **Domain**: Unit tests (100% coverage target)
- **Application**: Unit tests + integration tests
- **Infrastructure**: Integration tests + E2E tests
- **Presentation**: Widget/Component tests + E2E tests

---

## 7. Technology Stack

### Frontend

- **Flutter**: Mobile (iOS/Android), Desktop (macOS/Linux/Windows), Web
- **React Native**: Mobile (iOS/Android)
- **React**: Web

### Backend

- **Firebase Functions**: Serverless functions
- **Node.js**: Express/Fastify for REST APIs
- **Spring Boot**: Java/Kotlin for complex services

### Database

- **Primary**: Firebase Firestore (for real-time, mobile-first)
- **Secondary**: PostgreSQL (for analytics, complex queries)
- **Cache**: Redis (if needed)

### Authentication

- **Firebase Authentication**: Single source of truth

---

## 8. Development Principles

### Atomic Changes

- **Maximum**: 1-3 files per change
- **Verification**: Each change must be testable in isolation
- **Commits**: One logical change per commit

### Maintainability Over Speed

- **Code Quality**: Prefer clear, well-documented code over clever optimizations
- **Refactoring**: Continuous refactoring is encouraged
- **Code Comments**: Minimal commenting policy - only comment when code does something non-obvious or tricky. Avoid redundant comments that restate what the code already clearly shows (e.g., "Creates a new instance" for constructors, "The repository for persisting todos" for a field named `_repository` of type `TodoRepository`). Let the code be self-documenting through clear naming.

### AI-First Development

- **Spec-Driven**: All code starts from a spec
- **Review**: AI critiques before implementation
- **Verification**: AI generates tests

---

## 9. Violations & Enforcement

### Red Flags

1. Business logic in UI components
2. Direct database access from presentation layer
3. Framework imports in domain layer
4. Hardcoded strings/URLs
5. Missing tests for new features
6. Redundant/repetitive comments that restate obvious code

### Resolution

- **Immediate**: Fix violations before merging
- **Documentation**: Update this constitution if patterns evolve

---

## 10. Evolution

This constitution is **living**. It can be updated, but:

- Changes must be **documented** with rationale
- Changes must be **backward compatible** where possible
- All platforms must be **updated** to reflect changes

---

**End of Constitution**
