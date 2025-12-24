import { beforeEach, describe, expect, it, vi } from "vitest";
import { DeleteTodoUseCase } from "../../../../src/core/application/use_cases/delete_todo_use_case";
import type { TodoEntity } from "../../../../src/core/domain/entities/todo_entity";
import type { TodoRepository } from "../../../../src/core/domain/repositories/todo_repository";
import { Priority } from "../../../../src/core/domain/value_objects/priority";

describe("DeleteTodoUseCase", () => {
  let mockRepository: TodoRepository;
  let useCase: DeleteTodoUseCase;

  beforeEach(() => {
    mockRepository = {
      findAll: vi.fn(),
      findById: vi.fn(),
      create: vi.fn(),
      update: vi.fn(),
      delete: vi.fn(),
    };
    useCase = new DeleteTodoUseCase(mockRepository);
  });

  it("should delete todo when found", async () => {
    const existing: TodoEntity = {
      id: "test-id",
      title: "Test Todo",
      priority: Priority.MEDIUM,
      completed: false,
      createdAt: "2024-01-01T00:00:00.000Z",
      updatedAt: "2024-01-01T00:00:00.000Z",
    };

    vi.mocked(mockRepository.findById).mockResolvedValue(existing);
    vi.mocked(mockRepository.delete).mockResolvedValue();

    const result = await useCase.execute("test-id");

    expect(result.success).toBe(true);
    expect(mockRepository.delete).toHaveBeenCalledWith("test-id");
  });

  it("should fail when todo not found", async () => {
    vi.mocked(mockRepository.findById).mockResolvedValue(null);

    const result = await useCase.execute("non-existent");

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error).toBe("Todo not found");
    }
  });

  it("should fail when id is empty", async () => {
    const result = await useCase.execute("");

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error).toBe("Todo ID is required");
    }
  });
});



