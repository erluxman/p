package com.erluxman.productive.core.domain.entities

data class TodoEntity(
    val id: String,
    val title: String,
    val isCompleted: Boolean,
    val createdAt: Long
) {
    fun toggleCompletion(): TodoEntity {
        return copy(isCompleted = !isCompleted)
    }
}

