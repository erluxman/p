import '../../domain/entities/todo_entity.dart';
import '../../domain/repositories/todo_repository.dart';

/// Use case for retrieving all todos.
///
/// This use case encapsulates the business logic for retrieving all todos,
/// delegating to the repository.
///
/// **Responsibilities:**
/// - Retrieve all todos from repository
/// - Return the list of todos (empty if none exist)
///
/// **Example:**
/// ```dart
/// final useCase = GetAllTodosUseCase(repository);
/// final todos = await useCase.execute();
/// ```
class GetAllTodosUseCase {
  /// The repository for persisting todos.
  final TodoRepository _repository;

  /// Creates a new [GetAllTodosUseCase] instance.
  ///
  /// **Parameters:**
  /// - `repository`: The todo repository to use for persistence
  GetAllTodosUseCase(this._repository);

  /// Executes the get all todos use case.
  ///
  /// **Returns:**
  /// A [Future] that completes with a list of all [TodoEntity] instances.
  /// Returns an empty list if no todos exist.
  ///
  /// **Throws:**
  /// - `RepositoryException` if the repository operation fails
  Future<List<TodoEntity>> execute() async {
    return await _repository.getAll();
  }
}

