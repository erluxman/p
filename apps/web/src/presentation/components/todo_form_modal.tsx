import { useState, useEffect } from "react";
import {
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Button,
  TextField,
  MenuItem,
  Box,
  Alert,
} from "@mui/material";
import { LocalizationProvider } from "@mui/x-date-pickers/LocalizationProvider";
import { DatePicker } from "@mui/x-date-pickers/DatePicker";
import { AdapterDateFns } from "@mui/x-date-pickers/AdapterDateFns";
import type { TodoEntity } from "../../core/domain/entities/todo_entity";
import { Priority, PriorityValues } from "../../core/domain/value_objects/priority";
import type { CreateTodoDto } from "../../core/application/dto/create_todo_dto";
import type { UpdateTodoDto } from "../../core/application/dto/update_todo_dto";

interface TodoFormModalProps {
  open: boolean;
  todo?: TodoEntity | null;
  onClose: () => void;
  onSubmit: (dto: CreateTodoDto | UpdateTodoDto) => Promise<{ success: boolean; error?: string }>;
}

export const TodoFormModal = ({ open, todo, onClose, onSubmit }: TodoFormModalProps) => {
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [priority, setPriority] = useState<Priority>(Priority.MEDIUM);
  const [dueDate, setDueDate] = useState<Date | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    if (todo) {
      setTitle(todo.title);
      setDescription(todo.description || "");
      setPriority(todo.priority);
      setDueDate(todo.dueDate ? new Date(todo.dueDate) : null);
    } else {
      setTitle("");
      setDescription("");
      setPriority(Priority.MEDIUM);
      setDueDate(null);
    }
    setError(null);
  }, [todo, open]);

  const handleSubmit = async () => {
    setError(null);
    setSubmitting(true);

    const dto = todo
      ? ({
          title,
          description: description || undefined,
          priority,
          dueDate: dueDate ? dueDate.toISOString() : undefined,
        } as UpdateTodoDto)
      : ({
          title,
          description: description || undefined,
          priority,
          dueDate: dueDate ? dueDate.toISOString() : undefined,
        } as CreateTodoDto);

    const result = await onSubmit(dto);
    setSubmitting(false);

    if (result.success) {
      onClose();
    } else {
      setError(result.error || "Failed to save todo");
    }
  };

  const handleClose = () => {
    if (!submitting) {
      onClose();
      setError(null);
    }
  };

  return (
    <LocalizationProvider dateAdapter={AdapterDateFns}>
      <Dialog open={open} onClose={handleClose} maxWidth="sm" fullWidth>
        <DialogTitle>{todo ? "Edit Todo" : "Create Todo"}</DialogTitle>
        <DialogContent>
          <Box sx={{ display: "flex", flexDirection: "column", gap: 2, pt: 1 }}>
            {error && <Alert severity="error">{error}</Alert>}
            <TextField
              label="Title"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              required
              fullWidth
              error={!!error && !title.trim()}
              helperText={error && !title.trim() ? "Title is required" : ""}
            />
            <TextField
              label="Description"
              value={description}
              onChange={(e) => setDescription(e.target.value)}
              multiline
              rows={3}
              fullWidth
            />
            <TextField
              select
              label="Priority"
              value={priority}
              onChange={(e) => setPriority(e.target.value as Priority)}
              fullWidth
            >
              {PriorityValues.map((p) => (
                <MenuItem key={p} value={p}>
                  {p.charAt(0).toUpperCase() + p.slice(1)}
                </MenuItem>
              ))}
            </TextField>
            <DatePicker
              label="Due Date"
              value={dueDate}
              onChange={(newValue) => setDueDate(newValue)}
              slotProps={{
                textField: {
                  fullWidth: true,
                },
              }}
            />
          </Box>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleClose} disabled={submitting}>
            Cancel
          </Button>
          <Button
            onClick={handleSubmit}
            variant="contained"
            disabled={submitting || !title.trim()}
          >
            {submitting ? "Saving..." : todo ? "Update" : "Create"}
          </Button>
        </DialogActions>
      </Dialog>
    </LocalizationProvider>
  );
};
