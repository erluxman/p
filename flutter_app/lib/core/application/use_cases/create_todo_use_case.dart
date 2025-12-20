import '../../domain/entities/todo_entity.dart';
import '../../domain/entities/todo_icon_type.dart';
import '../../domain/repositories/todo_repository.dart';

class CreateTodoUseCase {
  final TodoRepository _repository;

  CreateTodoUseCase(this._repository);

  Future<TodoEntity> execute({
    required String title,
    String? description,
    DateTime? deadline,
    String? id,
    TodoIconType? iconType,
  }) async {
    if (title.trim().isEmpty) {
      throw ArgumentError('Title cannot be empty');
    }

    final todoId = id ?? _generateId();

    final todo = TodoEntity(
      id: todoId,
      title: title.trim(),
      description: description?.trim(),
      deadline: deadline,
      iconType: iconType ?? TodoIconType.defaultIcon,
      createdAt: DateTime.now(),
    );

    return await _repository.create(todo);
  }

  String _generateId() {
    return 'todo_${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecondsSinceEpoch}';
  }
}

