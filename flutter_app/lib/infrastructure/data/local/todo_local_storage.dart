import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/domain/entities/todo_entity.dart';
import '../../../core/domain/entities/todo_icon_type.dart';

/// Low-level storage operations for Todo entities.
///
/// This class handles the serialization and deserialization of todos
/// to/from SharedPreferences. It provides a simple key-value storage
/// interface for the repository implementation.
///
/// **Storage Format:**
/// - Key: `todos` (single key storing all todos as JSON array)
/// - Value: JSON array of todo objects
class TodoLocalStorage {
  /// The SharedPreferences instance to use for storage.
  final SharedPreferences _prefs;

  /// The key used to store todos in SharedPreferences.
  static const String _todosKey = 'todos';

  /// Creates a new [TodoLocalStorage] instance.
  ///
  /// **Parameters:**
  /// - `prefs`: The SharedPreferences instance to use
  TodoLocalStorage(this._prefs);

  /// Saves a list of todos to local storage.
  ///
  /// **Parameters:**
  /// - `todos`: The list of todos to save
  ///
  /// **Returns:**
  /// A [Future] that completes with `true` if the save was successful.
  ///
  /// **Throws:**
  /// - `Exception` if serialization or storage fails
  Future<bool> saveTodos(List<TodoEntity> todos) async {
    try {
      final jsonList = todos.map((todo) => _todoToJson(todo)).toList();
      final jsonString = jsonEncode(jsonList);
      return await _prefs.setString(_todosKey, jsonString);
    } catch (e) {
      throw Exception('Failed to save todos: $e');
    }
  }

  /// Loads all todos from local storage.
  ///
  /// **Returns:**
  /// A [Future] that completes with a list of [TodoEntity] instances.
  /// Returns an empty list if no todos are stored.
  ///
  /// **Throws:**
  /// - `Exception` if deserialization fails
  Future<List<TodoEntity>> loadTodos() async {
    try {
      final jsonString = _prefs.getString(_todosKey);
      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      final jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList
          .map((json) => _todoFromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load todos: $e');
    }
  }

  /// Clears all todos from local storage.
  ///
  /// **Returns:**
  /// A [Future] that completes with `true` if the clear was successful.
  Future<bool> clearTodos() async {
    return await _prefs.remove(_todosKey);
  }

  /// Converts a [TodoEntity] to a JSON map.
  Map<String, dynamic> _todoToJson(TodoEntity todo) {
    return {
      'id': todo.id,
      'title': todo.title,
      'description': todo.description,
      'deadline': todo.deadline?.toIso8601String(),
      'isCompleted': todo.isCompleted,
      'createdAt': todo.createdAt.toIso8601String(),
      'iconType': todo.iconType.name,
    };
  }

  /// Converts a JSON map to a [TodoEntity].
  TodoEntity _todoFromJson(Map<String, dynamic> json) {
    return TodoEntity(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'] as String)
          : null,
      isCompleted: json['isCompleted'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      iconType: TodoIconType.values.firstWhere(
        (type) => type.name == json['iconType'],
        orElse: () => TodoIconType.defaultIcon,
      ),
    );
  }
}
