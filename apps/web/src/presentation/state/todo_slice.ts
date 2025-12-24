import { createSlice } from '@reduxjs/toolkit';
import type { PayloadAction } from '@reduxjs/toolkit';
import type { TodoEntity } from '../../core/domain/entities/todo_entity';

interface TodoState {
  todos: TodoEntity[];
  loading: boolean;
  error: string | null;
}

const initialState: TodoState = {
  todos: [],
  loading: false,
  error: null,
};

const todoSlice = createSlice({
  name: 'todos',
  initialState,
  reducers: {
    setLoading: (state, action: PayloadAction<boolean>) => {
      state.loading = action.payload;
    },
    setError: (state, action: PayloadAction<string | null>) => {
      state.error = action.payload;
    },
    setTodos: (state, action: PayloadAction<TodoEntity[]>) => {
      state.todos = action.payload;
      state.error = null;
    },
    addTodo: (state, action: PayloadAction<TodoEntity>) => {
      state.todos.push(action.payload);
      state.error = null;
    },
    updateTodo: (state, action: PayloadAction<TodoEntity>) => {
      const index = state.todos.findIndex(t => t.id === action.payload.id);
      if (index !== -1) {
        state.todos[index] = action.payload;
      }
      state.error = null;
    },
    removeTodo: (state, action: PayloadAction<string>) => {
      state.todos = state.todos.filter(t => t.id !== action.payload);
      state.error = null;
    },
  },
});

export const { setLoading, setError, setTodos, addTodo, updateTodo, removeTodo } = todoSlice.actions;
export default todoSlice.reducer;
