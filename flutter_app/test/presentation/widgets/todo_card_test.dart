import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_todo_app/core/domain/entities/todo_entity.dart';
import 'package:habit_todo_app/presentation/widgets/todo_card.dart';

void main() {
  group('TodoCard', () {
    testWidgets('should display todo title', (WidgetTester tester) async {
      // Arrange
      final todo = TodoEntity(
        id: 'todo_1',
        title: 'Test Todo',
        createdAt: DateTime(2024, 1, 1),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TodoCard(todo: todo),
          ),
        ),
      );

      // Assert
      expect(find.text('Test Todo'), findsOneWidget);
    });

    testWidgets('should display deadline when provided',
        (WidgetTester tester) async {
      // Arrange
      final deadline = DateTime(2024, 1, 15, 20, 30);
      final todo = TodoEntity(
        id: 'todo_1',
        title: 'Test Todo',
        deadline: deadline,
        createdAt: DateTime(2024, 1, 1),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TodoCard(todo: todo),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.access_time), findsOneWidget);
    });

    testWidgets('should show checkbox with correct state',
        (WidgetTester tester) async {
      // Arrange
      final completedTodo = TodoEntity(
        id: 'todo_1',
        title: 'Completed Todo',
        isCompleted: true,
        createdAt: DateTime(2024, 1, 1),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TodoCard(todo: completedTodo),
          ),
        ),
      );

      // Assert
      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.value, true);
    });

    testWidgets('should call onCheckboxChanged when checkbox is tapped',
        (WidgetTester tester) async {
      // Arrange
      var checkboxChanged = false;
      final todo = TodoEntity(
        id: 'todo_1',
        title: 'Test Todo',
        createdAt: DateTime(2024, 1, 1),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TodoCard(
              todo: todo,
              onCheckboxChanged: (value) {
                checkboxChanged = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      // Assert
      expect(checkboxChanged, true);
    });
  });
}
