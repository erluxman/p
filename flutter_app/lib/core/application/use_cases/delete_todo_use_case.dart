import '../../domain/repositories/todo_repository.dart';

class DeleteTodoUseCase {
  final TodoRepository _repository;

  DeleteTodoUseCase(this._repository);

  Future<void> execute({required String id}) async {
    final trimmedId = id.trim();
    if (trimmedId.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }

    final existingTodo = await _repository.getById(trimmedId);
    if (existingTodo == null) {
      throw Exception('Todo with ID "$trimmedId" not found');
    }

    await _repository.delete(trimmedId);
  }
}

