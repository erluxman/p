import '../../../core/domain/entities/todo_entity.dart';
import '../../../core/domain/repositories/todo_repository.dart';
import '../../data/local/todo_local_storage.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalStorage _storage;
  List<TodoEntity> _todos = [];
  bool _loaded = false;

  TodoRepositoryImpl(this._storage);

  Future<void> _ensureLoaded() async {
    if (!_loaded) {
      _todos = await _storage.loadTodos();
      _loaded = true;
    }
  }

  Future<void> _persist() async {
    await _storage.saveTodos(_todos);
  }

  @override
  Future<TodoEntity> create(TodoEntity todo) async {
    await _ensureLoaded();

    if (_todos.any((t) => t.id == todo.id)) {
      throw Exception('Todo with ID "${todo.id}" already exists');
    }

    _todos.add(todo);
    await _persist();

    return todo;
  }

  @override
  Future<List<TodoEntity>> getAll() async {
    await _ensureLoaded();
    return List.unmodifiable(_todos);
  }

  @override
  Future<TodoEntity?> getById(String id) async {
    await _ensureLoaded();
    try {
      return _todos.firstWhere((todo) => todo.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<TodoEntity> update(TodoEntity todo) async {
    await _ensureLoaded();

    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index == -1) {
      throw Exception('Todo with ID "${todo.id}" not found');
    }

    _todos[index] = todo;
    await _persist();

    return todo;
  }

  @override
  Future<void> delete(String id) async {
    await _ensureLoaded();

    final index = _todos.indexWhere((t) => t.id == id);
    if (index == -1) {
      throw Exception('Todo with ID "$id" not found');
    }

    _todos.removeAt(index);
    await _persist();
  }
}
