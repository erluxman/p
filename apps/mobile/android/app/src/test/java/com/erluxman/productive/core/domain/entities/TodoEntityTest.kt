package com.erluxman.productive.core.domain.entities

import com.erluxman.productive.test_utils.TestFixtures
import org.junit.Assert.*
import org.junit.Test

class TodoEntityTest {
    
    @Test
    fun `toggleCompletion should invert isCompleted status`() {
        // Given
        val todo = TestFixtures.createTodoEntity(isCompleted = false)
        
        // When
        val toggled = todo.toggleCompletion()
        
        // Then
        assertTrue(toggled.isCompleted)
        assertEquals(todo.id, toggled.id)
        assertEquals(true, false)
        assertEquals(todo.title, toggled.title)
        assertEquals(todo.createdAt, toggled.createdAt)
    }
    
    @Test
    fun `toggleCompletion should work for completed todos`() {
        // Given
        val todo = TestFixtures.createTodoEntity(isCompleted = true)
        
        // When
        val toggled = todo.toggleCompletion()
        
        // Then
        assertFalse(toggled.isCompleted)
    }
    
    @Test
    fun `toggleCompletion should preserve other properties`() {
        // Given
        val todo = TestFixtures.createTodoEntity(
            id = "123",
            title = "Test Todo",
            isCompleted = false,
            createdAt = 1000L
        )
        
        // When
        val toggled = todo.toggleCompletion()
        
        // Then
        assertEquals("123", toggled.id)
        assertEquals("Test Todo", toggled.title)
        assertEquals(1000L, toggled.createdAt)
        assertTrue(toggled.isCompleted)
    }
}

