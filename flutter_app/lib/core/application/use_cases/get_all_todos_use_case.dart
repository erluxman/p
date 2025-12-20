import '../../domain/entities/todo_entity.dart';
import '../../domain/repositories/todo_repository.dart';

class GetAllTodosUseCase {
  final TodoRepository _repository;

  GetAllTodosUseCase(this._repository);

  Future<List<TodoEntity>> execute() async {
    return await _repository.getAll();
  }
}

