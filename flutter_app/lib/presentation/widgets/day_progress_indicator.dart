import 'package:flutter/material.dart';

/// Widget that displays day progress indicators for the week.
///
/// Shows 7 circular indicators representing each day of the week,
/// with visual feedback for completion status. The current day
/// is highlighted with a dashed border.
///
/// **Example:**
/// ```dart
/// DayProgressIndicator(
///   currentDay: DateTime.now(),
///   completedDays: [DateTime(2024, 1, 1), DateTime(2024, 1, 2)],
/// )
/// ```
class DayProgressIndicator extends StatelessWidget {
  /// The current day to highlight.
  final DateTime currentDay;

  /// List of dates that have been completed.
  ///
  /// Used to determine which days show as completed (green with full arc).
  final List<DateTime> completedDays;

  /// Creates a new [DayProgressIndicator] instance.
  ///
  /// **Parameters:**
  /// - `currentDay`: The current day (defaults to today)
  /// - `completedDays`: List of completed dates (defaults to empty)
  DayProgressIndicator({
    super.key,
    DateTime? currentDay,
    this.completedDays = const [],
  }) : currentDay = currentDay ?? DateTime.now();

  /// Gets the day of week index (0 = Monday, 6 = Sunday).
  int _getDayOfWeekIndex(DateTime date) {
    // Convert to Monday = 0, Sunday = 6
    int day = date.weekday - 1;
    return day;
  }

  /// Gets the day abbreviation (M, T, W, T, F, S, S).
  String _getDayAbbreviation(int dayIndex) {
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return days[dayIndex];
  }

  /// Checks if a date is completed (same day, ignoring time).
  bool _isDateCompleted(DateTime date) {
    return completedDays.any((completed) =>
        completed.year == date.year &&
        completed.month == date.month &&
        completed.day == date.day);
  }

  /// Checks if a date is the current day (same day, ignoring time).
  bool _isCurrentDay(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Gets the color for a day based on its status.
  Color _getDayColor(DateTime date) {
    if (_isDateCompleted(date)) {
      return Colors.green;
    } else if (_isCurrentDay(date)) {
      return Colors.blue;
    } else {
      // Calculate progress percentage (for now, simplified)
      // In a real app, this would be based on actual completion data
      final progress = _isDateCompleted(date) ? 1.0 : 0.3;
      if (progress >= 1.0) {
        return Colors.green;
      } else if (progress >= 0.5) {
        return Colors.blue;
      } else {
        return Colors.red;
      }
    }
  }

  /// Gets the progress value for a day (0.0 to 1.0).
  double _getDayProgress(DateTime date) {
    if (_isDateCompleted(date)) {
      return 1.0;
    } else if (_isCurrentDay(date)) {
      return 0.5; // Partial completion for current day
    } else {
      return 0.3; // Default partial progress
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the start of the week (Monday)
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    
    // Generate 7 days starting from Monday
      final weekDays = List.generate(7, (index) {
        return startOfWeek.add(Duration(days: index));
      });

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: weekDays.map((date) {
          final dayIndex = _getDayOfWeekIndex(date);
          final isCurrent = _isCurrentDay(date);
          final color = _getDayColor(date);
          final progress = _getDayProgress(date);

        return Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Progress circle
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 3,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
                // Day letter
                Text(
                  _getDayAbbreviation(dayIndex),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                // Dashed border for current day
                if (isCurrent)
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.green,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        );
      }).toList(),
    );
  }
}

