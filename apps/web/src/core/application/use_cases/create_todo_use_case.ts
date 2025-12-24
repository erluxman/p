import { v4 as uuidv4 } from "uuid";
import type { TodoEntity } from "../../domain/entities/todo_entity";
import type { TodoRepository } from "../../domain/repositories/todo_repository";
import type { CreateTodoDto } from "../dto/create_todo_dto";
import { TodoMapper } from "../mappers/todo_mapper";
import type { Result } from "../types/result";
import { createFailure, createSuccess } from "../types/result";

export class CreateTodoUseCase {
  private readonly repository: TodoRepository;

  constructor(repository: TodoRepository) {
    this.repository = repository;
  }

  async execute(dto: CreateTodoDto): Promise<Result<TodoEntity, string>> {
    const validationError = this.validate(dto);
    if (validationError) {
      return createFailure(validationError);
    }

    try {
      const now = new Date().toISOString();
      const id = uuidv4();
      const todo = TodoMapper.toEntityFromCreateDto(dto, id, now);
      const created = await this.repository.create(todo);
      return createSuccess(created);
    } catch (error) {
      return createFailure("Failed to create todo");
    }
  }

  private validate(dto: CreateTodoDto): string | null {
    const title = dto.title?.trim();

    if (!title) {
      return "Title is required";
    }

    if (title.length < 1) {
      return "Title must be at least 1 character";
    }

    if (title.length > 200) {
      return "Title must not exceed 200 characters";
    }

    if (dto.description && dto.description.length > 1000) {
      return "Description must not exceed 1000 characters";
    }

    if (dto.dueDate) {
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
