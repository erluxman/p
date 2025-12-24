import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { describe, expect, it, vi } from "vitest";
import type { TodoEntity } from "../../../../src/core/domain/entities/todo_entity";
import { Priority } from "../../../../src/core/domain/value_objects/priority";
import { TodoFormModal } from "../../../../src/presentation/components/todo_form_modal";

describe("TodoFormModal", () => {
  it("should render create modal when todo is null", () => {
    const onSubmit = vi.fn().mockResolvedValue({ success: true });

    render(
      <TodoFormModal
        open={true}
        todo={null}
        onClose={vi.fn()}
        onSubmit={onSubmit}
      />
    );

    expect(screen.getByText("Create Todo")).toBeInTheDocument();
  });

  it("should render edit modal when todo is provided", () => {
    const todo: TodoEntity = {
      id: "test-id",
      title: "Test Todo",
      priority: Priority.MEDIUM,
      completed: false,
      createdAt: "2024-01-01T00:00:00.000Z",
      updatedAt: "2024-01-01T00:00:00.000Z",
    };

    const onSubmit = vi.fn().mockResolvedValue({ success: true });

    render(
      <TodoFormModal
        open={true}
        todo={todo}
        onClose={vi.fn()}
        onSubmit={onSubmit}
      />
    );

    expect(screen.getByText("Edit Todo")).toBeInTheDocument();
    expect(screen.getByDisplayValue("Test Todo")).toBeInTheDocument();
  });

  it("should call onSubmit when form is submitted", async () => {
    const user = userEvent.setup();
    const onSubmit = vi.fn().mockResolvedValue({ success: true });
    const onClose = vi.fn();

    render(
      <TodoFormModal
        open={true}
        todo={null}
        onClose={onClose}
        onSubmit={onSubmit}
      />
    );

    const titleInput = screen.getByRole("textbox", { name: /title/i });
    await user.type(titleInput, "New Todo");

    const createButton = screen.getByText("Create");
    await user.click(createButton);

    expect(onSubmit).toHaveBeenCalled();
  });

  it("should disable submit button when title is empty", () => {
    const onSubmit = vi.fn().mockResolvedValue({ success: true });

    render(
      <TodoFormModal
        open={true}
        todo={null}
        onClose={vi.fn()}
        onSubmit={onSubmit}
      />
    );

    const createButton = screen.getByText("Create");
    expect(createButton).toBeDisabled();
  });
});
