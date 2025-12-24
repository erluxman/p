package com.erluxman.productive.core.application.use_cases

import com.erluxman.productive.core.domain.entities.TodoEntity
import com.erluxman.productive.core.domain.exceptions.ValidationException
import com.erluxman.productive.core.domain.repositories.TodoRepository

class UpdateTodoUseCase(
    private val repository: TodoRepository
) {
    suspend fun execute(todo: TodoEntity): Result<TodoEntity> {
        val trimmedTitle = todo.title.trim()
        
        if (trimmedTitle.isEmpty()) {
            return Result.failure(
                ValidationException("Title cannot be empty")
            )
        }
        
        if (trimmedTitle.length > 200) {
            return Result.failure(
                ValidationException("Title cannot exceed 200 characters")
            )
        }
        
        return repository.update(todo.copy(title = trimmedTitle))
    }
}

