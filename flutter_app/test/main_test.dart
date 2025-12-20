import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_todo_app/main.dart';
import 'package:habit_todo_app/presentation/screens/tasks_screen.dart';

/// Tests for the main application entry point.
///
/// Verifies that the app initializes correctly with ProviderScope
/// and MaterialApp.router configuration.
void main() {
  group('HabitTodoApp', () {
    testWidgets('should initialize with ProviderScope',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const ProviderScope(
          child: HabitTodoApp(),
        ),
      );

      // Assert
      expect(find.byType(ProviderScope), findsOneWidget);
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('should have correct app title', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const ProviderScope(
          child: HabitTodoApp(),
        ),
      );

      // Pump a few frames to allow initialization, but don't wait for all async operations
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.title, 'Habit & Todo App');
    });

    testWidgets('should navigate to TasksScreen on startup',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const ProviderScope(
          child: HabitTodoApp(),
        ),
      );

      // Pump frames to allow navigation and async provider initialization
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - TasksScreen should be present (even if still loading)
      expect(find.byType(TasksScreen), findsOneWidget);
    });
  });
}
