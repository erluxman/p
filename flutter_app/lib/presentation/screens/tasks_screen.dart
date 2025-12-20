import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/todo_providers.dart';
import '../state/todo_state.dart';
import '../widgets/add_todo_dialog.dart';
import '../widgets/day_progress_indicator.dart';
import '../widgets/todo_card.dart';

/// Main screen for displaying and managing todos.
///
/// Shows a list of todos with day progress indicators, and provides
/// functionality to create, update, and delete todos.
///
/// **Features:**
/// - Day progress indicators for the week
/// - List of todos with completion status
/// - Add todo button
/// - Profile and trophy icons (placeholder)
///
/// **Example:**
/// ```dart
/// TasksScreen()
/// ```
class TasksScreen extends ConsumerWidget {
  /// Creates a new [TasksScreen] instance.
  const TasksScreen({super.key});

  /// Handles updating todo completion status.
  Future<void> _toggleTodoCompletion(
    WidgetRef ref,
    String todoId,
    bool newStatus,
  ) async {
    try {
      final updateUseCase = await ref.read(updateTodoUseCaseProvider.future);
      await updateUseCase.execute(
        id: todoId,
        isCompleted: newStatus,
      );
      // Refresh the todos list
      ref.read(todosStateProvider.notifier).refresh();
    } catch (e) {
      // Error handling could be improved with a snackbar
      debugPrint('Error updating todo: $e');
    }
  }

  /// Shows the add todo dialog.
  void _showAddTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddTodoDialog(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosState = ref.watch(todosStateProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Profile picture placeholder
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Tasks',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Trophy icon placeholder
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '5',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Day progress indicators
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: DayProgressIndicator(),
            ),
            // Todos list
            Expanded(
              child: _buildTodosList(context, ref, todosState),
            ),
          ],
        ),
      ),
      // Bottom navigation
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Home icon
            IconButton(
              icon: const Icon(Icons.home, size: 28),
              onPressed: () {},
              color: Colors.grey,
            ),
            // Add Todo button
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  onPressed: () => _showAddTodoDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Add Todo',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Menu icon
            IconButton(
              icon: const Icon(Icons.menu, size: 28),
              onPressed: () {},
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the todos list based on the current state.
  Widget _buildTodosList(
    BuildContext context,
    WidgetRef ref,
    TodoState state,
  ) {
    if (state is TodoLoadingState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is TodoErrorState) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error: ${state.message}',
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(todosStateProvider.notifier).refresh(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state is TodoSuccessState) {
      final todos = state.todos;

      if (todos.isEmpty) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.task_alt, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No todos yet',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Tap "Add Todo" to create your first todo',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () => ref.read(todosStateProvider.notifier).refresh(),
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return TodoCard(
              todo: todo,
              onCheckboxChanged: (value) {
                _toggleTodoCompletion(ref, todo.id, value);
              },
            );
          },
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
