import '../../domain/repositories/todo_repository.dart';

/// Use case for deleting a todo.
///
/// This use case encapsulates the business logic for deleting a todo,
/// including validation and delegation to the repository.
///
/// **Responsibilities:**
/// - Validate input parameters
/// - Verify todo exists
/// - Delete via repository
///
/// **Example:**
/// ```dart
/// final useCase = DeleteTodoUseCase(repository);
/// await useCase.execute(id: 'todo_1');
/// ```
class DeleteTodoUseCase {
  /// The repository for persisting todos.
  final TodoRepository _repository;

  /// Creates a new [DeleteTodoUseCase] instance.
  ///
  /// **Parameters:**
  /// - `repository`: The todo repository to use for persistence
  DeleteTodoUseCase(this._repository);

  /// Executes the delete todo use case.
  ///
  /// **Parameters:**
  /// - `id`: The ID of the todo to delete (required)
  ///
  /// **Returns:**
  /// A [Future] that completes when the todo has been deleted.
  ///
  /// **Throws:**
  /// - `ArgumentError` if `id` is empty
  /// - `NotFoundException` if todo with given ID does not exist
  /// - `RepositoryException` if the repository operation fails
  Future<void> execute({required String id}) async {
    // Validate and trim ID
    final trimmedId = id.trim();
    if (trimmedId.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }

    // Verify todo exists
    final existingTodo = await _repository.getById(trimmedId);
    if (existingTodo == null) {
      throw Exception('Todo with ID "$trimmedId" not found');
    }

    // Delete via repository
    await _repository.delete(trimmedId);
  }
}

