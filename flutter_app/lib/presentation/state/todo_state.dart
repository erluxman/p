import 'package:equatable/equatable.dart';
import '../../core/domain/entities/todo_entity.dart';

/// Represents the state of the todos list.
///
/// This is a sealed class that can be in one of three states:
/// - [TodoLoadingState]: Initial state or while loading
/// - [TodoSuccessState]: Successfully loaded todos
/// - [TodoErrorState]: Error occurred while loading
///
/// **Example:**
/// ```dart
/// final state = TodoSuccessState(todos: [todo1, todo2]);
/// ```
sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object?> get props => [];
}

/// State indicating that todos are being loaded.
class TodoLoadingState extends TodoState {
  const TodoLoadingState();
}

/// State indicating that todos were successfully loaded.
class TodoSuccessState extends TodoState {
  /// The list of todos.
  final List<TodoEntity> todos;

  /// Creates a new [TodoSuccessState] instance.
  ///
  /// **Parameters:**
  /// - `todos`: The list of todos (defaults to empty list)
  const TodoSuccessState({this.todos = const []});

  @override
  List<Object?> get props => [todos];
}

/// State indicating that an error occurred while loading todos.
class TodoErrorState extends TodoState {
  /// The error message.
  final String message;

  /// Creates a new [TodoErrorState] instance.
  ///
  /// **Parameters:**
  /// - `message`: The error message
  const TodoErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

