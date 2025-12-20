import 'package:flutter/material.dart';

class DayProgressIndicator extends StatelessWidget {
  final DateTime currentDay;
  final List<DateTime> completedDays;

  DayProgressIndicator({
    super.key,
    DateTime? currentDay,
    this.completedDays = const [],
  }) : currentDay = currentDay ?? DateTime.now();

  int _getDayOfWeekIndex(DateTime date) {
    return date.weekday - 1;
  }

  String _getDayAbbreviation(int dayIndex) {
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return days[dayIndex];
  }

  bool _isDateCompleted(DateTime date) {
    return completedDays.any((completed) =>
        completed.year == date.year &&
        completed.month == date.month &&
        completed.day == date.day);
  }

  bool _isCurrentDay(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  Color _getDayColor(DateTime date) {
    if (_isDateCompleted(date)) {
      return Colors.green;
    } else if (_isCurrentDay(date)) {
      return Colors.blue;
    } else {
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

  double _getDayProgress(DateTime date) {
    if (_isDateCompleted(date)) {
      return 1.0;
    } else if (_isCurrentDay(date)) {
      return 0.5;
    } else {
      return 0.3;
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
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
                Text(
                  _getDayAbbreviation(dayIndex),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
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
