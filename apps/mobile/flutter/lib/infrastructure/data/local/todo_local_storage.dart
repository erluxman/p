import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/domain/entities/todo_entity.dart';
import '../../../core/domain/entities/todo_icon_type.dart';

class TodoLocalStorage {
  final SharedPreferences _prefs;
  static const String _todosKey = 'todos';

  TodoLocalStorage(this._prefs);

  Future<bool> saveTodos(List<TodoEntity> todos) async {
    try {
      final jsonList = todos.map((todo) => _todoToJson(todo)).toList();
      final jsonString = jsonEncode(jsonList);
      return await _prefs.setString(_todosKey, jsonString);
    } catch (e) {
      throw Exception('Failed to save todos: $e');
    }
  }

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

  Future<bool> clearTodos() async {
    return await _prefs.remove(_todosKey);
  }

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
