import { beforeEach, describe, expect, it, vi } from "vitest";
import { CreateTodoUseCase } from "../../../../src/core/application/use_cases/create_todo_use_case";
import type { TodoEntity } from "../../../../src/core/domain/entities/todo_entity";
import type { TodoRepository } from "../../../../src/core/domain/repositories/todo_repository";
import { Priority } from "../../../../src/core/domain/value_objects/priority";

describe("CreateTodoUseCase", () => {
  let mockRepository: TodoRepository;
  let useCase: CreateTodoUseCase;

  beforeEach(() => {
    mockRepository = {
      findAll: vi.fn(),
      findById: vi.fn(),
      create: vi.fn(),
      update: vi.fn(),
      delete: vi.fn(),
    };
    useCase = new CreateTodoUseCase(mockRepository);
  });

  it("should create todo with valid input", async () => {
    const mockTodo: TodoEntity = {
      id: "test-id",
      title: "Test Todo",
      description: "Test Description",
      priority: Priority.MEDIUM,
      completed: false,
      createdAt: "2024-01-01T00:00:00.000Z",
      updatedAt: "2024-01-01T00:00:00.000Z",
    };

    vi.mocked(mockRepository.create).mockResolvedValue(mockTodo);

    const result = await useCase.execute({
      title: "Test Todo",
      description: "Test Description",
      priority: Priority.MEDIUM,
    });

    expect(result.success).toBe(true);
    if (result.success) {
      expect(result.data.title).toBe("Test Todo");
      expect(mockRepository.create).toHaveBeenCalled();
    }
  });

  it("should fail when title is empty", async () => {
    const result = await useCase.execute({ title: "" });

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error).toBe("Title is required");
    }
    expect(mockRepository.create).not.toHaveBeenCalled();
  });

  it("should fail when title is too long", async () => {
    const longTitle = "a".repeat(201);
    const result = await useCase.execute({ title: longTitle });

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error).toBe("Title must not exceed 200 characters");
    }
  });

  it("should fail when description is too long", async () => {
    const longDescription = "a".repeat(1001);
    const result = await useCase.execute({
      title: "Test",
      description: longDescription,
    });

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error).toBe("Description must not exceed 1000 characters");
    }
  });

  it("should fail when due date is in the past", async () => {
    const pastDate = new Date("2020-01-01").toISOString();
    const result = await useCase.execute({
      title: "Test",
      dueDate: pastDate,
    });

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error).toBe("Due date must be in the future");
    }
  });

  it("should use default priority when not provided", async () => {
    const mockTodo: TodoEntity = {
      id: "test-id",
      title: "Test Todo",
      priority: Priority.MEDIUM,
      completed: false,
      createdAt: "2024-01-01T00:00:00.000Z",
      updatedAt: "2024-01-01T00:00:00.000Z",
    };

    vi.mocked(mockRepository.create).mockResolvedValue(mockTodo);

    const result = await useCase.execute({ title: "Test Todo" });

    expect(result.success).toBe(true);
    if (result.success) {
      expect(result.data.priority).toBe(Priority.MEDIUM);
    }
  });
});
