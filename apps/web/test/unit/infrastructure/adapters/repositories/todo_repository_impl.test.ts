import { beforeEach, describe, expect, it } from "vitest";
import type { TodoEntity } from "../../../../../src/core/domain/entities/todo_entity";
import { Priority } from "../../../../../src/core/domain/value_objects/priority";
import { TodoRepositoryImpl } from "../../../../../src/infrastructure/adapters/repositories/todo_repository_impl";
import { LocalStorageAdapter } from "../../../../../src/infrastructure/data/local/local_storage_adapter";

describe("TodoRepositoryImpl", () => {
  let repository: TodoRepositoryImpl;
  let mockStorage: LocalStorageAdapter;

  beforeEach(() => {
    localStorage.clear();
    mockStorage = new LocalStorageAdapter();
    repository = new TodoRepositoryImpl(mockStorage);
  });

  it("should create a todo", async () => {
    const todo: TodoEntity = {
      id: "test-id",
      title: "Test Todo",
      priority: Priority.MEDIUM,
      completed: false,
      createdAt: "2024-01-01T00:00:00.000Z",
      updatedAt: "2024-01-01T00:00:00.000Z",
    };

    const created = await repository.create(todo);

    expect(created).toEqual(todo);
    const stored = mockStorage.getItem<TodoEntity[]>("todos");
    expect(stored).toHaveLength(1);
    expect(stored?.[0]).toEqual(todo);
  });

  it("should get all todos", async () => {
    const todo1: TodoEntity = {
      id: "id-1",
      title: "Todo 1",
      priority: Priority.LOW,
      completed: false,
      createdAt: "2024-01-01T00:00:00.000Z",
      updatedAt: "2024-01-01T00:00:00.000Z",
    };

    const todo2: TodoEntity = {
      id: "id-2",
      title: "Todo 2",
      priority: Priority.HIGH,
      completed: false,
      createdAt: "2024-01-01T00:00:00.000Z",
      updatedAt: "2024-01-01T00:00:00.000Z",
    };

    await repository.create(todo1);
    await repository.create(todo2);

    const all = await repository.findAll();

    expect(all).toHaveLength(2);
    expect(all).toContainEqual(todo1);
    expect(all).toContainEqual(todo2);
  });

  it("should update a todo", async () => {
    const todo: TodoEntity = {
      id: "test-id",
      title: "Original",
      priority: Priority.MEDIUM,
      completed: false,
      createdAt: "2024-01-01T00:00:00.000Z",
      updatedAt: "2024-01-01T00:00:00.000Z",
    };

    await repository.create(todo);

    const updated: TodoEntity = {
      ...todo,
      title: "Updated",
      updatedAt: "2024-01-02T00:00:00.000Z",
    };

    const result = await repository.update(updated);

    expect(result.title).toBe("Updated");
    const stored = await repository.findById("test-id");
    expect(stored?.title).toBe("Updated");
  });

  it("should delete a todo", async () => {
    const todo: TodoEntity = {
      id: "test-id",
      title: "Test Todo",
      priority: Priority.MEDIUM,
      completed: false,
      createdAt: "2024-01-01T00:00:00.000Z",
      updatedAt: "2024-01-01T00:00:00.000Z",
    };

    await repository.create(todo);
    await repository.delete("test-id");

    const found = await repository.findById("test-id");
    expect(found).toBeNull();
  });

  it("should get todo by id", async () => {
    const todo: TodoEntity = {
      id: "test-id",
      title: "Test Todo",
      priority: Priority.MEDIUM,
      completed: false,
      createdAt: "2024-01-01T00:00:00.000Z",
      updatedAt: "2024-01-01T00:00:00.000Z",
    };

    await repository.create(todo);

    const found = await repository.findById("test-id");

    expect(found).toEqual(todo);
  });

  it("should return null when todo not found", async () => {
    const found = await repository.findById("non-existent");

    expect(found).toBeNull();
  });
});
