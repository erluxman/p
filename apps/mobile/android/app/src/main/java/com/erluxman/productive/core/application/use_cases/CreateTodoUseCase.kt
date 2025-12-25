package com.erluxman.productive.core.application.use_cases

import com.erluxman.productive.core.application.types.AppError
import com.erluxman.productive.core.domain.entities.TodoEntity
import com.erluxman.productive.core.domain.exceptions.ValidationException
import com.erluxman.productive.core.domain.repositories.TodoRepository
import java.util.UUID

class CreateTodoUseCase(
    private val repository: TodoRepository
) {
    suspend fun execute(title: String): Result<TodoEntity> {
        val trimmedTitle = title.trim()
        
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
        
        return repository.create(trimmedTitle)
    }
}

