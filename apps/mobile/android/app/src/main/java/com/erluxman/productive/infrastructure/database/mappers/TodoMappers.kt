package com.erluxman.productive.infrastructure.database.mappers

import com.erluxman.productive.core.domain.entities.TodoEntity
import com.erluxman.productive.infrastructure.database.TodoRoomEntity

fun TodoRoomEntity.toDomainEntity(): TodoEntity {
    return TodoEntity(
        id = this.id,
        title = this.title,
        isCompleted = this.isCompleted,
        createdAt = this.createdAt
    )
}

fun TodoEntity.toRoomEntity(): TodoRoomEntity {
    return TodoRoomEntity(
        id = this.id,
        title = this.title,
        isCompleted = this.isCompleted,
        createdAt = this.createdAt
    )
}

fun List<TodoRoomEntity>.toDomainEntities(): List<TodoEntity> {
    return this.map { it.toDomainEntity() }
}

