import 'package:equatable/equatable.dart';
import '../../core/domain/entities/todo_entity.dart';

sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object?> get props => [];
}

class TodoLoadingState extends TodoState {
  const TodoLoadingState();
}

class TodoSuccessState extends TodoState {
  final List<TodoEntity> todos;

  const TodoSuccessState({this.todos = const []});

  @override
  List<Object?> get props => [todos];
}

class TodoErrorState extends TodoState {
  final String message;

  const TodoErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

