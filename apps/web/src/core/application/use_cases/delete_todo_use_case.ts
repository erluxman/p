import type { TodoRepository } from "../../domain/repositories/todo_repository";
import type { Result } from "../types/result";
import { createFailure, createSuccess } from "../types/result";

export class DeleteTodoUseCase {
  private readonly repository: TodoRepository;

  constructor(repository: TodoRepository) {
    this.repository = repository;
  }

  async execute(id: string): Promise<Result<void, string>> {
    if (!id.trim()) {
      return createFailure("Todo ID is required");
    }

    try {
      const existing = await this.repository.findById(id);
      if (!existing) {
        return createFailure("Todo not found");
      }

      await this.repository.delete(id);
      return createSuccess(undefined);
    } catch (error) {
      return createFailure("Failed to delete todo");
    }
  }
}
