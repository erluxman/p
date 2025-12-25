import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_todo_app/main.dart' as app;
import 'package:habit_todo_app/presentation/screens/tasks_screen.dart';
import 'package:habit_todo_app/presentation/widgets/todo_card.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Integration test for the complete Todo feature on a real device.
///
/// This test verifies the end-to-end flow on an iOS device:
/// 1. App launches successfully
/// 2. Create 3 todos via the UI
/// 3. Verify they are rendered in the list
///
/// **Success Criteria:**
/// - App launches without errors
/// - 3 todos can be created successfully via UI
/// - All 3 todos appear in the list on the Tasks screen

/// Helper function to clear all todos from storage.
Future<void> _clearAllTodos() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('todos');
}

/// Helper function to get current todo count.
Future<int> _getTodoCount() async {
  final prefs = await SharedPreferences.getInstance();
  final todosJson = prefs.getString('todos');
  if (todosJson == null || todosJson.isEmpty) {
    return 0;
  }
  // Simple count - count the number of "id" occurrences (rough estimate)
  // For a more accurate count, we'd need to parse JSON, but this works for our purpose
  return todosJson.split('"id"').length - 1;
}

/// Helper function to create a todo via the UI.
Future<void> _createTodo(WidgetTester tester, String title) async {
  // Wait for the UI to be ready
  await tester.pumpAndSettle();

  // Tap the "Add Todo" button
  final addButton = find.text('Add Todo');
  await tester.ensureVisible(addButton);
  await tester.pumpAndSettle();

  expect(addButton, findsOneWidget);
  await tester.tap(addButton);
  await tester.pumpAndSettle(const Duration(milliseconds: 500));

  // Wait for dialog to appear
  await tester.pumpAndSettle();

  // Fill in the todo title
  final titleField = find.byType(TextFormField).first;
  await tester.ensureVisible(titleField);
  await tester.pumpAndSettle();

  await tester.enterText(titleField, title);
  await tester.pumpAndSettle();
  // ignore: avoid_print
  print('titleField: $titleField');

  // Tap Save button
  final saveButton = find.text('Save');
  await tester.ensureVisible(saveButton);
  await tester.pumpAndSettle();

  expect(saveButton, findsOneWidget);
  await tester.tap(saveButton);

  // Wait for dialog to close and UI to update
  await tester.pumpAndSettle(const Duration(seconds: 2));

  // Additional wait to ensure state is updated
  await tester.pump(const Duration(milliseconds: 500));
  await tester.pumpAndSettle();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Todo Feature Integration Test on Device', () {
    setUp(() async {
      // Clear all todos before each test to ensure clean state
      await _clearAllTodos();
    });

    testWidgets('should create 3 todos via UI and render them in the list',
        (WidgetTester tester) async {
      // Arrange - Clear todos and launch the app
      await _clearAllTodos();
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify app launched and Tasks screen is displayed
      expect(find.byType(TasksScreen), findsOneWidget);
      expect(find.text('Tasks'), findsOneWidget);

      // Verify we start with 0 todos
      final initialCount = await _getTodoCount();
      expect(initialCount, 0);

      // Act - Create first todo
      await _createTodo(tester, 'Write tomorrow\'s TODO');

      // Verify first todo appears
      await tester.pumpAndSettle();
      expect(find.text('Write tomorrow\'s TODO'), findsOneWidget);

      // Act - Create second todo
      await _createTodo(tester, 'Read Atomic Habits');

      // Verify second todo appears
      await tester.pumpAndSettle();
      expect(find.text('Read Atomic Habits'), findsOneWidget);

      // Act - Create third todo
      await _createTodo(tester, 'Exercise for 30 minutes');

      // Wait for UI to fully update
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Assert - Verify all 3 todos are displayed in the UI
      expect(find.text('Write tomorrow\'s TODO'), findsOneWidget);
      expect(find.text('Read Atomic Habits'), findsOneWidget);
      expect(find.text('Exercise for 30 minutes'), findsOneWidget);

      // Verify exactly 3 todo cards are rendered
      expect(find.byType(TodoCard), findsNWidgets(3));
    });

    testWidgets('should display empty state when no todos exist',
        (WidgetTester tester) async {
      // Arrange - Clear todos and launch the app
      await _clearAllTodos();
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Assert - Verify Tasks screen is displayed
      expect(find.byType(TasksScreen), findsOneWidget);
      expect(find.text('Tasks'), findsOneWidget);

      // Verify no todos exist
      final todoCount = await _getTodoCount();
      expect(todoCount, 0);

      // The UI should show empty state or be ready for todos
      await tester.pumpAndSettle();

      // Check that either empty state is shown or no todo cards exist
      final todoCards = find.byType(TodoCard);
      expect(todoCards, findsNothing);
    });

    testWidgets('should create todo via UI and verify it appears',
        (WidgetTester tester) async {
      // Arrange - Clear todos and launch the app
      await _clearAllTodos();
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify Tasks screen is displayed
      expect(find.byType(TasksScreen), findsOneWidget);
      expect(find.text('Tasks'), findsOneWidget);

      // Get initial count
      final initialCount = await _getTodoCount();

      // Act - Create a todo via UI
      await _createTodo(tester, 'Test Todo from UI');

      // Wait for UI to update
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Assert - Verify the todo appears in the list
      expect(find.text('Test Todo from UI'), findsOneWidget);

      // Verify at least one todo card exists (could be more if there were existing ones)
      final todoCards = find.byType(TodoCard);
      expect(todoCards, findsAtLeastNWidgets(1));

      // Verify the count increased
      final finalCount = await _getTodoCount();
      expect(finalCount, greaterThan(initialCount));
    });
  });
}
