import 'package:flutter_test/flutter_test.dart';
import 'package:habit_todo_app/core/application/use_cases/create_todo_use_case.dart';
import 'package:habit_todo_app/core/domain/entities/todo_entity.dart';
import 'package:habit_todo_app/core/domain/entities/todo_icon_type.dart';
import 'package:habit_todo_app/core/domain/repositories/todo_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(TodoEntity(
      id: 'fallback',
      title: 'Fallback',
      createdAt: DateTime(2024, 1, 1),
    ));
  });

  group('CreateTodoUseCase', () {
    late CreateTodoUseCase useCase;
    late MockTodoRepository mockRepository;

    setUp(() {
      mockRepository = MockTodoRepository();
      useCase = CreateTodoUseCase(mockRepository);
    });

    test('should create todo with valid input', () async {
      // Arrange
      final expectedTodo = TodoEntity(
        id: 'todo_1',
        title: 'Test Todo',
        createdAt: DateTime(2024, 1, 1),
      );

      when(() => mockRepository.create(any()))
          .thenAnswer((_) async => expectedTodo);

      // Act
      final result = await useCase.execute(title: 'Test Todo');

      // Assert
      expect(result, equals(expectedTodo));
      verify(() => mockRepository.create(any())).called(1);
    });

    test('should create todo with all fields', () async {
      // Arrange
      final deadline = DateTime(2024, 1, 15, 20, 30);
      final expectedTodo = TodoEntity(
        id: 'todo_1',
        title: 'Complete Task',
        description: 'Description',
        deadline: deadline,
        iconType: TodoIconType.writing,
        createdAt: DateTime(2024, 1, 1),
      );

      when(() => mockRepository.create(any()))
          .thenAnswer((_) async => expectedTodo);

      // Act
      final result = await useCase.execute(
        title: 'Complete Task',
        description: 'Description',
        deadline: deadline,
        iconType: TodoIconType.writing,
      );

      // Assert
      expect(result, equals(expectedTodo));
      verify(() => mockRepository.create(any())).called(1);
    });

    test('should throw ArgumentError if title is empty', () async {
      // Act & Assert
      expect(
        () => useCase.execute(title: ''),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should throw ArgumentError if title is only whitespace', () async {
      // Act & Assert
      expect(
        () => useCase.execute(title: '   '),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should trim title and description', () async {
      // Arrange
      final expectedTodo = TodoEntity(
        id: 'todo_1',
        title: 'Trimmed Title',
        description: 'Trimmed Description',
        createdAt: DateTime(2024, 1, 1),
      );

      when(() => mockRepository.create(any()))
          .thenAnswer((_) async => expectedTodo);

      // Act
      await useCase.execute(
        title: '  Trimmed Title  ',
        description: '  Trimmed Description  ',
      );

      // Assert
      verify(() => mockRepository.create(any(
              that: predicate<TodoEntity>(
            (todo) =>
                todo.title == 'Trimmed Title' &&
                todo.description == 'Trimmed Description',
          )))).called(1);
    });

    test('should generate ID if not provided', () async {
      // Arrange
      final expectedTodo = TodoEntity(
        id: 'generated_id',
        title: 'Test Todo',
        createdAt: DateTime(2024, 1, 1),
      );

      when(() => mockRepository.create(any()))
          .thenAnswer((_) async => expectedTodo);

      // Act
      await useCase.execute(title: 'Test Todo');

      // Assert
      verify(() => mockRepository.create(any(
              that: predicate<TodoEntity>(
            (todo) => todo.id.isNotEmpty,
          )))).called(1);
    });

    test('should use provided ID if given', () async {
      // Arrange
      final expectedTodo = TodoEntity(
        id: 'custom_id',
        title: 'Test Todo',
        createdAt: DateTime(2024, 1, 1),
      );

      when(() => mockRepository.create(any()))
          .thenAnswer((_) async => expectedTodo);

      // Act
      await useCase.execute(title: 'Test Todo', id: 'custom_id');

      // Assert
      verify(() => mockRepository.create(any(
              that: predicate<TodoEntity>(
            (todo) => todo.id == 'custom_id',
          )))).called(1);
    });

    test('should use default icon type if not provided', () async {
      // Arrange
      final expectedTodo = TodoEntity(
        id: 'todo_1',
        title: 'Test Todo',
        iconType: TodoIconType.defaultIcon,
        createdAt: DateTime(2024, 1, 1),
      );

      when(() => mockRepository.create(any()))
          .thenAnswer((_) async => expectedTodo);

      // Act
      await useCase.execute(title: 'Test Todo');

      // Assert
      verify(() => mockRepository.create(any(
              that: predicate<TodoEntity>(
            (todo) => todo.iconType == TodoIconType.defaultIcon,
          )))).called(1);
    });
  });
}
