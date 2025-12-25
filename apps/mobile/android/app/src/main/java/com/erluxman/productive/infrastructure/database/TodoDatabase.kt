package com.erluxman.productive.infrastructure.database

import androidx.room.Database
import androidx.room.RoomDatabase
import androidx.room.TypeConverters
import com.erluxman.productive.infrastructure.database.type_converters.DateTypeConverter

@Database(
    entities = [TodoRoomEntity::class],
    version = 1,
    exportSchema = false
)
@TypeConverters(DateTypeConverter::class)
abstract class TodoDatabase : RoomDatabase() {
    abstract fun todoDao(): TodoDao
}

