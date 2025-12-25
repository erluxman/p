package com.erluxman.productive.infrastructure.database

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "todos")
data class TodoRoomEntity(
    @PrimaryKey
    val id: String,
    val title: String,
    val isCompleted: Boolean,
    val createdAt: Long
)

