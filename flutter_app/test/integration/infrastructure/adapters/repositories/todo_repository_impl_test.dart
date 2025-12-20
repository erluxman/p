import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:habit_todo_app/core/domain/entities/todo_entity.dart';
import 'package:habit_todo_app/core/domain/entities/todo_icon_type.dart';
import 'package:habit_todo_app/infrastructure/adapters/repositories/todo_repository_impl.dart';
import 'package:habit_todo_app/infrastructure/data/local/todo_local_storage.dart';

void main() {
  group('TodoRepositoryImpl Integration Tests', () {
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

    test('should create and retrieve a todo', () async {
      // Arrange
      final todo = TodoEntity(
        id: 'todo_1',
        title: 'Test Todo',
        createdAt: DateTime(2024, 1, 1),
      );

      // Act
      final created = await repository.create(todo);
      final retrieved = await repository.getById('todo_1');

      // Assert
      expect(created, equals(todo));
      expect(retrieved, isNotNull);
      expect(retrieved!.id, 'todo_1');
      expect(retrieved.title, 'Test Todo');
    });

    test('should persist todos across repository instances', () async {
      // Arrange
      final todo = TodoEntity(
        id: 'todo_1',
        title: 'Persistent Todo',
        createdAt: DateTime(2024, 1, 1),
      );

      // Act - Create with first repository instance
      await repository.create(todo);

      // Create a new repository instance (simulating app restart)
      final newRepository = TodoRepositoryImpl(storage);

      // Assert - Should be able to retrieve from new instance
      final retrieved = await newRepository.getById('todo_1');
      expect(retrieved, isNotNull);
      expect(retrieved!.title, 'Persistent Todo');
    });

    test('should retrieve all todos', () async {
      // Arrange
      final todo1 = TodoEntity(
        id: 'todo_1',
        title: 'Todo 1',
        createdAt: DateTime(2024, 1, 1),
      );
      final todo2 = TodoEntity(
        id: 'todo_2',
        title: 'Todo 2',
        createdAt: DateTime(2024, 1, 2),
      );

      // Act
      await repository.create(todo1);
      await repository.create(todo2);
      final allTodos = await repository.getAll();

      // Assert
      expect(allTodos.length, 2);
      expect(allTodos.any((t) => t.id == 'todo_1'), isTrue);
      expect(allTodos.any((t) => t.id == 'todo_2'), isTrue);
    });

    test('should update an existing todo', () async {
      // Arrange
      final original = TodoEntity(
        id: 'todo_1',
        title: 'Original Title',
        isCompleted: false,
        createdAt: DateTime(2024, 1, 1),
      );

      await repository.create(original);

      // Act
      final updated = original.copyWith(
        title: 'Updated Title',
        isCompleted: true,
      );
      final result = await repository.update(updated);

      // Assert
      expect(result.title, 'Updated Title');
      expect(result.isCompleted, true);

      final retrieved = await repository.getById('todo_1');
      expect(retrieved!.title, 'Updated Title');
      expect(retrieved.isCompleted, true);
    });

    test('should delete a todo', () async {
      // Arrange
      final todo = TodoEntity(
        id: 'todo_1',
        title: 'To Delete',
        createdAt: DateTime(2024, 1, 1),
      );

      await repository.create(todo);

      // Act
      await repository.delete('todo_1');

      // Assert
      final retrieved = await repository.getById('todo_1');
      expect(retrieved, isNull);

      final allTodos = await repository.getAll();
      expect(allTodos.length, 0);
    });

    test('should throw exception when creating duplicate ID', () async {
      // Arrange
      final todo = TodoEntity(
        id: 'todo_1',
        title: 'First Todo',
        createdAt: DateTime(2024, 1, 1),
      );

      await repository.create(todo);

      // Act & Assert
      expect(
        () => repository.create(todo),
        throwsA(isA<Exception>()),
      );
    });

    test('should throw exception when updating non-existent todo', () async {
      // Arrange
      final todo = TodoEntity(
        id: 'non_existent',
        title: 'Does Not Exist',
        createdAt: DateTime(2024, 1, 1),
      );

      // Act & Assert
      expect(
        () => repository.update(todo),
        throwsA(isA<Exception>()),
      );
    });

    test('should throw exception when deleting non-existent todo', () async {
      // Act & Assert
      expect(
        () => repository.delete('non_existent'),
        throwsA(isA<Exception>()),
      );
    });

    test('should handle todos with all fields', () async {
      // Arrange
      final deadline = DateTime(2024, 1, 15, 20, 30);
      final todo = TodoEntity(
        id: 'todo_1',
        title: 'Complete Todo',
        description: 'Description',
        deadline: deadline,
        isCompleted: true,
        createdAt: DateTime(2024, 1, 1),
        iconType: TodoIconType.writing,
      );

      // Act
      await repository.create(todo);
      final retrieved = await repository.getById('todo_1');

      // Assert
      expect(retrieved, isNotNull);
      expect(retrieved!.title, 'Complete Todo');
      expect(retrieved.description, 'Description');
      expect(retrieved.deadline, deadline);
      expect(retrieved.isCompleted, true);
      expect(retrieved.iconType, TodoIconType.writing);
    });

    test('should handle todos with null optional fields', () async {
      // Arrange
      final todo = TodoEntity(
        id: 'todo_1',
        title: 'Simple Todo',
        createdAt: DateTime(2024, 1, 1),
      );

      // Act
      await repository.create(todo);
      final retrieved = await repository.getById('todo_1');

      // Assert
      expect(retrieved, isNotNull);
      expect(retrieved!.description, isNull);
      expect(retrieved.deadline, isNull);
      expect(retrieved.isCompleted, false);
    });

    test('should return empty list when no todos exist', () async {
      // Act
      final todos = await repository.getAll();

      // Assert
      expect(todos, isEmpty);
    });
  });
}

