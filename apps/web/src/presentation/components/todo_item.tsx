import { useState } from "react";
import {
  Card,
  CardContent,
  Checkbox,
  Typography,
  Chip,
  IconButton,
  Box,
  Stack,
} from "@mui/material";
import { Edit as EditIcon, Delete as DeleteIcon, CalendarToday as CalendarIcon } from "@mui/icons-material";
import type { TodoEntity } from "../../core/domain/entities/todo_entity";
import { Priority } from "../../core/domain/value_objects/priority";
import { DeleteConfirmationDialog } from "./delete_confirmation_dialog";

interface TodoItemProps {
  todo: TodoEntity;
  onToggle: (id: string) => void;
  onEdit: (todo: TodoEntity) => void;
  onDelete: (id: string) => void;
}

export const TodoItem = ({ todo, onToggle, onEdit, onDelete }: TodoItemProps) => {
  const [deleteDialogOpen, setDeleteDialogOpen] = useState(false);

  const getPriorityColor = (priority: Priority): "default" | "warning" | "error" | "info" => {
    switch (priority) {
      case Priority.HIGH:
        return "error";
      case Priority.MEDIUM:
        return "warning";
      case Priority.LOW:
        return "info";
    }
  };

  const formatDate = (dateString?: string): string => {
    if (!dateString) return "";
    const date = new Date(dateString);
    return date.toLocaleDateString("en-US", {
      month: "short",
      day: "numeric",
      year: "numeric",
    });
  };

  return (
    <>
      <Card
        elevation={1}
        sx={{
          mb: 2,
          opacity: todo.completed ? 0.7 : 1,
          transition: "all 0.2s ease-in-out",
          "&:hover": {
            elevation: 2,
            boxShadow: 3,
          },
        }}
      >
        <CardContent sx={{ p: 2, "&:last-child": { pb: 2 } }}>
          <Stack direction="row" spacing={1} alignItems="flex-start">
            <Checkbox
              checked={todo.completed}
              onChange={() => onToggle(todo.id)}
              sx={{ mt: -1, ml: -1 }}
            />
            <Box sx={{ flex: 1, minWidth: 0 }}>
              <Typography
                variant="h6"
                component="h3"
                sx={{
                  textDecoration: todo.completed ? "line-through" : "none",
                  color: todo.completed ? "text.secondary" : "text.primary",
                  fontWeight: 500,
                  mb: 0.5,
                  wordBreak: "break-word",
                }}
              >
                {todo.title}
              </Typography>
              {todo.description && (
                <Typography
                  variant="body2"
                  color="text.secondary"
                  sx={{
                    mb: 1.5,
                    textDecoration: todo.completed ? "line-through" : "none",
                    wordBreak: "break-word",
                  }}
                >
                  {todo.description}
                </Typography>
              )}
              <Stack direction="row" spacing={1} alignItems="center" flexWrap="wrap" sx={{ gap: 1 }}>
                <Chip
                  label={todo.priority.charAt(0).toUpperCase() + todo.priority.slice(1)}
                  size="small"
                  color={getPriorityColor(todo.priority)}
                  sx={{ height: 24, fontSize: "0.75rem" }}
                />
                {todo.dueDate && (
                  <Chip
                    icon={<CalendarIcon sx={{ fontSize: "0.875rem !important" }} />}
                    label={formatDate(todo.dueDate)}
                    size="small"
                    variant="outlined"
                    sx={{ height: 24, fontSize: "0.75rem" }}
                  />
                )}
              </Stack>
            </Box>
            <Stack direction="row" spacing={0.5}>
              <IconButton
                size="small"
                onClick={() => onEdit(todo)}
                disabled={todo.completed}
                aria-label="Edit todo"
                sx={{
                  color: todo.completed ? "action.disabled" : "primary.main",
                }}
              >
                <EditIcon fontSize="small" />
              </IconButton>
              <IconButton
                size="small"
                onClick={() => setDeleteDialogOpen(true)}
                aria-label="Delete todo"
                sx={{ color: "error.main" }}
              >
                <DeleteIcon fontSize="small" />
              </IconButton>
            </Stack>
          </Stack>
        </CardContent>
      </Card>
      {deleteDialogOpen && (
        <DeleteConfirmationDialog
          open={deleteDialogOpen}
          todoTitle={todo.title}
          onConfirm={() => {
            onDelete(todo.id);
            setDeleteDialogOpen(false);
          }}
          onCancel={() => setDeleteDialogOpen(false)}
        />
      )}
    </>
  );
};
