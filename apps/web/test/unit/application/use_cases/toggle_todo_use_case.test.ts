import { beforeEach, describe, expect, it, vi } from "vitest";
import { ToggleTodoUseCase } from "../../../../src/core/application/use_cases/toggle_todo_use_case";
import type { TodoEntity } from "../../../../src/core/domain/entities/todo_entity";
import type { TodoRepository } from "../../../../src/core/domain/repositories/todo_repository";
import { Priority } from "../../../../src/core/domain/value_objects/priority";

describe("ToggleTodoUseCase", () => {
  let mockRepository: TodoRepository;
  let useCase: ToggleTodoUseCase;

  beforeEach(() => {
    mockRepository = {
      findAll: vi.fn(),
      findById: vi.fn(),
      create: vi.fn(),
      update: vi.fn(),
      delete: vi.fn(),
    };
    useCase = new ToggleTodoUseCase(mockRepository);
  });

  it("should toggle todo from incomplete to completed", async () => {
    const existing: TodoEntity = {
      id: "test-id",
      title: "Test Todo",
      priority: Priority.MEDIUM,
      completed: false,
      createdAt: "2024-01-01T00:00:00.000Z",
      updatedAt: "2024-01-01T00:00:00.000Z",
    };

    const updated: TodoEntity = {
      ...existing,
      completed: true,
      updatedAt: "2024-01-02T00:00:00.000Z",
    };

    vi.mocked(mockRepository.findById).mockResolvedValue(existing);
    vi.mocked(mockRepository.update).mockResolvedValue(updated);

    const result = await useCase.execute("test-id");

    expect(result.success).toBe(true);
    if (result.success) {
      expect(result.data.completed).toBe(true);
      expect(mockRepository.update).toHaveBeenCalled();
    }
  });

  it("should toggle todo from completed to incomplete", async () => {
    const existing: TodoEntity = {
      id: "test-id",
      title: "Test Todo",
      priority: Priority.MEDIUM,
      completed: true,
      createdAt: "2024-01-01T00:00:00.000Z",
      updatedAt: "2024-01-01T00:00:00.000Z",
    };

    const updated: TodoEntity = {
      ...existing,
      completed: false,
      updatedAt: "2024-01-02T00:00:00.000Z",
    };

    vi.mocked(mockRepository.findById).mockResolvedValue(existing);
    vi.mocked(mockRepository.update).mockResolvedValue(updated);

    const result = await useCase.execute("test-id");

    expect(result.success).toBe(true);
    if (result.success) {
      expect(result.data.completed).toBe(false);
    }
  });

  it("should fail when todo not found", async () => {
    vi.mocked(mockRepository.findById).mockResolvedValue(null);

    const result = await useCase.execute("non-existent");

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error).toBe("Todo not found");
    }
  });
});
