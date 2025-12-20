import '../../domain/entities/todo_entity.dart';
import '../../domain/entities/todo_icon_type.dart';
import '../../domain/repositories/todo_repository.dart';

/// Use case for updating an existing todo.
///
/// This use case encapsulates the business logic for updating a todo,
/// including validation and delegation to the repository. It supports
/// partial updates (only specified fields are updated).
///
/// **Responsibilities:**
/// - Validate input parameters
/// - Retrieve existing todo
/// - Apply updates
/// - Persist via repository
/// - Return the updated todo
///
/// **Example:**
/// ```dart
/// final useCase = UpdateTodoUseCase(repository);
/// final updatedTodo = await useCase.execute(
///   id: 'todo_1',
///   isCompleted: true,
/// );
/// ```
class UpdateTodoUseCase {
  /// The repository for persisting todos.
  final TodoRepository _repository;

  /// Creates a new [UpdateTodoUseCase] instance.
  ///
  /// **Parameters:**
  /// - `repository`: The todo repository to use for persistence
  UpdateTodoUseCase(this._repository);

  /// Executes the update todo use case.
  ///
  /// **Parameters:**
  /// - `id`: The ID of the todo to update (required)
  /// - `title`: Optional new title (must not be empty if provided)
  /// - `description`: Optional new description
  /// - `deadline`: Optional new deadline
  /// - `isCompleted`: Optional new completion status
  /// - `iconType`: Optional new icon type
  ///
  /// **Returns:**
  /// A [Future] that completes with the updated [TodoEntity].
  ///
  /// **Throws:**
  /// - `ArgumentError` if `id` is empty or `title` is empty (if provided)
  /// - `NotFoundException` if todo with given ID does not exist
  /// - `RepositoryException` if the repository operation fails
  Future<TodoEntity> execute({
    required String id,
    String? title,
    String? description,
    DateTime? deadline,
    bool? isCompleted,
    TodoIconType? iconType,
  }) async {
    // Validate ID
    if (id.trim().isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }

    // Validate title if provided
    if (title != null && title.trim().isEmpty) {
      throw ArgumentError('Title cannot be empty');
    }

    // Retrieve existing todo
    final existingTodo = await _repository.getById(id);
    if (existingTodo == null) {
      throw Exception('Todo with ID "$id" not found');
    }

    // Apply updates using copyWith
    final updatedTodo = existingTodo.copyWith(
      title: title?.trim(),
      description: description?.trim(),
      deadline: deadline,
      isCompleted: isCompleted,
      iconType: iconType,
    );

    // Persist via repository
    return await _repository.update(updatedTodo);
  }
}

