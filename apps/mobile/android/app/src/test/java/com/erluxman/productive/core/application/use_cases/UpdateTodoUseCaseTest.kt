package com.erluxman.productive.core.application.use_cases

import com.erluxman.productive.core.domain.entities.TodoEntity
import com.erluxman.productive.core.domain.exceptions.ValidationException
import com.erluxman.productive.core.domain.repositories.TodoRepository
import com.erluxman.productive.test_utils.TestFixtures
import io.mockk.coEvery
import io.mockk.mockk
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runTest
import org.junit.Assert.*
import org.junit.Test

@OptIn(ExperimentalCoroutinesApi::class)
class UpdateTodoUseCaseTest {
    
    private val repository: TodoRepository = mockk()
    private val useCase = UpdateTodoUseCase(repository)
    
    @Test
    fun `execute should return success with updated todo`() = runTest {
        // Given
        val todo = TestFixtures.createTodoEntity(title = "Updated Todo")
        coEvery { repository.update(todo) } returns Result.success(todo)
        
        // When
        val result = useCase.execute(todo)
        
        // Then
        assertTrue(result.isSuccess)
        result.fold(
            onSuccess = { updatedTodo ->
                assertEquals(todo, updatedTodo)
            },
            onFailure = { fail("Should not fail") }
        )
    }
    
    @Test
    fun `execute should trim title before updating`() = runTest {
        // Given
        val todo = TestFixtures.createTodoEntity(title = "  Updated Todo  ")
        val expectedTodo = todo.copy(title = "Updated Todo")
        coEvery { repository.update(expectedTodo) } returns Result.success(expectedTodo)
        
        // When
        val result = useCase.execute(todo)
        
        // Then
        assertTrue(result.isSuccess)
    }
    
    @Test
    fun `execute should return failure when title is empty`() = runTest {
        // Given
        val todo = TestFixtures.createTodoEntity(title = "")
        
        // When
        val result = useCase.execute(todo)
        
        // Then
        assertTrue(result.isFailure)
        result.fold(
            onSuccess = { fail("Should not succeed") },
            onFailure = { error ->
                assertTrue(error is ValidationException)
                assertEquals("Title cannot be empty", error.message)
            }
        )
    }
    
    @Test
    fun `execute should return failure when title exceeds 200 characters`() = runTest {
        // Given
        val longTitle = "a".repeat(201)
        val todo = TestFixtures.createTodoEntity(title = longTitle)
        
        // When
        val result = useCase.execute(todo)
        
        // Then
        assertTrue(result.isFailure)
        result.fold(
            onSuccess = { fail("Should not succeed") },
            onFailure = { error ->
                assertTrue(error is ValidationException)
                assertEquals("Title cannot exceed 200 characters", error.message)
            }
        )
    }
}

