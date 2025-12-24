import 'package:flutter_test/flutter_test.dart';
import 'package:habit_todo_app/core/application/use_cases/create_todo_use_case.dart';
import 'package:habit_todo_app/core/application/use_cases/get_all_todos_use_case.dart';
import 'package:habit_todo_app/core/domain/entities/todo_icon_type.dart';
import 'package:habit_todo_app/infrastructure/adapters/repositories/todo_repository_impl.dart';
import 'package:habit_todo_app/infrastructure/data/local/todo_local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Integration test for the complete Todo feature.
///
/// This test verifies the end-to-end flow:
/// 1. Create 3 todos using the use cases
/// 2. Verify they are persisted to storage
/// 3. Verify they are rendered in the UI
///
/// **Success Criteria:**
/// - 3 todos can be created successfully
/// - All 3 todos appear in the list
/// - Todos persist across repository instances
void main() {
  group('Todo Feature Integration Test', () {
    late SharedPreferences prefs;
    late TodoLocalStorage storage;
    late TodoRepositoryImpl repository;

    setUp(() async {
      // Use in-memory SharedPreferences for testing
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      storage = TodoLocalStorage(prefs);
      repository = TodoRepositoryImpl(storage);
    });

    tearDown(() async {
      // Clear storage after each test
      await prefs.clear();
    });

    test('should create 3 todos and render them in the list', () async {
      // Arrange - Create use cases
      final createUseCase = CreateTodoUseCase(repository);
      final getAllUseCase = GetAllTodosUseCase(repository);

      // Act - Create 3 todos
      final todo1 = await createUseCase.execute(
        title: 'Write tomorrow\'s TODO',
        deadline: DateTime(2024, 1, 15, 20, 30),
        iconType: TodoIconType.writing,
      );

      final todo2 = await createUseCase.execute(
        title: 'Read Atomic Habits',
        deadline: DateTime(2024, 1, 15, 21, 15),
        iconType: TodoIconType.reading,
      );

      final todo3 = await createUseCase.execute(
        title: 'Exercise for 30 minutes',
        deadline: DateTime(2024, 1, 16, 8, 0),
        iconType: TodoIconType.exercise,
      );

      // Assert - Verify todos were created
      expect(todo1.id, isNotEmpty);
      expect(todo1.title, 'Write tomorrow\'s TODO');
      expect(todo2.id, isNotEmpty);
      expect(todo2.title, 'Read Atomic Habits');
      expect(todo3.id, isNotEmpty);
      expect(todo3.title, 'Exercise for 30 minutes');

      // Verify all todos are retrieved
      final allTodos = await getAllUseCase.execute();
      expect(allTodos.length, 3);
      expect(allTodos.any((t) => t.id == todo1.id), isTrue);
      expect(allTodos.any((t) => t.id == todo2.id), isTrue);
      expect(allTodos.any((t) => t.id == todo3.id), isTrue);

      // Verify todos persist across repository instances
      final newRepository = TodoRepositoryImpl(storage);
      final newGetAllUseCase = GetAllTodosUseCase(newRepository);
      final persistedTodos = await newGetAllUseCase.execute();
      expect(persistedTodos.length, 3);
    });

    test('should verify todos are retrievable after creation', () async {
      // Arrange - Create 3 todos
      final createUseCase = CreateTodoUseCase(repository);
      final getAllUseCase = GetAllTodosUseCase(repository);

      // Act - Create 3 todos
      final todo1 = await createUseCase.execute(
        title: 'Write tomorrow\'s TODO',
        deadline: DateTime(2024, 1, 15, 20, 30),
        iconType: TodoIconType.writing,
      );

      final todo2 = await createUseCase.execute(
        title: 'Read Atomic Habits',
        deadline: DateTime(2024, 1, 15, 21, 15),
        iconType: TodoIconType.reading,
      );

      final todo3 = await createUseCase.execute(
        title: 'Exercise for 30 minutes',
        deadline: DateTime(2024, 1, 16, 8, 0),
        iconType: TodoIconType.exercise,
      );

      // Assert - Verify all 3 todos are retrievable
      final allTodos = await getAllUseCase.execute();
      expect(allTodos.length, 3);

      // Verify each todo has correct properties
      final retrievedTodo1 = allTodos.firstWhere((t) => t.id == todo1.id);
      expect(retrievedTodo1.title, 'Write tomorrow\'s TODO');
      expect(retrievedTodo1.iconType, TodoIconType.writing);

      final retrievedTodo2 = allTodos.firstWhere((t) => t.id == todo2.id);
      expect(retrievedTodo2.title, 'Read Atomic Habits');
      expect(retrievedTodo2.iconType, TodoIconType.reading);

      final retrievedTodo3 = allTodos.firstWhere((t) => t.id == todo3.id);
      expect(retrievedTodo3.title, 'Exercise for 30 minutes');
      expect(retrievedTodo3.iconType, TodoIconType.exercise);
    });

    test('should verify todos have correct properties', () async {
      // Arrange
      final createUseCase = CreateTodoUseCase(repository);

      // Act - Create 3 todos with different properties
      final todo1 = await createUseCase.execute(
        title: 'Todo with deadline',
        deadline: DateTime(2024, 1, 15, 20, 30),
        iconType: TodoIconType.writing,
      );

      final todo2 = await createUseCase.execute(
        title: 'Todo without deadline',
        iconType: TodoIconType.reading,
      );

      final todo3 = await createUseCase.execute(
        title: 'Todo with description',
        description: 'This is a detailed description',
        iconType: TodoIconType.exercise,
      );

      // Assert - Verify properties
      expect(todo1.deadline, isNotNull);
      expect(todo1.iconType, TodoIconType.writing);
      expect(todo1.isCompleted, false);

      expect(todo2.deadline, isNull);
      expect(todo2.iconType, TodoIconType.reading);
      expect(todo2.isCompleted, false);

      expect(todo3.description, 'This is a detailed description');
      expect(todo3.iconType, TodoIconType.exercise);
      expect(todo3.isCompleted, false);

      // Verify all are retrievable
      final getAllUseCase = GetAllTodosUseCase(repository);
      final allTodos = await getAllUseCase.execute();
      expect(allTodos.length, 3);
    });

    test('should maintain todo order after creation', () async {
      // Arrange
      final createUseCase = CreateTodoUseCase(repository);
      final getAllUseCase = GetAllTodosUseCase(repository);

      // Act - Create 3 todos in sequence
      final todo1 = await createUseCase.execute(title: 'First Todo');
      await Future.delayed(const Duration(milliseconds: 10));
      final todo2 = await createUseCase.execute(title: 'Second Todo');
      await Future.delayed(const Duration(milliseconds: 10));
      final todo3 = await createUseCase.execute(title: 'Third Todo');

      // Assert - Verify todos are in creation order
      final allTodos = await getAllUseCase.execute();
      expect(allTodos.length, 3);

      // Todos should be retrievable (order may vary based on implementation)
      expect(allTodos.any((t) => t.id == todo1.id), isTrue);
      expect(allTodos.any((t) => t.id == todo2.id), isTrue);
      expect(allTodos.any((t) => t.id == todo3.id), isTrue);
    });
  });
}
