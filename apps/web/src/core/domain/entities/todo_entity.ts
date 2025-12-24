import { Priority } from "../value_objects/priority";

export interface TodoEntity {
  id: string;
  title: string;
  description?: string;
  priority: Priority;
  dueDate?: string;
  completed: boolean;
  createdAt: string;
  updatedAt: string;
}
