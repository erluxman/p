package com.erluxman.productive.test_utils

import com.erluxman.productive.core.domain.entities.TodoEntity

object TestFixtures {
    fun createTodoEntity(
        id: String = "1",
        title: String = "Test Todo",
        isCompleted: Boolean = false,
        createdAt: Long = System.currentTimeMillis()
    ): TodoEntity {
        return TodoEntity(
            id = id,
            title = title,
            isCompleted = isCompleted,
            createdAt = createdAt
        )
    }
    
    fun createTodoList(count: Int = 3): List<TodoEntity> {
        return (1..count).map { index ->
            createTodoEntity(
                id = index.toString(),
                title = "Todo $index",
                isCompleted = index % 2 == 0
            )
        }
    }
}

