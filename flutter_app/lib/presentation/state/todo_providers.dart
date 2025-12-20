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

/// Provider for SharedPreferences instance.
///
/// This provider creates a singleton SharedPreferences instance
/// that is used by the repository for persistence.
final sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs;
});

/// Provider for TodoLocalStorage.
///
/// Depends on [sharedPreferencesProvider] to get the SharedPreferences instance.
final todoLocalStorageProvider = FutureProvider<TodoLocalStorage>((ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return TodoLocalStorage(prefs);
});

/// Provider for TodoRepository implementation.
///
/// Depends on [todoLocalStorageProvider] to get the storage instance.
final todoRepositoryProvider = FutureProvider<TodoRepository>((ref) async {
  final storage = await ref.watch(todoLocalStorageProvider.future);
  return TodoRepositoryImpl(storage);
});

/// Provider for GetAllTodosUseCase.
///
/// Depends on [todoRepositoryProvider] to get the repository.
final getAllTodosUseCaseProvider =
    FutureProvider<GetAllTodosUseCase>((ref) async {
  final repository = await ref.watch(todoRepositoryProvider.future);
  return GetAllTodosUseCase(repository);
});

/// Provider for CreateTodoUseCase.
///
/// Depends on [todoRepositoryProvider] to get the repository.
final createTodoUseCaseProvider =
    FutureProvider<CreateTodoUseCase>((ref) async {
  final repository = await ref.watch(todoRepositoryProvider.future);
  return CreateTodoUseCase(repository);
});

/// Provider for UpdateTodoUseCase.
///
/// Depends on [todoRepositoryProvider] to get the repository.
final updateTodoUseCaseProvider =
    FutureProvider<UpdateTodoUseCase>((ref) async {
  final repository = await ref.watch(todoRepositoryProvider.future);
  return UpdateTodoUseCase(repository);
});

/// Provider for DeleteTodoUseCase.
///
/// Depends on [todoRepositoryProvider] to get the repository.
final deleteTodoUseCaseProvider =
    FutureProvider<DeleteTodoUseCase>((ref) async {
  final repository = await ref.watch(todoRepositoryProvider.future);
  return DeleteTodoUseCase(repository);
});

/// Provider for the todos state.
///
/// This provider manages the state of the todos list, including
/// loading, success, and error states. It automatically loads
/// todos when first accessed.
///
/// **Usage:**
/// ```dart
/// final todosState = ref.watch(todosStateProvider);
/// ```
final todosStateProvider =
    StateNotifierProvider<TodosNotifier, TodoState>((ref) {
  return TodosNotifier(ref);
});

/// Notifier for managing todos state.
///
/// This notifier handles loading todos, creating, updating, and deleting todos,
/// and manages the state transitions.
class TodosNotifier extends StateNotifier<TodoState> {
  /// The provider reference for accessing use cases.
  final Ref _ref;

  /// Creates a new [TodosNotifier] instance.
  ///
  /// **Parameters:**
  /// - `ref`: The provider reference for accessing use cases
  TodosNotifier(this._ref) : super(const TodoLoadingState()) {
    _loadTodos();
  }

  /// Loads all todos from the repository.
  ///
  /// Sets the state to [TodoLoadingState] while loading, then to
  /// [TodoSuccessState] with the todos, or [TodoErrorState] if an error occurs.
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

  /// Refreshes the todos list.
  ///
  /// Reloads all todos from the repository.
  Future<void> refresh() async {
    await _loadTodos();
  }

  /// Gets the current list of todos.
  ///
  /// Returns an empty list if the state is not [TodoSuccessState].
  List<TodoEntity> get todos {
    if (state is TodoSuccessState) {
      return (state as TodoSuccessState).todos;
    }
    return [];
  }
}
