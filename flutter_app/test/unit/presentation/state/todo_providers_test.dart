import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_todo_app/core/application/use_cases/get_all_todos_use_case.dart';
import 'package:habit_todo_app/core/domain/entities/todo_entity.dart';
import 'package:habit_todo_app/presentation/state/todo_providers.dart';
import 'package:habit_todo_app/presentation/state/todo_state.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAllTodosUseCase extends Mock implements GetAllTodosUseCase {}

class MockRef extends Mock implements Ref {}

void main() {
  group('TodosNotifier', () {
    late MockGetAllTodosUseCase mockUseCase;
    late ProviderContainer container;

    setUp(() {
      mockUseCase = MockGetAllTodosUseCase();
    });

    tearDown(() async {
      await Future.delayed(const Duration(milliseconds: 100));
      container.dispose();
    });

    test('should start with loading state', () async {
      // Arrange
      when(() => mockUseCase.execute()).thenAnswer((_) async => []);

      container = ProviderContainer(
        overrides: [
          getAllTodosUseCaseProvider.overrideWith(
            (ref) async => mockUseCase,
          ),
        ],
      );

      final stateProvider =
          StateNotifierProvider<TodosNotifier, TodoState>((ref) {
        return TodosNotifier(ref);
      });

      // Act
      final state = container.read(stateProvider);

      // Assert
      expect(state, isA<TodoLoadingState>());
    });

    test('should transition to success state with todos', () async {
      // Arrange
      final todos = [
        TodoEntity(
          id: 'todo_1',
          title: 'Todo 1',
          createdAt: DateTime(2024, 1, 1),
        ),
        TodoEntity(
          id: 'todo_2',
          title: 'Todo 2',
          createdAt: DateTime(2024, 1, 2),
        ),
      ];

      when(() => mockUseCase.execute()).thenAnswer((_) async => todos);

      container = ProviderContainer(
        overrides: [
          getAllTodosUseCaseProvider.overrideWith(
            (ref) async => mockUseCase,
          ),
        ],
      );

      final stateProvider =
          StateNotifierProvider<TodosNotifier, TodoState>((ref) {
        return TodosNotifier(ref);
      });

      // Act - Wait for async initialization with multiple checks
      TodoState state;
      int attempts = 0;
      do {
        await Future.delayed(const Duration(milliseconds: 50));
        state = container.read(stateProvider);
        attempts++;
      } while (state is TodoLoadingState && attempts < 20);

      // Assert
      expect(state, isA<TodoSuccessState>());
      if (state is TodoSuccessState) {
        expect(state.todos.length, 2);
        expect(state.todos[0].id, 'todo_1');
        expect(state.todos[1].id, 'todo_2');
      }
    });

    test('should transition to error state on failure', () async {
      // Arrange
      when(() => mockUseCase.execute()).thenThrow(Exception('Failed to load'));

      container = ProviderContainer(
        overrides: [
          getAllTodosUseCaseProvider.overrideWith(
            (ref) async => mockUseCase,
          ),
        ],
      );

      final stateProvider =
          StateNotifierProvider<TodosNotifier, TodoState>((ref) {
        return TodosNotifier(ref);
      });

      // Act - Wait for async initialization with multiple checks
      TodoState state;
      int attempts = 0;
      do {
        await Future.delayed(const Duration(milliseconds: 50));
        state = container.read(stateProvider);
        attempts++;
      } while (state is TodoLoadingState && attempts < 20);

      // Assert
      expect(state, isA<TodoErrorState>());
      if (state is TodoErrorState) {
        expect(state.message, contains('Failed to load'));
      }
    });

    test('should refresh todos', () async {
      // Arrange
      final initialTodos = [
        TodoEntity(
          id: 'todo_1',
          title: 'Todo 1',
          createdAt: DateTime(2024, 1, 1),
        ),
      ];

      final updatedTodos = [
        TodoEntity(
          id: 'todo_1',
          title: 'Todo 1',
          createdAt: DateTime(2024, 1, 1),
        ),
        TodoEntity(
          id: 'todo_2',
          title: 'Todo 2',
          createdAt: DateTime(2024, 1, 2),
        ),
      ];

      var callCount = 0;
      when(() => mockUseCase.execute()).thenAnswer((_) async {
        callCount++;
        if (callCount == 1) {
          return initialTodos;
        } else {
          return updatedTodos;
        }
      });

      container = ProviderContainer(
        overrides: [
          getAllTodosUseCaseProvider.overrideWith(
            (ref) async => mockUseCase,
          ),
        ],
      );

      final stateProvider =
          StateNotifierProvider<TodosNotifier, TodoState>((ref) {
        return TodosNotifier(ref);
      });

      // Wait for initial load
      TodoState initialState;
      int attempts = 0;
      do {
        await Future.delayed(const Duration(milliseconds: 50));
        initialState = container.read(stateProvider);
        attempts++;
      } while (initialState is TodoLoadingState && attempts < 20);

      // Act
      final notifier = container.read(stateProvider.notifier);
      await notifier.refresh();

      // Wait for refresh to complete
      await Future.delayed(const Duration(milliseconds: 50));

      // Assert
      final state = container.read(stateProvider);
      expect(state, isA<TodoSuccessState>());
      if (state is TodoSuccessState) {
        expect(state.todos.length, 2);
      }
    });

    test('should return empty list when state is not success', () {
      // Arrange
      final mockRef = MockRef();
      final notifier = TodosNotifier(mockRef);
      notifier.state = const TodoLoadingState();

      // Act
      final todos = notifier.todos;

      // Assert
      expect(todos, isEmpty);
    });

    test('should return todos when state is success', () {
      // Arrange
      final mockRef = MockRef();
      final todos = [
        TodoEntity(
          id: 'todo_1',
          title: 'Todo 1',
          createdAt: DateTime(2024, 1, 1),
        ),
      ];

      final notifier = TodosNotifier(mockRef);
      notifier.state = TodoSuccessState(todos: todos);

      // Act
      final result = notifier.todos;

      // Assert
      expect(result.length, 1);
      expect(result[0].id, 'todo_1');
    });
  });
}
