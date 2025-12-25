package com.erluxman.productive.core.application.use_cases

import com.erluxman.productive.core.domain.entities.TodoEntity
import com.erluxman.productive.core.domain.repositories.TodoRepository
import com.erluxman.productive.test_utils.TestFixtures
import io.mockk.coEvery
import io.mockk.mockk
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runTest
import org.junit.Assert.*
import org.junit.Test

@OptIn(ExperimentalCoroutinesApi::class)
class ToggleTodoUseCaseTest {
    
    private val repository: TodoRepository = mockk()
    private val useCase = ToggleTodoUseCase(repository)
    
    @Test
    fun `execute should toggle todo from incomplete to complete`() = runTest {
        // Given
        val todo = TestFixtures.createTodoEntity(id = "1", isCompleted = false)
        val toggledTodo = todo.toggleCompletion()
        coEvery { repository.getById("1") } returns Result.success(todo)
        coEvery { repository.update(toggledTodo) } returns Result.success(toggledTodo)
        
        // When
        val result = useCase.execute("1")
        
        // Then
        assertTrue(result.isSuccess)
        result.fold(
            onSuccess = { updatedTodo ->
                assertTrue(updatedTodo.isCompleted)
            },
            onFailure = { fail("Should not fail") }
        )
    }
    
    @Test
    fun `execute should toggle todo from complete to incomplete`() = runTest {
        // Given
        val todo = TestFixtures.createTodoEntity(id = "1", isCompleted = true)
        val toggledTodo = todo.toggleCompletion()
        coEvery { repository.getById("1") } returns Result.success(todo)
        coEvery { repository.update(toggledTodo) } returns Result.success(toggledTodo)
        
        // When
        val result = useCase.execute("1")
        
        // Then
        assertTrue(result.isSuccess)
        result.fold(
            onSuccess = { updatedTodo ->
                assertFalse(updatedTodo.isCompleted)
            },
            onFailure = { fail("Should not fail") }
        )
    }
    
    @Test
    fun `execute should return failure when id is blank`() = runTest {
        // When
        val result = useCase.execute("")
        
        // Then
        assertTrue(result.isFailure)
        result.fold(
            onSuccess = { fail("Should not succeed") },
            onFailure = { error ->
                assertTrue(error is IllegalArgumentException)
                assertEquals("Todo ID cannot be empty", error.message)
            }
        )
    }
    
    @Test
    fun `execute should return failure when todo not found`() = runTest {
        // Given
        val exception = Exception("Todo not found")
        coEvery { repository.getById("1") } returns Result.failure(exception)
        
        // When
        val result = useCase.execute("1")
        
        // Then
        assertTrue(result.isFailure)
        result.fold(
            onSuccess = { fail("Should not succeed") },
            onFailure = { error ->
                assertEquals(exception, error)
            }
        )
    }
}

