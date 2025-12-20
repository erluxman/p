import '../entities/todo_entity.dart';

/// Repository interface for managing Todo entities.
///
/// This is a **port** in Hexagonal Architecture, defining the contract
/// that infrastructure adapters must implement. The domain layer depends
/// only on this interface, not on any specific implementation.
///
/// **Responsibilities:**
/// - Create new todos
/// - Retrieve todos (all or by ID)
/// - Update existing todos
/// - Delete todos
///
/// **Error Handling:**
/// Implementations should throw domain-specific exceptions that can be
/// caught and handled by the application layer.
///
/// **Example:**
/// ```dart
/// final repository = TodoRepositoryImpl();
/// final todo = await repository.create(
///   TodoEntity(id: '1', title: 'New Todo'),
/// );
/// ```
abstract class TodoRepository {
  /// Creates a new todo.
  ///
  /// **Parameters:**
  /// - `todo`: The todo entity to create
  ///
  /// **Returns:**
  /// A [Future] that completes with the created [TodoEntity] (may include
  /// generated fields like `id` or `createdAt`).
  ///
  /// **Throws:**
  /// - `RepositoryException` if the operation fails
  Future<TodoEntity> create(TodoEntity todo);

  /// Retrieves all todos.
  ///
  /// **Returns:**
  /// A [Future] that completes with a list of all [TodoEntity] instances.
  /// Returns an empty list if no todos exist.
  ///
  /// **Throws:**
  /// - `RepositoryException` if the operation fails
  Future<List<TodoEntity>> getAll();

  /// Retrieves a todo by its ID.
  ///
  /// **Parameters:**
  /// - `id`: The unique identifier of the todo
  ///
  /// **Returns:**
  /// A [Future] that completes with the [TodoEntity] if found, or `null`
  /// if no todo with the given ID exists.
  ///
  /// **Throws:**
  /// - `RepositoryException` if the operation fails
  Future<TodoEntity?> getById(String id);

  /// Updates an existing todo.
  ///
  /// **Parameters:**
  /// - `todo`: The todo entity with updated values
  ///
  /// **Returns:**
  /// A [Future] that completes with the updated [TodoEntity].
  ///
  /// **Throws:**
  /// - `RepositoryException` if the todo does not exist or the operation fails
  Future<TodoEntity> update(TodoEntity todo);

  /// Deletes a todo by its ID.
  ///
  /// **Parameters:**
  /// - `id`: The unique identifier of the todo to delete
  ///
  /// **Returns:**
  /// A [Future] that completes when the todo has been deleted.
  ///
  /// **Throws:**
  /// - `RepositoryException` if the todo does not exist or the operation fails
  Future<void> delete(String id);
}

