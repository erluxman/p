package com.erluxman.productive.core.application.use_cases

import com.erluxman.productive.core.application.types.AppError
import com.erluxman.productive.core.domain.entities.TodoEntity
import com.erluxman.productive.core.domain.repositories.TodoRepository

class GetTodosUseCase(
    private val repository: TodoRepository
) {
    suspend fun execute(): Result<List<TodoEntity>> {
        return repository.getAll()
    }
}

