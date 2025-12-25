package com.erluxman.productive.infrastructure.repositories

import com.erluxman.productive.core.domain.entities.TodoEntity
import com.erluxman.productive.core.domain.exceptions.NotFoundException
import com.erluxman.productive.core.domain.repositories.TodoRepository
import java.util.UUID
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.first
import javax.inject.Inject


class TodoRepositoryImpl @Inject constructor() : TodoRepository {
    private val todos = MutableStateFlow<List<TodoEntity>>(emptyList())
    
    override suspend fun getAll(): Result<List<TodoEntity>> {
        return try {
            Result.success(todos.first())
        } catch (e: Exception) {
            Result.failure(e)
        }
    }
    
    override suspend fun getById(id: String): Result<TodoEntity> {
        return try {
            val todo = todos.first().find { it.id == id }
                ?: return Result.failure(NotFoundException("Todo with id $id not found"))
            Result.success(todo)
        } catch (e: Exception) {
            Result.failure(e)
        }
    }
    
    override suspend fun create(title: String): Result<TodoEntity> {
        return try {
            val newTodo = TodoEntity(
                id = UUID.randomUUID().toString(),
                title = title,
                isCompleted = false,
                createdAt = System.currentTimeMillis()
            )
            val currentTodos = todos.first()
            todos.value = currentTodos + newTodo
            Result.success(newTodo)
        } catch (e: Exception) {
            Result.failure(e)
        }
    }
    
    override suspend fun update(todo: TodoEntity): Result<TodoEntity> {
        return try {
            val currentTodos = todos.first().toMutableList()
            val index = currentTodos.indexOfFirst { it.id == todo.id }
            if (index == -1) {
                return Result.failure(NotFoundException("Todo with id ${todo.id} not found"))
            }
            currentTodos[index] = todo
            todos.value = currentTodos
            Result.success(todo)
        } catch (e: Exception) {
            Result.failure(e)
        }
    }
    
    override suspend fun delete(id: String): Result<Unit> {
        return try {
            val currentTodos = todos.first().toMutableList()
            val removed = currentTodos.removeIf { it.id == id }
            if (!removed) {
                return Result.failure(NotFoundException("Todo with id $id not found"))
            }
            todos.value = currentTodos
            Result.success(Unit)
        } catch (e: Exception) {
            Result.failure(e)
        }
    }
}

