import '../../domain/entities/todo_entity.dart';
import '../../domain/entities/todo_icon_type.dart';
import '../../domain/repositories/todo_repository.dart';

class UpdateTodoUseCase {
  final TodoRepository _repository;

  UpdateTodoUseCase(this._repository);

  Future<TodoEntity> execute({
    required String id,
    String? title,
    String? description,
    DateTime? deadline,
    bool? isCompleted,
    TodoIconType? iconType,
  }) async {
    if (id.trim().isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }

    if (title != null && title.trim().isEmpty) {
      throw ArgumentError('Title cannot be empty');
    }

    final existingTodo = await _repository.getById(id);
    if (existingTodo == null) {
      throw Exception('Todo with ID "$id" not found');
    }

    final updatedTodo = existingTodo.copyWith(
      title: title?.trim(),
      description: description?.trim(),
      deadline: deadline,
      isCompleted: isCompleted,
      iconType: iconType,
    );

    return await _repository.update(updatedTodo);
  }
}

