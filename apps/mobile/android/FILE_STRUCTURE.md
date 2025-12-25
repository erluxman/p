# Native Android Todo App - Complete File Structure

## Main Source Structure

```text
apps/mobile/android/app/src/main/java/com/erluxman/productive/

├── core/
│   ├── domain/
│   │   ├── entities/
│   │   │   └── TodoEntity.kt
│   │   ├── repositories/
│   │   │   └── TodoRepository.kt
│   │   └── exceptions/
│   │       ├── ValidationException.kt
│   │       └── NotFoundException.kt
│   │
│   └── application/
│       ├── use_cases/
│       │   ├── GetTodosUseCase.kt
│       │   ├── CreateTodoUseCase.kt
│       │   ├── UpdateTodoUseCase.kt
│       │   ├── DeleteTodoUseCase.kt
│       │   └── ToggleTodoUseCase.kt
│       └── types/
│           └── AppError.kt
│
├── infrastructure/
│   ├── database/
│   │   ├── TodoDatabase.kt
│   │   ├── TodoDao.kt
│   │   ├── TodoRoomEntity.kt
│   │   ├── type_converters/
│   │   │   └── DateTypeConverter.kt
│   │   └── mappers/
│   │       └── TodoMappers.kt
│   ├── repositories/
│   │   └── TodoRepositoryImpl.kt
│   └── di/
│       ├── DatabaseModule.kt
│       ├── RepositoryModule.kt
│       └── UseCaseModule.kt
│
├── presentation/
│   ├── screens/
│   │   └── TodoListScreen.kt
│   ├── viewmodels/
│   │   └── TodoViewModel.kt
│   ├── ui/
│   │   ├── TodoItem.kt
│   │   ├── CreateTodoDialog.kt
│   │   ├── EditTodoDialog.kt
│   │   ├── EmptyState.kt
│   │   └── ErrorMessage.kt
│   ├── navigation/
│   │   └── Navigation.kt
│   └── state/
│       └── TodoUiState.kt
│
└── ProductiveApplication.kt
```

## Test Structure

```text
apps/mobile/android/app/src/

├── test/                    # Unit tests (JVM - no Android dependencies)
│   └── java/com/erluxman/productive/
│       ├── core/
│       │   ├── domain/
│       │   │   ├── entities/
│       │   │   │   └── TodoEntityTest.kt
│       │   │   ├── repositories/
│       │   │   │   └── TodoRepositoryTest.kt
│       │   │   └── exceptions/
│       │   │       ├── ValidationExceptionTest.kt
│       │   │       └── NotFoundExceptionTest.kt
│       │   └── application/
│       │       ├── use_cases/
│       │       │   ├── GetTodosUseCaseTest.kt
│       │       │   ├── CreateTodoUseCaseTest.kt
│       │       │   ├── UpdateTodoUseCaseTest.kt
│       │       │   ├── DeleteTodoUseCaseTest.kt
│       │       │   └── ToggleTodoUseCaseTest.kt
│       │       └── types/
│       │           └── AppErrorTest.kt
│       ├── infrastructure/
│       │   ├── repositories/
│       │   │   └── TodoRepositoryImplTest.kt
│       │   └── database/
│       │       ├── mappers/
│       │       │   └── TodoMappersTest.kt
│       │       └── type_converters/
│       │           └── DateTypeConverterTest.kt
│       └── test_utils/
│           ├── TestFixtures.kt
│           ├── MockHelpers.kt
│           └── TestCoroutineRule.kt
│
└── androidTest/             # Instrumented tests (device/emulator)
    └── java/com/erluxman/productive/
        ├── presentation/
        │   ├── screens/
        │   │   └── TodoListScreenTest.kt
        │   ├── viewmodels/
        │   │   └── TodoViewModelTest.kt
        │   └── ui/
        │       ├── TodoItemTest.kt
        │       ├── CreateTodoDialogTest.kt
        │       ├── EditTodoDialogTest.kt
        │       ├── EmptyStateTest.kt
        │       ├── ErrorMessageTest.kt
        │       └── screenshot/          # Paparazzi screenshot tests
        │           ├── TodoItemScreenshotTest.kt
        │           ├── TodoListScreenScreenshotTest.kt
        │           ├── CreateTodoDialogScreenshotTest.kt
        │           ├── EditTodoDialogScreenshotTest.kt
        │           └── EmptyStateScreenshotTest.kt
        ├── infrastructure/
        │   ├── database/
        │   │   ├── TodoDatabaseTest.kt
        │   │   └── TodoDaoTest.kt
        │   └── repositories/
        │       └── TodoRepositoryImplIntegrationTest.kt
        └── integration/
            └── TodoFlowIntegrationTest.kt
```

