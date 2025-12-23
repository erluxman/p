import 'package:flutter/material.dart';
import '../../core/domain/entities/todo_entity.dart';
import '../../core/domain/entities/todo_icon_type.dart';

class TodoCard extends StatelessWidget {
  final TodoEntity todo;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onCheckboxChanged;

  const TodoCard({
    super.key,
    required this.todo,
    this.onTap,
    this.onCheckboxChanged,
  });

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

  String _formatDeadline(DateTime deadline) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final deadlineDate = DateTime(deadline.year, deadline.month, deadline.day);

    if (deadlineDate == today) {
      final hour = deadline.hour;
      final minute = deadline.minute;
      final period = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return '$displayHour:${minute.toString().padLeft(2, '0')} $period';
    } else {
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
              _getIconWidget(),
              const SizedBox(width: 16),
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

