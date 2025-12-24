import { useCallback } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import type { AppDispatch, RootState } from '../state/store';
import { setLoading, setError, setTodos, addTodo, updateTodo as updateTodoAction, removeTodo } from '../state/todo_slice';
import { CreateTodoUseCase } from '../../core/application/use_cases/create_todo_use_case';
import { UpdateTodoUseCase } from '../../core/application/use_cases/update_todo_use_case';
import { DeleteTodoUseCase } from '../../core/application/use_cases/delete_todo_use_case';
import { ToggleTodoUseCase } from '../../core/application/use_cases/toggle_todo_use_case';
import { GetAllTodosUseCase } from '../../core/application/use_cases/get_all_todos_use_case';
import { TodoRepositoryImpl } from '../../infrastructure/adapters/repositories/todo_repository_impl';
import type { CreateTodoDto } from '../../core/application/dto/create_todo_dto';
import type { UpdateTodoDto } from '../../core/application/dto/update_todo_dto';

const repository = new TodoRepositoryImpl();
const createTodoUseCase = new CreateTodoUseCase(repository);
const updateTodoUseCase = new UpdateTodoUseCase(repository);
const deleteTodoUseCase = new DeleteTodoUseCase(repository);
const toggleTodoUseCase = new ToggleTodoUseCase(repository);
const getAllTodosUseCase = new GetAllTodosUseCase(repository);

export const useTodos = () => {
  const dispatch = useDispatch<AppDispatch>();
  const { todos, loading, error } = useSelector((state: RootState) => state.todos);

  const loadTodos = useCallback(async () => {
    dispatch(setLoading(true));
    const result = await getAllTodosUseCase.execute();
    if (result.success) {
      dispatch(setTodos(result.data));
    } else {
      dispatch(setError(result.error));
    }
    dispatch(setLoading(false));
  }, [dispatch]);

  const createTodo = useCallback(async (dto: CreateTodoDto) => {
    dispatch(setLoading(true));
    const result = await createTodoUseCase.execute(dto);
    if (result.success) {
      dispatch(addTodo(result.data));
    } else {
      dispatch(setError(result.error));
    }
    dispatch(setLoading(false));
    return result;
  }, [dispatch]);

  const updateTodo = useCallback(async (id: string, dto: UpdateTodoDto) => {
    dispatch(setLoading(true));
    const result = await updateTodoUseCase.execute(id, dto);
    if (result.success) {
      dispatch(updateTodoAction(result.data));
    } else {
      dispatch(setError(result.error));
    }
    dispatch(setLoading(false));
    return result;
  }, [dispatch]);

  const deleteTodo = useCallback(async (id: string) => {
    dispatch(setLoading(true));
    const result = await deleteTodoUseCase.execute(id);
    if (result.success) {
      dispatch(removeTodo(id));
    } else {
      dispatch(setError(result.error));
    }
    dispatch(setLoading(false));
    return result;
  }, [dispatch]);

  const toggleTodo = useCallback(async (id: string) => {
    dispatch(setLoading(true));
    const result = await toggleTodoUseCase.execute(id);
    if (result.success) {
      dispatch(updateTodoAction(result.data));
    } else {
      dispatch(setError(result.error));
    }
    dispatch(setLoading(false));
    return result;
  }, [dispatch]);

  return {
    todos,
    loading,
    error,
    loadTodos,
    createTodo,
    updateTodo,
    deleteTodo,
    toggleTodo,
  };
};
