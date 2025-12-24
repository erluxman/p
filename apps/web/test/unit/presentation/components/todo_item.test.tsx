import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { describe, expect, it, vi } from "vitest";
import type { TodoEntity } from "../../../../src/core/domain/entities/todo_entity";
import { Priority } from "../../../../src/core/domain/value_objects/priority";
import { TodoItem } from "../../../../src/presentation/components/todo_item";

describe("TodoItem", () => {
  const mockTodo: TodoEntity = {
    id: "test-id",
    title: "Test Todo",
    description: "Test Description",
    priority: Priority.MEDIUM,
    completed: false,
    createdAt: "2024-01-01T00:00:00.000Z",
    updatedAt: "2024-01-01T00:00:00.000Z",
  };

  it("should render todo item with title and description", () => {
    const onToggle = vi.fn();
    const onEdit = vi.fn();
    const onDelete = vi.fn();

    render(
      <TodoItem
        todo={mockTodo}
        onToggle={onToggle}
        onEdit={onEdit}
        onDelete={onDelete}
      />
    );

    expect(screen.getByText("Test Todo")).toBeInTheDocument();
    expect(screen.getByText("Test Description")).toBeInTheDocument();
  });

  it("should call onToggle when checkbox is clicked", async () => {
    const user = userEvent.setup();
    const onToggle = vi.fn();
    const onEdit = vi.fn();
    const onDelete = vi.fn();

    render(
      <TodoItem
        todo={mockTodo}
        onToggle={onToggle}
        onEdit={onEdit}
        onDelete={onDelete}
      />
    );

    const checkbox = screen.getByRole("checkbox");
    await user.click(checkbox);

    expect(onToggle).toHaveBeenCalledWith("test-id");
  });

  it("should call onEdit when edit button is clicked", async () => {
    const user = userEvent.setup();
    const onToggle = vi.fn();
    const onEdit = vi.fn();
    const onDelete = vi.fn();

    render(
      <TodoItem
        todo={mockTodo}
        onToggle={onToggle}
        onEdit={onEdit}
        onDelete={onDelete}
      />
    );

    const editButtons = screen.getAllByRole("button");
    const editButton = editButtons.find((btn) => btn.querySelector("svg"));
    if (editButton) {
      await user.click(editButton);
    }

    expect(onEdit).toHaveBeenCalled();
  });

  it("should show completed state", () => {
    const completedTodo: TodoEntity = {
      ...mockTodo,
      completed: true,
    };

    const onToggle = vi.fn();
    const onEdit = vi.fn();
    const onDelete = vi.fn();

    render(
      <TodoItem
        todo={completedTodo}
        onToggle={onToggle}
        onEdit={onEdit}
        onDelete={onDelete}
      />
    );

    const checkbox = screen.getByRole("checkbox");
    expect(checkbox).toBeChecked();
  });
});
