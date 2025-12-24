import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_todo_app/presentation/navigation/app_router.dart';
import 'package:habit_todo_app/presentation/screens/tasks_screen.dart';

/// Tests for [appRouter].
///
/// Verifies that the router correctly navigates to the Tasks screen
/// and handles the initial route properly.
void main() {
  group('appRouter', () {
    test('should have tasks route defined', () {
      // Act
      final route = appRouter.configuration.routes.first;

      // Assert
      expect(route, isA<GoRoute>());
      expect((route as GoRoute).path, '/tasks');
      expect(route.name, 'tasks');
    });

    testWidgets('should navigate to TasksScreen on root path', (WidgetTester tester) async {
      // Arrange
      final router = appRouter;

      // Act
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      // Pump frames to allow navigation and async provider initialization
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.byType(TasksScreen), findsOneWidget);
    });
  });
}

