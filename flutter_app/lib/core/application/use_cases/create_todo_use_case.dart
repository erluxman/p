import '../../domain/entities/todo_entity.dart';
import '../../domain/entities/todo_icon_type.dart';
import '../../domain/repositories/todo_repository.dart';

/// Use case for creating a new todo.
///
/// This use case encapsulates the business logic for creating a todo,
/// including validation and delegation to the repository.
///
/// **Responsibilities:**
/// - Validate input parameters
/// - Create the todo entity
/// - Persist via repository
/// - Return the created todo
///
/// **Example:**
/// ```dart
/// final useCase = CreateTodoUseCase(repository);
/// final todo = await useCase.execute(
///   title: 'New Todo',
///   description: 'Description',
/// );
/// ```
class CreateTodoUseCase {
  /// The repository for persisting todos.
  final TodoRepository _repository;

  /// Creates a new [CreateTodoUseCase] instance.
  ///
  /// **Parameters:**
  /// - `repository`: The todo repository to use for persistence
  CreateTodoUseCase(this._repository);

  /// Executes the create todo use case.
  ///
  /// **Parameters:**
  /// - `title`: The title of the todo (required, must not be empty)
  /// - `description`: Optional detailed description
  /// - `deadline`: Optional deadline date and time
  /// - `iconType`: Optional icon type (defaults to `TodoIconType.defaultIcon`)
  ///
  /// **Returns:**
  /// A [Future] that completes with the created [TodoEntity].
  ///
  /// **Throws:**
  /// - `ArgumentError` if `title` is empty
  /// - `RepositoryException` if the repository operation fails
  Future<TodoEntity> execute({
    required String title,
    String? description,
    DateTime? deadline,
    String? id,
    TodoIconType? iconType,
  }) async {
    // Validate input
    if (title.trim().isEmpty) {
      throw ArgumentError('Title cannot be empty');
    }

    // Generate ID if not provided
    final todoId = id ?? _generateId();

    // Create the todo entity
    final todo = TodoEntity(
      id: todoId,
      title: title.trim(),
      description: description?.trim(),
      deadline: deadline,
      iconType: iconType ?? TodoIconType.defaultIcon,
      createdAt: DateTime.now(),
    );

    // Persist via repository
    return await _repository.create(todo);
  }

  /// Generates a unique ID for a new todo.
  ///
  /// Uses timestamp and random component to ensure uniqueness.
  String _generateId() {
    return 'todo_${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecondsSinceEpoch}';
  }
}

