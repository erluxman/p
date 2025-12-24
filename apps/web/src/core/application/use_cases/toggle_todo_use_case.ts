import type { TodoEntity } from "../../domain/entities/todo_entity";
import type { TodoRepository } from "../../domain/repositories/todo_repository";
import type { Result } from "../types/result";
import { createFailure, createSuccess } from "../types/result";

export class ToggleTodoUseCase {
  private readonly repository: TodoRepository;

  constructor(repository: TodoRepository) {
    this.repository = repository;
  }

  async execute(id: string): Promise<Result<TodoEntity, string>> {
    if (!id.trim()) {
      return createFailure("Todo ID is required");
    }

    try {
      const existing = await this.repository.findById(id);
      if (!existing) {
        return createFailure("Todo not found");
      }

      const updated: TodoEntity = {
        ...existing,
        completed: !existing.completed,
        updatedAt: new Date().toISOString(),
      };

      const saved = await this.repository.update(updated);
      return createSuccess(saved);
    } catch (error) {
      return createFailure("Failed to toggle todo");
    }
  }
}
