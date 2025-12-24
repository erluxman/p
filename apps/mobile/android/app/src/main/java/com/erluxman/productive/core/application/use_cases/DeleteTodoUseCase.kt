package com.erluxman.productive.core.application.use_cases

import com.erluxman.productive.core.domain.repositories.TodoRepository

class DeleteTodoUseCase(
    private val repository: TodoRepository
) {
    suspend fun execute(id: String): Result<Unit> {
        if (id.isBlank()) {
            return Result.failure(
                IllegalArgumentException("Todo ID cannot be empty")
            )
        }
        
        return repository.delete(id)
    }
}

