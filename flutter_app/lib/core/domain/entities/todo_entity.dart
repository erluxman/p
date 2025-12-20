import 'package:equatable/equatable.dart';
import 'todo_icon_type.dart';

/// Represents a Todo entity in the domain layer.
///
/// This is a pure domain entity with no external dependencies,
/// following Hexagonal Architecture principles. It contains all
/// the business logic and data related to a single todo item.
///
/// **Properties:**
/// - `id`: Unique identifier for the todo
/// - `title`: The main title/description of the todo (required)
/// - `description`: Optional detailed description
/// - `deadline`: Optional deadline date and time
/// - `isCompleted`: Whether the todo has been completed
/// - `createdAt`: Timestamp when the todo was created
/// - `iconType`: Visual icon category for the todo
///
/// **Example:**
/// ```dart
/// final todo = TodoEntity(
///   id: '1',
///   title: 'Write tomorrow\'s todo',
///   deadline: DateTime(2024, 1, 15, 20, 30),
///   iconType: TodoIconType.writing,
/// );
/// ```
class TodoEntity extends Equatable {
  /// Unique identifier for the todo.
  final String id;

  /// The main title/description of the todo.
  ///
  /// This is a required field and should not be empty.
  final String title;

  /// Optional detailed description of the todo.
  final String? description;

  /// Optional deadline date and time for the todo.
  ///
  /// If null, the todo has no specific deadline.
  final DateTime? deadline;

  /// Whether the todo has been completed.
  ///
  /// Defaults to `false` (not completed).
  final bool isCompleted;

  /// Timestamp when the todo was created.
  ///
  /// This is automatically set when the todo is created.
  final DateTime createdAt;

  /// Visual icon category for the todo.
  ///
  /// Defaults to `TodoIconType.defaultIcon` if not specified.
  final TodoIconType iconType;

  /// Creates a new [TodoEntity] instance.
  ///
  /// **Parameters:**
  /// - `id`: Unique identifier (required)
  /// - `title`: Main title (required, must not be empty)
  /// - `description`: Optional detailed description
  /// - `deadline`: Optional deadline date and time
  /// - `isCompleted`: Completion status (defaults to `false`)
  /// - `createdAt`: Creation timestamp (defaults to current time)
  /// - `iconType`: Icon category (defaults to `TodoIconType.defaultIcon`)
  ///
  /// **Throws:**
  /// - `ArgumentError` if `title` is empty
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

  /// Creates a copy of this [TodoEntity] with the given fields replaced.
  ///
  /// This is useful for updating individual properties while maintaining
  /// immutability. All parameters are optional and default to the current
  /// values of this instance.
  ///
  /// **Example:**
  /// ```dart
  /// final updatedTodo = todo.copyWith(isCompleted: true);
  /// ```
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

