import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_todo_app/presentation/navigation/app_router.dart';
import 'package:habit_todo_app/presentation/screens/hello_world_screen.dart';

/// Tests for [appRouter].
///
/// Verifies that the router correctly navigates to the Hello World screen
/// and handles the initial route properly.
void main() {
  group('appRouter', () {
    test('should have hello-world route defined', () {
      // Act
      final route = appRouter.configuration.routes.first;

      // Assert
      expect(route, isA<GoRoute>());
      expect((route as GoRoute).path, '/');
      expect(route.name, 'hello-world');
    });

    testWidgets('should navigate to HelloWorldScreen on root path', (WidgetTester tester) async {
      // Arrange
      final router = appRouter;

      // Act
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      // Wait for navigation to complete
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(HelloWorldScreen), findsOneWidget);
      expect(find.text('Hello, World!'), findsOneWidget);
    });
  });
}

