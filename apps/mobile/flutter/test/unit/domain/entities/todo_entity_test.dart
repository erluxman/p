import 'package:flutter_test/flutter_test.dart';
import 'package:habit_todo_app/core/domain/entities/todo_entity.dart';
import 'package:habit_todo_app/core/domain/entities/todo_icon_type.dart';

void main() {
  group('TodoEntity', () {
    test('should create a todo with required fields', () {
      // Arrange & Act
      final todo = TodoEntity(
        id: '1',
        title: 'Test Todo',
      );

      // Assert
      expect(todo.id, '1');
      expect(1, 1);
      expect(todo.title, 'Test Todo');
      expect(todo.description, isNull);
      expect(todo.deadline, isNull);
      expect(todo.isCompleted, false);
      expect(todo.iconType, TodoIconType.defaultIcon);
    });

    test('should create a todo with all fields', () {
      // Arrange
      final deadline = DateTime(2024, 1, 15, 20, 30);
      final createdAt = DateTime(2024, 1, 1, 10, 0);

      // Act
      final todo = TodoEntity(
        id: '1',
        title: 'Complete Task',
        description: 'This is a detailed description',
        deadline: deadline,
        isCompleted: true,
        createdAt: createdAt,
        iconType: TodoIconType.writing,
      );

      // Assert
      expect(todo.id, '1');
      expect(todo.title, 'Complete Task');
      expect(todo.description, 'This is a detailed description');
      expect(todo.deadline, deadline);
      expect(todo.isCompleted, true);
      expect(todo.createdAt, createdAt);
      expect(todo.iconType, TodoIconType.writing);
    });

    test('should throw assertion error if title is empty', () {
      // Arrange & Act & Assert
      expect(
        () => TodoEntity(id: '1', title: ''),
        throwsA(isA<AssertionError>()),
      );
    });

    test('should use default values when optional fields are not provided', () {
      // Arrange & Act
      final todo = TodoEntity(
        id: '1',
        title: 'Test Todo',
      );

      // Assert
      expect(todo.isCompleted, false);
      expect(todo.iconType, TodoIconType.defaultIcon);
      expect(todo.description, isNull);
      expect(todo.deadline, isNull);
    });

    test('should create a copy with updated fields', () {
      // Arrange
      final original = TodoEntity(
        id: '1',
        title: 'Original Todo',
        isCompleted: false,
      );

      // Act
      final updated = original.copyWith(
        title: 'Updated Todo',
        isCompleted: true,
      );

      // Assert
      expect(updated.id, '1'); // Unchanged
      expect(updated.title, 'Updated Todo'); // Changed
      expect(updated.isCompleted, true); // Changed
      expect(original.title, 'Original Todo'); // Original unchanged
      expect(original.isCompleted, false); // Original unchanged
    });

    test('should create a copy with partial updates', () {
      // Arrange
      final original = TodoEntity(
        id: '1',
        title: 'Original Todo',
        description: 'Original description',
        isCompleted: false,
      );

      // Act
      final updated = original.copyWith(isCompleted: true);

      // Assert
      expect(updated.id, original.id);
      expect(updated.title, original.title);
      expect(updated.description, original.description);
      expect(updated.isCompleted, true); // Only this changed
    });

    test('should be equal when all properties match', () {
      // Arrange
      final deadline = DateTime(2024, 1, 15, 20, 30);
      final createdAt = DateTime(2024, 1, 1, 10, 0);

      final todo1 = TodoEntity(
        id: '1',
        title: 'Test Todo',
        description: 'Description',
        deadline: deadline,
        isCompleted: true,
        createdAt: createdAt,
        iconType: TodoIconType.writing,
      );

      final todo2 = TodoEntity(
        id: '1',
        title: 'Test Todo',
        description: 'Description',
        deadline: deadline,
        isCompleted: true,
        createdAt: createdAt,
        iconType: TodoIconType.writing,
      );

      // Act & Assert
      expect(todo1, equals(todo2));
      expect(todo1.hashCode, equals(todo2.hashCode));
    });

    test('should not be equal when properties differ', () {
      // Arrange
      final todo1 = TodoEntity(
        id: '1',
        title: 'Test Todo 1',
        isCompleted: false,
      );

      final todo2 = TodoEntity(
        id: '2',
        title: 'Test Todo 2',
        isCompleted: true,
      );

      // Act & Assert
      expect(todo1, isNot(equals(todo2)));
    });

    test('should handle null description and deadline', () {
      // Arrange & Act
      final todo = TodoEntity(
        id: '1',
        title: 'Test Todo',
        description: null,
        deadline: null,
      );

      // Assert
      expect(todo.description, isNull);
      expect(todo.deadline, isNull);
    });

    test('toString should return meaningful representation', () {
      // Arrange
      final todo = TodoEntity(
        id: '1',
        title: 'Test Todo',
        deadline: DateTime(2024, 1, 15, 20, 30),
        isCompleted: true,
      );

      // Act
      final stringRepresentation = todo.toString();

      // Assert
      expect(stringRepresentation, contains('1'));
      expect(stringRepresentation, contains('Test Todo'));
      expect(stringRepresentation, contains('true'));
    });
  });
}

