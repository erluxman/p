import type { TodoEntity } from "../../domain/entities/todo_entity";
import type { TodoRepository } from "../../domain/repositories/todo_repository";
import type { Result } from "../types/result";
import { createFailure, createSuccess } from "../types/result";

export class GetAllTodosUseCase {
  private readonly repository: TodoRepository;

  constructor(repository: TodoRepository) {
    this.repository = repository;
  }

  async execute(): Promise<Result<TodoEntity[], string>> {
    try {
      const todos = await this.repository.findAll();
      const sorted = this.sortTodos(todos);
      return createSuccess(sorted);
    } catch (error) {
      return createFailure("Failed to fetch todos");
    }
  }

  private sortTodos(todos: TodoEntity[]): TodoEntity[] {
    const incomplete = todos.filter((t) => !t.completed);
    const completed = todos.filter((t) => t.completed);

    const sortByDueDate = (a: TodoEntity, b: TodoEntity): number => {
      if (!a.dueDate && !b.dueDate) return 0;
      if (!a.dueDate) return 1;
      if (!b.dueDate) return -1;
      return new Date(a.dueDate).getTime() - new Date(b.dueDate).getTime();
    };

    incomplete.sort(sortByDueDate);
    completed.sort(sortByDueDate);

    return [...incomplete, ...completed];
  }
}
