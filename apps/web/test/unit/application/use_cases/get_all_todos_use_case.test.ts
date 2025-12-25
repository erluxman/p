import { beforeEach, describe, expect, it, vi } from "vitest";
import { GetAllTodosUseCase } from "../../../../src/core/application/use_cases/get_all_todos_use_case";
import type { TodoEntity } from "../../../../src/core/domain/entities/todo_entity";
import type { TodoRepository } from "../../../../src/core/domain/repositories/todo_repository";
import { Priority } from "../../../../src/core/domain/value_objects/priority";

describe("GetAllTodosUseCase", () => {
  let mockRepository: TodoRepository;
  let useCase: GetAllTodosUseCase;

  beforeEach(() => {
    mockRepository = {
      findAll: vi.fn(),
      findById: vi.fn(),
      create: vi.fn(),
      update: vi.fn(),
      delete: vi.fn(),
    };
    useCase = new GetAllTodosUseCase(mockRepository);
  });

  it("should return all todos sorted by due date with completed at bottom", async () => {
    const todos: TodoEntity[] = [
      {
        id: "1",
        title: "Todo 1",
        priority: Priority.MEDIUM,
        dueDate: "2024-12-31T00:00:00.000Z",
        completed: false,
        createdAt: "2024-01-01T00:00:00.000Z",
        updatedAt: "2024-01-01T00:00:00.000Z",
      },
      {
        id: "2",
        title: "Todo 2",
        priority: Priority.MEDIUM,
        dueDate: "2024-12-30T00:00:00.000Z",
        completed: true,
        createdAt: "2024-01-01T00:00:00.000Z",
        updatedAt: "2024-01-01T00:00:00.000Z",
      },
      {
        id: "3",
        title: "Todo 3",
        priority: Priority.MEDIUM,
        dueDate: "2024-12-29T00:00:00.000Z",
        completed: false,
        createdAt: "2024-01-01T00:00:00.000Z",
        updatedAt: "2024-01-01T00:00:00.000Z",
      },
    ];

    vi.mocked(mockRepository.findAll).mockResolvedValue(todos);

    const result = await useCase.execute();

    expect(result.success).toBe(true);
    if (result.success) {
      expect(result.data).toHaveLength(3);
      expect(result.data[0].id).toBe("3");
      expect(result.data[1].id).toBe("1");
      expect(result.data[2].id).toBe("2");
    }
  });

  it("should return empty array when no todos", async () => {
    vi.mocked(mockRepository.findAll).mockResolvedValue([]);

    const result = await useCase.execute();

    expect(result.success).toBe(true);
    if (result.success) {
      expect(result.data).toEqual([]);
    }
  });
});




