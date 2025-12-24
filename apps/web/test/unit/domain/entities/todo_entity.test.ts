import { describe, expect, it } from "vitest";
import type { TodoEntity } from "../../../../src/core/domain/entities/todo_entity";
import { Priority } from "../../../../src/core/domain/value_objects/priority";

describe("TodoEntity", () => {
  it("should have all required fields", () => {
    const todo: TodoEntity = {
      id: "test-id",
      title: "Test Todo",
      description: "Test Description",
      priority: Priority.HIGH,
      dueDate: "2024-12-31T00:00:00.000Z",
      completed: false,
      createdAt: "2024-01-01T00:00:00.000Z",
      updatedAt: "2024-01-01T00:00:00.000Z",
    };

    expect(todo.id).toBe("test-id");
    expect(todo.title).toBe("Test Todo");
    expect(todo.description).toBe("Test Description");
    expect(todo.priority).toBe(Priority.HIGH);
    expect(todo.dueDate).toBe("2024-12-31T00:00:00.000Z");
    expect(todo.completed).toBe(false);
    expect(todo.createdAt).toBe("2024-01-01T00:00:00.000Z");
    expect(todo.updatedAt).toBe("2024-01-01T00:00:00.000Z");
  });

  it("should allow optional fields to be undefined", () => {
    const todo: TodoEntity = {
      id: "test-id",
      title: "Test Todo",
      priority: Priority.MEDIUM,
      completed: false,
      createdAt: "2024-01-01T00:00:00.000Z",
      updatedAt: "2024-01-01T00:00:00.000Z",
    };

    expect(todo.description).toBeUndefined();
    expect(todo.dueDate).toBeUndefined();
  });
});
