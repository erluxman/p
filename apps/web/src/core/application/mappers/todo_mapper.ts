import type { TodoEntity } from "../../domain/entities/todo_entity";
import { Priority } from "../../domain/value_objects/priority";
import type { CreateTodoDto } from "../dto/create_todo_dto";
import type { UpdateTodoDto } from "../dto/update_todo_dto";

export class TodoMapper {
  static toEntityFromCreateDto(
    dto: CreateTodoDto,
    id: string,
    now: string
  ): TodoEntity {
    return {
      id,
      title: dto.title.trim(),
      description: dto.description?.trim(),
      priority: dto.priority ?? Priority.MEDIUM,
      dueDate: dto.dueDate,
      completed: false,
      createdAt: now,
      updatedAt: now,
    };
  }

  static toEntityFromUpdateDto(
    existing: TodoEntity,
    dto: UpdateTodoDto,
    now: string
  ): TodoEntity {
    return {
      ...existing,
      title: dto.title !== undefined ? dto.title.trim() : existing.title,
      description:
        dto.description !== undefined
          ? dto.description.trim()
          : existing.description,
      priority: dto.priority ?? existing.priority,
      dueDate: dto.dueDate !== undefined ? dto.dueDate : existing.dueDate,
      completed:
        dto.completed !== undefined ? dto.completed : existing.completed,
      updatedAt: now,
    };
  }
}
