import type { TodoEntity } from "../../domain/entities/todo_entity";
import type { TodoRepository } from "../../domain/repositories/todo_repository";
import type { UpdateTodoDto } from "../dto/update_todo_dto";
import { TodoMapper } from "../mappers/todo_mapper";
import type { Result } from "../types/result";
import { createFailure, createSuccess } from "../types/result";

export class UpdateTodoUseCase {
  private readonly repository: TodoRepository;

  constructor(repository: TodoRepository) {
    this.repository = repository;
  }

  async execute(
    id: string,
    dto: UpdateTodoDto
  ): Promise<Result<TodoEntity, string>> {
    if (!id.trim()) {
      return createFailure("Todo ID is required");
    }

    try {
      const existing = await this.repository.findById(id);
      if (!existing) {
        return createFailure("Todo not found");
      }

      const validationError = this.validate(dto, existing);
      if (validationError) {
        return createFailure(validationError);
      }

      const now = new Date().toISOString();
      const updated = TodoMapper.toEntityFromUpdateDto(existing, dto, now);
      const saved = await this.repository.update(updated);
      return createSuccess(saved);
    } catch (error) {
      return createFailure("Failed to update todo");
    }
  }

  private validate(dto: UpdateTodoDto, _existing: TodoEntity): string | null {
    if (dto.title !== undefined) {
      const title = dto.title.trim();
      if (title.length < 1) {
        return "Title must be at least 1 character";
      }
      if (title.length > 200) {
        return "Title must not exceed 200 characters";
      }
    }

    if (dto.description !== undefined && dto.description.length > 1000) {
      return "Description must not exceed 1000 characters";
    }

    if (dto.dueDate !== undefined && dto.dueDate !== null) {
      const dueDate = new Date(dto.dueDate);
      if (isNaN(dueDate.getTime())) {
        return "Invalid due date format";
      }
      const now = new Date();
      if (dueDate < now) {
        return "Due date must be in the future";
      }
    }

    return null;
  }
}
