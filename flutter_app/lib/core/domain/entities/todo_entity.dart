import 'package:equatable/equatable.dart';
import 'todo_icon_type.dart';

class TodoEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final DateTime? deadline;
  final bool isCompleted;
  final DateTime createdAt;
  final TodoIconType iconType;

  TodoEntity({
    required this.id,
    required this.title,
    this.description,
    this.deadline,
    this.isCompleted = false,
    DateTime? createdAt,
    this.iconType = TodoIconType.defaultIcon,
  })  : createdAt = createdAt ?? DateTime.now(),
        assert(title.isNotEmpty, 'Title cannot be empty');

  TodoEntity copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? deadline,
    bool? isCompleted,
    DateTime? createdAt,
    TodoIconType? iconType,
  }) {
    return TodoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      iconType: iconType ?? this.iconType,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        deadline,
        isCompleted,
        createdAt,
        iconType,
      ];

  @override
  String toString() {
    return 'TodoEntity(id: $id, title: $title, isCompleted: $isCompleted, deadline: $deadline)';
  }
}

