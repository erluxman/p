package com.erluxman.productive.infrastructure.database

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.Update
import kotlinx.coroutines.flow.Flow

@Dao
interface TodoDao {
    @Query("SELECT * FROM todos ORDER BY createdAt DESC")
    fun getAll(): Flow<List<TodoRoomEntity>>
    
    @Query("SELECT * FROM todos WHERE id = :id")
    suspend fun getById(id: String): TodoRoomEntity?
    
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insert(todo: TodoRoomEntity)
    
    @Update
    suspend fun update(todo: TodoRoomEntity)
    
    @Query("DELETE FROM todos WHERE id = :id")
    suspend fun delete(id: String)
    
    @Query("DELETE FROM todos")
    suspend fun deleteAll()
}

