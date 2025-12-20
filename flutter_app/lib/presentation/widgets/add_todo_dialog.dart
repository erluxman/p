import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/domain/entities/todo_icon_type.dart';
import '../state/todo_providers.dart';

/// Dialog for creating or editing a todo.
///
/// Provides a form with fields for title, description, deadline, and icon type.
/// Can be used for both creating new todos and editing existing ones.
///
/// **Example:**
/// ```dart
/// showDialog(
///   context: context,
///   builder: (context) => AddTodoDialog(),
/// );
/// ```
class AddTodoDialog extends ConsumerStatefulWidget {
  /// Optional initial title (for editing).
  final String? initialTitle;

  /// Optional initial description (for editing).
  final String? initialDescription;

  /// Optional initial deadline (for editing).
  final DateTime? initialDeadline;

  /// Optional initial icon type (for editing).
  final TodoIconType? initialIconType;

  /// Creates a new [AddTodoDialog] instance.
  ///
  /// **Parameters:**
  /// - `initialTitle`: Initial title value (for editing)
  /// - `initialDescription`: Initial description value (for editing)
  /// - `initialDeadline`: Initial deadline value (for editing)
  /// - `initialIconType`: Initial icon type (for editing)
  const AddTodoDialog({
    super.key,
    this.initialTitle,
    this.initialDescription,
    this.initialDeadline,
    this.initialIconType,
  });

  @override
  ConsumerState<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends ConsumerState<AddTodoDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime? _selectedDeadline;
  TodoIconType _selectedIconType = TodoIconType.defaultIcon;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _descriptionController =
        TextEditingController(text: widget.initialDescription);
    _selectedDeadline = widget.initialDeadline;
    _selectedIconType = widget.initialIconType ?? TodoIconType.defaultIcon;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDeadline() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDeadline ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      final TimeOfDay? time = await showTimePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: _selectedDeadline != null
            ? TimeOfDay.fromDateTime(_selectedDeadline!)
            : TimeOfDay.now(),
      );
      if (time != null) {
        setState(() {
          _selectedDeadline = DateTime(
            picked.year,
            picked.month,
            picked.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  void _saveTodo() async {
    if (_formKey.currentState!.validate()) {
      try {
        final createUseCase = await ref.read(createTodoUseCaseProvider.future);
        await createUseCase.execute(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
          deadline: _selectedDeadline,
          iconType: _selectedIconType,
        );

        // Refresh the todos list
        ref.read(todosStateProvider.notifier).refresh();

        if (!mounted) return;
        Navigator.of(context).pop();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error creating todo: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Todo'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title field
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
                autofocus: true,
              ),
              const SizedBox(height: 16),
              // Description field
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              // Deadline picker
              ListTile(
                title: const Text('Deadline'),
                subtitle: Text(
                  _selectedDeadline != null
                      ? '${_selectedDeadline!.month}/${_selectedDeadline!.day} ${_selectedDeadline!.hour}:${_selectedDeadline!.minute.toString().padLeft(2, '0')}'
                      : 'No deadline',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: _selectDeadline,
              ),
              const SizedBox(height: 16),
              // Icon type selector
              DropdownButtonFormField<TodoIconType>(
                initialValue: _selectedIconType,
                decoration: const InputDecoration(
                  labelText: 'Icon Type',
                  border: OutlineInputBorder(),
                ),
                items: TodoIconType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.name),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedIconType = value;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveTodo,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
