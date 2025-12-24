import { useEffect, useState } from 'react';
import { Container, Box, Alert, CircularProgress, Typography } from '@mui/material';
import { useTodos } from '../hooks/use_todos';
import type { TodoEntity } from '../../core/domain/entities/todo_entity';
import { AddTodoButton } from '../components/add_todo_button';
import { TodoList } from '../components/todo_list';
import { TodoFormModal } from '../components/todo_form_modal';
import type { CreateTodoDto } from '../../core/application/dto/create_todo_dto';
import type { UpdateTodoDto } from '../../core/application/dto/update_todo_dto';

export const TodoListScreen = () => {
  const { todos, loading, error, loadTodos, createTodo, updateTodo, deleteTodo, toggleTodo } =
    useTodos();
  const [modalOpen, setModalOpen] = useState(false);
  const [editingTodo, setEditingTodo] = useState<TodoEntity | null>(null);

  useEffect(() => {
    loadTodos();
  }, [loadTodos]);

  const handleCreate = async (dto: CreateTodoDto) => {
    return await createTodo(dto);
  };

  const handleUpdate = async (dto: UpdateTodoDto) => {
    if (!editingTodo) return { success: false, error: 'No todo selected' };
    return await updateTodo(editingTodo.id, dto);
  };

  const handleEdit = (todo: TodoEntity) => {
    setEditingTodo(todo);
    setModalOpen(true);
  };

  const handleAdd = () => {
    setEditingTodo(null);
    setModalOpen(true);
  };

  const handleCloseModal = () => {
    setModalOpen(false);
    setEditingTodo(null);
  };

  const handleSubmit = async (dto: CreateTodoDto | UpdateTodoDto) => {
    if (editingTodo) {
      return await handleUpdate(dto as UpdateTodoDto);
    } else {
      return await handleCreate(dto as CreateTodoDto);
    }
  };

  return (
    <Container maxWidth="md" sx={{ py: 4 }}>
      <Typography variant="h4" component="h1" gutterBottom>
        Todo App
      </Typography>
      {error && (
        <Alert severity="error" sx={{ mb: 2 }} onClose={() => {}}>
          {error}
        </Alert>
      )}
      <Box sx={{ mb: 2 }}>
        <AddTodoButton onClick={handleAdd} />
      </Box>
      {loading && todos.length === 0 ? (
        <Box sx={{ display: 'flex', justifyContent: 'center', p: 4 }}>
          <CircularProgress />
        </Box>
      ) : (
        <TodoList todos={todos} onToggle={toggleTodo} onEdit={handleEdit} onDelete={deleteTodo} />
      )}
      <TodoFormModal
        open={modalOpen}
        todo={editingTodo}
        onClose={handleCloseModal}
        onSubmit={handleSubmit}
      />
    </Container>
  );
};
