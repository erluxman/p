import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_todo_app/presentation/screens/hello_world_screen.dart';

/// Tests for [HelloWorldScreen].
///
/// Verifies that the screen displays the expected "Hello, World!" message
/// and welcome text correctly.
void main() {
  group('HelloWorldScreen', () {
    testWidgets('should display Hello World message', (WidgetTester tester) async {
      // Arrange
      const screen = HelloWorldScreen();

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: screen,
        ),
      );

      // Assert
      expect(find.text('Hello, World!'), findsOneWidget);
      expect(find.text('Welcome to Habit & Todo App'), findsOneWidget);
    });

    testWidgets('should have app bar with correct title', (WidgetTester tester) async {
      // Arrange
      const screen = HelloWorldScreen();

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: screen,
        ),
      );

      // Assert
      expect(find.text('Hello World'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('should center the content', (WidgetTester tester) async {
      // Arrange
      const screen = HelloWorldScreen();

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: screen,
        ),
      );

      // Assert
      final centerFinder = find.byType(Center);
      expect(centerFinder, findsOneWidget);

      final columnFinder = find.byType(Column);
      expect(columnFinder, findsOneWidget);
    });
  });
}