## Resource Files

```text
apps/mobile/android/app/src/main/res/

├── values/
│   ├── strings.xml          # String resources
│   ├── colors.xml           # Color resources
│   └── themes.xml           # Theme definitions
│
└── xml/
    ├── backup_rules.xml
    └── data_extraction_rules.xml
```

## Key Files Description

### Core Domain Layer

#### Entities

- **`TodoEntity.kt`**: Pure business entity (id, title, isCompleted, createdAt)
  - No Android dependencies
  - Immutable data class

#### Repositories (Ports)

- **`TodoRepository.kt`**: Repository interface (port)
  - Returns `Result<T>` (Kotlin's built-in) or `Either<AppError, T>` (Arrow-kt)
  - Defines CRUD operations

#### Exceptions

- **`ValidationException.kt`**: Domain validation errors
- **`NotFoundException.kt`**: Resource not found errors

### Core Application Layer

#### Use Cases

- **`GetTodosUseCase.kt`**: Fetch all todos
- **`CreateTodoUseCase.kt`**: Create new todo with validation
- **`UpdateTodoUseCase.kt`**: Update existing todo
- **`DeleteTodoUseCase.kt`**: Delete todo
- **`ToggleTodoUseCase.kt`**: Toggle completion status

All use cases:

- Return `Result<T>` (Kotlin's built-in) or `Either<AppError, T>` (Arrow-kt)
- Contain business logic and validation
- No Android dependencies

#### Types

- **`AppError.kt`**: Sealed class hierarchy for error types (used with Either)

  ```kotlin
  sealed class AppError {
      data class ValidationError(val message: String) : AppError()
      data class NetworkError(val message: String) : AppError()
      data class RepositoryError(val message: String) : AppError()
      data class NotFoundError(val message: String) : AppError()
      data class UnknownError(val message: String) : AppError()
  }
  ```

**Error Handling Options:**

1. **Kotlin's Built-in `Result<T>`** (from `kotlin.Result`)

   ```kotlin
   // Usage in use cases
   suspend fun getTodos(): Result<List<TodoEntity>> {
       return try {
           val todos = repository.getAll()
           Result.success(todos)
       } catch (e: Exception) {
           Result.failure(e)
       }
   }

   // Usage in ViewModel
   result.fold(
       onSuccess = { todos -> /* handle success */ },
       onFailure = { error -> /* handle error */ }
   )
   ```

2. **Arrow-kt's `Either<L, R>`** (from `arrow.core.Either`)

   ```kotlin
   import arrow.core.Either
   import arrow.core.left
   import arrow.core.right

   // Usage in use cases
   suspend fun getTodos(): Either<AppError, List<TodoEntity>> {
       return try {
           val todos = repository.getAll()
           todos.right()
       } catch (e: ValidationException) {
           AppError.ValidationError(e.message).left()
       } catch (e: Exception) {
           AppError.UnknownError(e.message ?: "Unknown error").left()
       }
   }

   // Usage in ViewModel
   result.fold(
       ifLeft = { error -> /* handle error */ },
       ifRight = { todos -> /* handle success */ }
   )
   ```

**Recommendation:** Use **Arrow-kt's Either** for better type safety and functional composition, or **Kotlin's Result** for zero dependencies.

### Infrastructure Layer

#### Database (Room)

- **`TodoDatabase.kt`**: Room database instance
- **`TodoDao.kt`**: Data Access Object for Room
- **`TodoRoomEntity.kt`**: Room entity (separate from domain entity)
- **`DateTypeConverter.kt`**: Type converter for dates
- **`TodoMappers.kt`**: Mappers between domain entities and Room entities

#### Repositories (Adapters)

- **`TodoRepositoryImpl.kt`**: Concrete repository implementation
  - Implements `TodoRepository` interface
  - Uses Room database
  - Returns `Result<T>` (Kotlin) or `Either<AppError, T>` (Arrow-kt)

#### Dependency Injection

- **`DatabaseModule.kt`**: Hilt module for database setup
- **`RepositoryModule.kt`**: Hilt module for repository bindings
- **`UseCaseModule.kt`**: Hilt module for use case bindings

### Presentation Layer

#### Screens

- **`TodoListScreen.kt`**: Main screen composable
  - Handles all UI states (Loading, Success, Error, Empty)
  - Uses TodoViewModel

#### ViewModels

- **`TodoViewModel.kt`**: ViewModel with StateFlow
  - Handles `Result<T>` or `Either<AppError, T>` from use cases
  - Maps to TodoUiState
  - Uses HiltViewModel

#### UI Components

- **`TodoItem.kt`**: Individual todo item composable
  - Accessibility support (content descriptions)
  - Toggle and delete actions
- **`CreateTodoDialog.kt`**: Dialog for creating todos
- **`EditTodoDialog.kt`**: Dialog for editing todos
- **`EmptyState.kt`**: Empty state composable
- **`ErrorMessage.kt`**: Error message composable

#### State

- **`TodoUiState.kt`**: Sealed class for UI states

  ```kotlin
  sealed class TodoUiState {
      object Loading : TodoUiState()
      data class Success(val todos: List<TodoEntity>) : TodoUiState()
      data class Error(val message: String) : TodoUiState()
      object Empty : TodoUiState()
  }
  ```

#### Navigation

- **`Navigation.kt`**: Navigation setup and routes

### Application

- **`ProductiveApplication.kt`**: Application class
  - Hilt setup with `@HiltAndroidApp`
  - Initialization logic

## Test Utilities

### Test Helpers (`test/test_utils/`)

- **`TestFixtures.kt`**: Factory functions for test data

  ```kotlin
  object TestFixtures {
      fun createTodoEntity(id: String = "1", title: String = "Test Todo"): TodoEntity
      fun createTodoList(count: Int = 3): List<TodoEntity>
  }
  ```

- **`MockHelpers.kt`**: Mock setup utilities
- **`TestCoroutineRule.kt`**: Coroutine test rule for unit tests

## Architecture Notes

### Dependency Flow

```text
Presentation → Application → Domain
     ↓              ↓
Infrastructure → Application → Domain
```

### Error Handling Strategy

- **Domain Layer**: Uses exceptions (ValidationException, NotFoundException)
- **Application Layer**: Converts exceptions to `Result<T>` (Kotlin) or `Either<AppError, T>` (Arrow-kt)
- **Infrastructure Layer**: Catches exceptions, converts to `Result<T>` or `Either<AppError, T>`
- **Presentation Layer**: Maps `Result<T>` or `Either<AppError, T>` to UI state (TodoUiState.Error)

**Dependencies:**

- **Kotlin's Result**: Built-in, no dependencies needed
- **Arrow-kt Either**: Add to `build.gradle.kts`:

  ```kotlin
  implementation("io.arrow-kt:arrow-core:2.0.0")
  ```

### Testing Strategy

- **Unit Tests** (`test/`): Fast, no Android dependencies

  - Domain entities, use cases, types
  - Mock repositories
  - Test utilities and fixtures

- **Instrumented Tests** (`androidTest/`): Run on device/emulator
  - UI tests with Compose Testing APIs
  - Database tests with Room
  - Integration tests for full flows
  - Screenshot tests with Paparazzi

### Screenshot Testing

- Uses **Paparazzi** library for Compose screenshot testing
- Tests visual regression of UI components
- Generates reference images for comparison
- Runs as part of CI/CD pipeline

## Missing Components Added

1. **AppError.kt**: Sealed class hierarchy for error types (used with Either)
2. **DateTypeConverter.kt**: Room type converter for dates
3. **Test utilities**: TestFixtures, MockHelpers, TestCoroutineRule
4. **Screenshot tests**: Paparazzi tests for all UI components
5. **Integration tests**: Full flow testing
6. **Database tests**: Room database and DAO tests
7. **Resource files**: String, color, theme resources

## Error Handling Libraries

**Option 1: Kotlin's Built-in Result** (Recommended for simplicity)

- No dependencies needed
- Part of Kotlin standard library
- Use: `Result.success(value)` and `Result.failure(exception)`

**Option 2: Arrow-kt Either** (Recommended for functional programming)

- Dependency: `io.arrow-kt:arrow-core:2.0.0`
- Better type safety with Left/Right
- Rich functional API (map, flatMap, fold, etc.)
- Use: `value.right()` and `error.left()`
