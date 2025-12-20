import 'package:flutter/material.dart';
import '../../core/domain/entities/todo_entity.dart';
import '../../core/domain/entities/todo_icon_type.dart';

/// Widget that displays a single todo item as a card.
///
/// Shows the todo's icon, title, deadline (if any), and completion status.
/// Supports tap to toggle completion and displays visual feedback.
///
/// **Example:**
/// ```dart
/// TodoCard(
///   todo: todoEntity,
///   onTap: () => toggleCompletion(todo),
/// )
/// ```
class TodoCard extends StatelessWidget {
  /// The todo entity to display.
  final TodoEntity todo;

  /// Callback when the card is tapped.
  final VoidCallback? onTap;

  /// Callback when the checkbox is tapped.
  final ValueChanged<bool>? onCheckboxChanged;

  /// Creates a new [TodoCard] instance.
  ///
  /// **Parameters:**
  /// - `todo`: The todo entity to display
  /// - `onTap`: Optional callback when card is tapped
  /// - `onCheckboxChanged`: Optional callback when checkbox changes
  const TodoCard({
    super.key,
    required this.todo,
    this.onTap,
    this.onCheckboxChanged,
  });

  /// Gets the icon widget for the todo's icon type.
  Widget _getIconWidget() {
    switch (todo.iconType) {
      case TodoIconType.writing:
        return const Icon(Icons.edit, size: 24, color: Colors.brown);
      case TodoIconType.reading:
        return const Icon(Icons.menu_book, size: 24, color: Colors.green);
      case TodoIconType.exercise:
        return const Icon(Icons.fitness_center, size: 24, color: Colors.orange);
      case TodoIconType.work:
        return const Icon(Icons.work, size: 24, color: Colors.blue);
      case TodoIconType.personal:
        return const Icon(Icons.person, size: 24, color: Colors.purple);
      case TodoIconType.shopping:
        return const Icon(Icons.shopping_cart, size: 24, color: Colors.pink);
      case TodoIconType.defaultIcon:
        return const Icon(Icons.task, size: 24, color: Colors.grey);
    }
  }

  /// Formats the deadline for display.
  String _formatDeadline(DateTime deadline) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final deadlineDate = DateTime(deadline.year, deadline.month, deadline.day);

    if (deadlineDate == today) {
      // Show time only for today
      final hour = deadline.hour;
      final minute = deadline.minute;
      final period = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return '$displayHour:${minute.toString().padLeft(2, '0')} $period';
    } else {
      // Show date and time for other days
      final month = deadline.month;
      final day = deadline.day;
      final hour = deadline.hour;
      final minute = deadline.minute;
      final period = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return '$month/$day $displayHour:${minute.toString().padLeft(2, '0')} $period';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon
              _getIconWidget(),
              const SizedBox(width: 16),
              // Title and deadline
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        decoration: todo.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                        color: todo.isCompleted
                            ? Colors.grey
                            : Colors.black,
                      ),
                    ),
                    if (todo.deadline != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.black54,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatDeadline(todo.deadline!),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              // Checkbox
              Checkbox(
                value: todo.isCompleted,
                onChanged: onCheckboxChanged != null
                    ? (value) => onCheckboxChanged!(value ?? false)
                    : null,
                activeColor: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

