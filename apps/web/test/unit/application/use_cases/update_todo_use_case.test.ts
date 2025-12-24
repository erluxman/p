import { beforeEach, describe, expect, it, vi } from "vitest";
import { UpdateTodoUseCase } from "../../../../src/core/application/use_cases/update_todo_use_case";
import type { TodoEntity } from "../../../../src/core/domain/entities/todo_entity";
import type { TodoRepository } from "../../../../src/core/domain/repositories/todo_repository";
import { Priority } from "../../../../src/core/domain/value_objects/priority";

describe("UpdateTodoUseCase", () => {
  let mockRepository: TodoRepository;
  let useCase: UpdateTodoUseCase;

  beforeEach(() => {
    mockRepository = {
      findAll: vi.fn(),
      findById: vi.fn(),
      create: vi.fn(),
      update: vi.fn(),
      delete: vi.fn(),
    };
    useCase = new UpdateTodoUseCase(mockRepository);
  });

  it("should update todo with valid input", async () => {
    const existing: TodoEntity = {
      id: "test-id",
      title: "Original",
      priority: Priority.MEDIUM,
      completed: false,
      createdAt: "2024-01-01T00:00:00.000Z",
      updatedAt: "2024-01-01T00:00:00.000Z",
    };

    const updated: TodoEntity = {
      ...existing,
      title: "Updated",
      updatedAt: "2024-01-02T00:00:00.000Z",
    };

    vi.mocked(mockRepository.findById).mockResolvedValue(existing);
    vi.mocked(mockRepository.update).mockResolvedValue(updated);

    const result = await useCase.execute("test-id", { title: "Updated" });

    expect(result.success).toBe(true);
    if (result.success) {
      expect(result.data.title).toBe("Updated");
      expect(mockRepository.update).toHaveBeenCalled();
    }
  });

  it("should fail when todo not found", async () => {
    vi.mocked(mockRepository.findById).mockResolvedValue(null);

    const result = await useCase.execute("non-existent", { title: "Updated" });

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error).toBe("Todo not found");
    }
  });

  it("should fail when id is empty", async () => {
    const result = await useCase.execute("", { title: "Updated" });

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error).toBe("Todo ID is required");
    }
  });
});
