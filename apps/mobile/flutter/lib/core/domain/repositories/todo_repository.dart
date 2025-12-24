import '../entities/todo_entity.dart';

/// Port in Hexagonal Architecture - defines the contract for todo persistence.
/// Infrastructure adapters implement this interface.
abstract class TodoRepository {
  Future<TodoEntity> create(TodoEntity todo);
  Future<List<TodoEntity>> getAll();
  Future<TodoEntity?> getById(String id);
  Future<TodoEntity> update(TodoEntity todo);
  Future<void> delete(String id);
}

