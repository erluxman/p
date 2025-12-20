import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:habit_todo_app/core/application/use_cases/update_todo_use_case.dart';
import 'package:habit_todo_app/core/domain/entities/todo_entity.dart';
import 'package:habit_todo_app/core/domain/repositories/todo_repository.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(TodoEntity(
      id: 'fallback',
      title: 'Fallback',
      createdAt: DateTime(2024, 1, 1),
    ));
  });

  group('UpdateTodoUseCase', () {
    late UpdateTodoUseCase useCase;
    late MockTodoRepository mockRepository;

    setUp(() {
      mockRepository = MockTodoRepository();
      useCase = UpdateTodoUseCase(mockRepository);
    });

    test('should update todo with valid input', () async {
      // Arrange
      final existingTodo = TodoEntity(
        id: 'todo_1',
        title: 'Original Title',
        isCompleted: false,
        createdAt: DateTime(2024, 1, 1),
      );

      final updatedTodo = existingTodo.copyWith(
        title: 'Updated Title',
        isCompleted: true,
      );

      when(() => mockRepository.getById('todo_1'))
          .thenAnswer((_) async => existingTodo);
      when(() => mockRepository.update(any()))
          .thenAnswer((_) async => updatedTodo);

      // Act
      final result = await useCase.execute(
        id: 'todo_1',
        title: 'Updated Title',
        isCompleted: true,
      );

      // Assert
      expect(result.title, 'Updated Title');
      expect(result.isCompleted, true);
      verify(() => mockRepository.getById('todo_1')).called(1);
      verify(() => mockRepository.update(any())).called(1);
    });

    test('should update only completion status', () async {
      // Arrange
      final existingTodo = TodoEntity(
        id: 'todo_1',
        title: 'Test Todo',
        isCompleted: false,
        createdAt: DateTime(2024, 1, 1),
      );

      final updatedTodo = existingTodo.copyWith(isCompleted: true);

      when(() => mockRepository.getById('todo_1'))
          .thenAnswer((_) async => existingTodo);
      when(() => mockRepository.update(any()))
          .thenAnswer((_) async => updatedTodo);

      // Act
      final result = await useCase.execute(
        id: 'todo_1',
        isCompleted: true,
      );

      // Assert
      expect(result.isCompleted, true);
      expect(result.title, 'Test Todo'); // Unchanged
      verify(() => mockRepository.update(any())).called(1);
    });

    test('should throw ArgumentError if id is empty', () async {
      // Act & Assert
      expect(
        () => useCase.execute(id: ''),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should throw ArgumentError if title is empty when provided',
        () async {
      // Act & Assert
      expect(
        () => useCase.execute(id: 'todo_1', title: ''),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should throw Exception if todo does not exist', () async {
      // Arrange
      when(() => mockRepository.getById('non_existent'))
          .thenAnswer((_) async => null);

      // Act & Assert
      expect(
        () => useCase.execute(id: 'non_existent', title: 'New Title'),
        throwsA(isA<Exception>()),
      );
      verify(() => mockRepository.getById('non_existent')).called(1);
    });

    test('should trim title and description when updating', () async {
      // Arrange
      final existingTodo = TodoEntity(
        id: 'todo_1',
        title: 'Original',
        createdAt: DateTime(2024, 1, 1),
      );

      final updatedTodo = existingTodo.copyWith(
        title: 'Trimmed Title',
        description: 'Trimmed Description',
      );

      when(() => mockRepository.getById('todo_1'))
          .thenAnswer((_) async => existingTodo);
      when(() => mockRepository.update(any(
              that: predicate<TodoEntity>(
            (todo) =>
                todo.title == 'Trimmed Title' &&
                todo.description == 'Trimmed Description',
          )))).thenAnswer((_) async => updatedTodo);

      // Act
      await useCase.execute(
        id: 'todo_1',
        title: '  Trimmed Title  ',
        description: '  Trimmed Description  ',
      );

      // Assert
      verify(() => mockRepository.update(any(
              that: predicate<TodoEntity>(
            (todo) =>
                todo.title == 'Trimmed Title' &&
                todo.description == 'Trimmed Description',
          )))).called(1);
    });

    test('should update deadline', () async {
      // Arrange
      final existingTodo = TodoEntity(
        id: 'todo_1',
        title: 'Test Todo',
        createdAt: DateTime(2024, 1, 1),
      );

      final newDeadline = DateTime(2024, 1, 20, 18, 0);
      final updatedTodo = existingTodo.copyWith(deadline: newDeadline);

      when(() => mockRepository.getById('todo_1'))
          .thenAnswer((_) async => existingTodo);
      when(() => mockRepository.update(any()))
          .thenAnswer((_) async => updatedTodo);

      // Act
      final result = await useCase.execute(
        id: 'todo_1',
        deadline: newDeadline,
      );

      // Assert
      expect(result.deadline, newDeadline);
      verify(() => mockRepository.update(any())).called(1);
    });
  });
}
