import { Paper, Typography, Box } from "@mui/material";
import type { TodoEntity } from "../../core/domain/entities/todo_entity";
import { TodoItem } from "./todo_item";

interface TodoListProps {
  todos: TodoEntity[];
  onToggle: (id: string) => void;
  onEdit: (todo: TodoEntity) => void;
  onDelete: (id: string) => void;
}

export const TodoList = ({ todos, onToggle, onEdit, onDelete }: TodoListProps) => {
  if (todos.length === 0) {
    return (
      <Paper
        elevation={0}
        sx={{
          p: 4,
          textAlign: "center",
          backgroundColor: "background.default",
          borderRadius: 2,
        }}
      >
        <Typography variant="body1" color="text.secondary">
          No todos yet. Create your first todo!
        </Typography>
      </Paper>
    );
  }

  return (
    <Box>
      {todos.map((todo) => (
        <TodoItem
          key={todo.id}
          todo={todo}
          onToggle={onToggle}
          onEdit={onEdit}
          onDelete={onDelete}
        />
      ))}
    </Box>
  );
};
