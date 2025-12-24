import { Priority } from "../../domain/value_objects/priority";

export interface CreateTodoDto {
  title: string;
  description?: string;
  priority?: Priority;
  dueDate?: string;
}
