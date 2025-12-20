import '../../../core/domain/entities/todo_entity.dart';
import '../../../core/domain/repositories/todo_repository.dart';
import '../../data/local/todo_local_storage.dart';

/// Implementation of [TodoRepository] using local storage.
///
/// This adapter implements the repository interface using SharedPreferences
/// for persistence. It follows Hexagonal Architecture by implementing the
/// domain port (TodoRepository) in the infrastructure layer.
///
/// **Storage:**
/// - Uses [TodoLocalStorage] for low-level storage operations
/// - Maintains todos in memory for fast access
/// - Persists changes to SharedPreferences
///
/// **Example:**
/// ```dart
/// final prefs = await SharedPreferences.getInstance();
/// final storage = TodoLocalStorage(prefs);
/// final repository = TodoRepositoryImpl(storage);
/// ```
class TodoRepositoryImpl implements TodoRepository {
  /// The local storage instance for persisting todos.
  final TodoLocalStorage _storage;

  /// In-memory cache of todos for fast access.
  List<TodoEntity> _todos = [];

  /// Whether todos have been loaded from storage.
  bool _loaded = false;

  /// Creates a new [TodoRepositoryImpl] instance.
  ///
  /// **Parameters:**
  /// - `storage`: The local storage instance to use
  TodoRepositoryImpl(this._storage);

  /// Loads todos from storage if not already loaded.
  Future<void> _ensureLoaded() async {
    if (!_loaded) {
      _todos = await _storage.loadTodos();
      _loaded = true;
    }
  }

  /// Persists the current todos to storage.
  Future<void> _persist() async {
    await _storage.saveTodos(_todos);
  }

  @override
  Future<TodoEntity> create(TodoEntity todo) async {
    await _ensureLoaded();

    // Check if todo with same ID already exists
    if (_todos.any((t) => t.id == todo.id)) {
      throw Exception('Todo with ID "${todo.id}" already exists');
    }

    // Add to in-memory list
    _todos.add(todo);

    // Persist to storage
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

    // Find the index of the todo to update
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index == -1) {
      throw Exception('Todo with ID "${todo.id}" not found');
    }

    // Update in-memory list
    _todos[index] = todo;

    // Persist to storage
    await _persist();

    return todo;
  }

  @override
  Future<void> delete(String id) async {
    await _ensureLoaded();

    // Find the index of the todo to delete
    final index = _todos.indexWhere((t) => t.id == id);
    if (index == -1) {
      throw Exception('Todo with ID "$id" not found');
    }

    // Remove from in-memory list
    _todos.removeAt(index);

    // Persist to storage
    await _persist();
  }
}
