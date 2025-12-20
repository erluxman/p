import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/application/use_cases/create_todo_use_case.dart';
import '../../core/application/use_cases/delete_todo_use_case.dart';
import '../../core/application/use_cases/get_all_todos_use_case.dart';
import '../../core/application/use_cases/update_todo_use_case.dart';
import '../../core/domain/entities/todo_entity.dart';
import '../../core/domain/repositories/todo_repository.dart';
import '../../infrastructure/adapters/repositories/todo_repository_impl.dart';
import '../../infrastructure/data/local/todo_local_storage.dart';
import 'todo_state.dart';

final sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs;
});

final todoLocalStorageProvider = FutureProvider<TodoLocalStorage>((ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return TodoLocalStorage(prefs);
});

final todoRepositoryProvider = FutureProvider<TodoRepository>((ref) async {
  final storage = await ref.watch(todoLocalStorageProvider.future);
  return TodoRepositoryImpl(storage);
});

final getAllTodosUseCaseProvider =
    FutureProvider<GetAllTodosUseCase>((ref) async {
  final repository = await ref.watch(todoRepositoryProvider.future);
  return GetAllTodosUseCase(repository);
});

final createTodoUseCaseProvider =
    FutureProvider<CreateTodoUseCase>((ref) async {
  final repository = await ref.watch(todoRepositoryProvider.future);
  return CreateTodoUseCase(repository);
});

final updateTodoUseCaseProvider =
    FutureProvider<UpdateTodoUseCase>((ref) async {
  final repository = await ref.watch(todoRepositoryProvider.future);
  return UpdateTodoUseCase(repository);
});

final deleteTodoUseCaseProvider =
    FutureProvider<DeleteTodoUseCase>((ref) async {
  final repository = await ref.watch(todoRepositoryProvider.future);
  return DeleteTodoUseCase(repository);
});

final todosStateProvider =
    StateNotifierProvider<TodosNotifier, TodoState>((ref) {
  return TodosNotifier(ref);
});

class TodosNotifier extends StateNotifier<TodoState> {
  final Ref _ref;

  TodosNotifier(this._ref) : super(const TodoLoadingState()) {
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    state = const TodoLoadingState();
    try {
      final getAllTodosUseCase =
          await _ref.read(getAllTodosUseCaseProvider.future);
      final todos = await getAllTodosUseCase.execute();
      state = TodoSuccessState(todos: todos);
    } catch (e) {
      state = TodoErrorState(e.toString());
    }
  }

  Future<void> refresh() async {
    await _loadTodos();
  }

  List<TodoEntity> get todos {
    if (state is TodoSuccessState) {
      return (state as TodoSuccessState).todos;
    }
    return [];
  }
}
