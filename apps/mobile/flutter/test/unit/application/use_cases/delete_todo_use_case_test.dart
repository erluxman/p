import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:habit_todo_app/core/application/use_cases/delete_todo_use_case.dart';
import 'package:habit_todo_app/core/domain/entities/todo_entity.dart';
import 'package:habit_todo_app/core/domain/repositories/todo_repository.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  group('DeleteTodoUseCase', () {
    late DeleteTodoUseCase useCase;
    late MockTodoRepository mockRepository;

    setUp(() {
      mockRepository = MockTodoRepository();
      useCase = DeleteTodoUseCase(mockRepository);
    });

    test('should delete todo with valid id', () async {
      // Arrange
      final existingTodo = TodoEntity(
        id: 'todo_1',
        title: 'Test Todo',
        createdAt: DateTime(2024, 1, 1),
      );

      when(() => mockRepository.getById('todo_1')).thenAnswer((_) async => existingTodo);
      when(() => mockRepository.delete('todo_1')).thenAnswer((_) async => Future.value());

      // Act
      await useCase.execute(id: 'todo_1');

      // Assert
      verify(() => mockRepository.getById('todo_1')).called(1);
      verify(() => mockRepository.delete('todo_1')).called(1);
    });

    test('should throw ArgumentError if id is empty', () async {
      // Act & Assert
      expect(
        () => useCase.execute(id: ''),
        throwsA(isA<ArgumentError>()),
      );
      verifyNever(() => mockRepository.getById(any()));
      verifyNever(() => mockRepository.delete(any()));
    });

    test('should throw Exception if todo does not exist', () async {
      // Arrange
      when(() => mockRepository.getById('non_existent')).thenAnswer((_) async => null);

      // Act & Assert
      expect(
        () => useCase.execute(id: 'non_existent'),
        throwsA(isA<Exception>()),
      );
      verify(() => mockRepository.getById('non_existent')).called(1);
      verifyNever(() => mockRepository.delete(any()));
    });

    test('should trim id before processing', () async {
      // Arrange
      final existingTodo = TodoEntity(
        id: 'todo_1',
        title: 'Test Todo',
        createdAt: DateTime(2024, 1, 1),
      );

      when(() => mockRepository.getById('todo_1')).thenAnswer((_) async => existingTodo);
      when(() => mockRepository.delete('todo_1')).thenAnswer((_) async => Future.value());

      // Act
      await useCase.execute(id: '  todo_1  ');

      // Assert
      verify(() => mockRepository.getById('todo_1')).called(1);
      verify(() => mockRepository.delete('todo_1')).called(1);
    });
  });
}

