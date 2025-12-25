package com.erluxman.productive.core.domain.repositories

import com.erluxman.productive.core.domain.entities.TodoEntity

interface TodoRepository {
    suspend fun getAll(): Result<List<TodoEntity>>
    suspend fun getById(id: String): Result<TodoEntity>
    suspend fun create(title: String): Result<TodoEntity>
    suspend fun update(todo: TodoEntity): Result<TodoEntity>
    suspend fun delete(id: String): Result<Unit>
}

