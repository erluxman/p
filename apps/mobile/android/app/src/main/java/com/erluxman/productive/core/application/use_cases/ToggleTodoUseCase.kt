package com.erluxman.productive.core.application.use_cases

import com.erluxman.productive.core.domain.entities.TodoEntity
import com.erluxman.productive.core.domain.repositories.TodoRepository

class ToggleTodoUseCase(
    private val repository: TodoRepository
) {
    suspend fun execute(id: String): Result<TodoEntity> {
        if (id.isBlank()) {
            return Result.failure(
                IllegalArgumentException("Todo ID cannot be empty")
            )
        }
        
        val getResult = repository.getById(id)
        return getResult.fold(
            onSuccess = { todo ->
                val toggledTodo = todo.toggleCompletion()
                repository.update(toggledTodo)
            },
            onFailure = { exception ->
                Result.failure(exception)
            }
        )
    }
}

