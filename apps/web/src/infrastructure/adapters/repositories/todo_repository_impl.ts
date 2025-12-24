import type { TodoEntity } from "../../../core/domain/entities/todo_entity";
import type { TodoRepository } from "../../../core/domain/repositories/todo_repository";
import { STORAGE_KEYS } from "../../config/storage_keys";
import { LocalStorageAdapter } from "../../data/local/local_storage_adapter";

export class TodoRepositoryImpl implements TodoRepository {
  private storage: LocalStorageAdapter;

  constructor(storage: LocalStorageAdapter = new LocalStorageAdapter()) {
    this.storage = storage;
  }

  async findAll(): Promise<TodoEntity[]> {
    const todos = this.storage.getItem<TodoEntity[]>(STORAGE_KEYS.TODOS);
    return todos ?? [];
  }

  async findById(id: string): Promise<TodoEntity | null> {
    const todos = await this.findAll();
    return todos.find((t) => t.id === id) ?? null;
  }

  async create(todo: TodoEntity): Promise<TodoEntity> {
    const todos = await this.findAll();
    todos.push(todo);
    this.storage.setItem(STORAGE_KEYS.TODOS, todos);
    return todo;
  }

  async update(todo: TodoEntity): Promise<TodoEntity> {
    const todos = await this.findAll();
    const index = todos.findIndex((t) => t.id === todo.id);
    if (index === -1) {
      throw new Error(`Todo with id ${todo.id} not found`);
    }
    todos[index] = todo;
    this.storage.setItem(STORAGE_KEYS.TODOS, todos);
    return todo;
  }

  async delete(id: string): Promise<void> {
    const todos = await this.findAll();
    const filtered = todos.filter((t) => t.id !== id);
    this.storage.setItem(STORAGE_KEYS.TODOS, filtered);
  }
}
