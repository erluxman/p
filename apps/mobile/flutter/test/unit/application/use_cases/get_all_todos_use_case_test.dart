import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:habit_todo_app/core/application/use_cases/get_all_todos_use_case.dart';
import 'package:habit_todo_app/core/domain/entities/todo_entity.dart';
import 'package:habit_todo_app/core/domain/repositories/todo_repository.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  group('GetAllTodosUseCase', () {
    late GetAllTodosUseCase useCase;
    late MockTodoRepository mockRepository;

    setUp(() {
      mockRepository = MockTodoRepository();
      useCase = GetAllTodosUseCase(mockRepository);
    });

    test('should return all todos', () async {
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

      when(() => mockRepository.getAll()).thenAnswer((_) async => todos);

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result, equals(todos));
      expect(result.length, 2);
      verify(() => mockRepository.getAll()).called(1);
    });

    test('should return empty list when no todos exist', () async {
      // Arrange
      when(() => mockRepository.getAll()).thenAnswer((_) async => <TodoEntity>[]);

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result, isEmpty);
      verify(() => mockRepository.getAll()).called(1);
    });

    test('should delegate to repository', () async {
      // Arrange
      when(() => mockRepository.getAll()).thenAnswer((_) async => <TodoEntity>[]);

      // Act
      await useCase.execute();

      // Assert
      verify(() => mockRepository.getAll()).called(1);
    });
  });
}

