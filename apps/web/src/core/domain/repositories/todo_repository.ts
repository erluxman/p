import type { TodoEntity } from "../entities/todo_entity";

export interface TodoRepository {
  findAll(): Promise<TodoEntity[]>;
  findById(id: string): Promise<TodoEntity | null>;
  create(todo: TodoEntity): Promise<TodoEntity>;
  update(todo: TodoEntity): Promise<TodoEntity>;
  delete(id: string): Promise<void>;
}
