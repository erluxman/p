import { Priority } from "../../domain/value_objects/priority";

export interface UpdateTodoDto {
  title?: string;
  description?: string;
  priority?: Priority;
  dueDate?: string;
  completed?: boolean;
}
