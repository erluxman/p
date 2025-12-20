import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_todo_app/main.dart';
import 'package:habit_todo_app/presentation/screens/hello_world_screen.dart';

/// Tests for the main application entry point.
///
/// Verifies that the app initializes correctly with ProviderScope
/// and MaterialApp.router configuration.
void main() {
  group('HabitTodoApp', () {
    testWidgets('should initialize with ProviderScope', (WidgetTester tester) async {
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

      await tester.pumpAndSettle();

      // Assert
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.title, 'Habit & Todo App');
    });

    testWidgets('should navigate to HelloWorldScreen on startup', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const ProviderScope(
          child: HabitTodoApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(HelloWorldScreen), findsOneWidget);
    });
  });
}

