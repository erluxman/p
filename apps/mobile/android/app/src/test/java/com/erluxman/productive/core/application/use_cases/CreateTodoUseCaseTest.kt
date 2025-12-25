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
class CreateTodoUseCaseTest {
    
    private val repository: TodoRepository = mockk()
    private val useCase = CreateTodoUseCase(repository)
    
    @Test
    fun `execute should return success with created todo`() = runTest {
        // Given
        val title = "New Todo"
        val createdTodo = TestFixtures.createTodoEntity(title = title)
        coEvery { repository.create(title) } returns Result.success(createdTodo)
        
        // When
        val result = useCase.execute(title)
        
        // Then
        assertTrue(result.isSuccess)
        result.fold(
            onSuccess = { todo ->
                assertEquals(title, todo.title)
            },
            onFailure = { fail("Should not fail") }
        )
    }
    
    @Test
    fun `execute should trim title before creating`() = runTest {
        // Given
        val titleWithSpaces = "  New Todo  "
        val trimmedTitle = "New Todo"
        val createdTodo = TestFixtures.createTodoEntity(title = trimmedTitle)
        coEvery { repository.create(trimmedTitle) } returns Result.success(createdTodo)
        
        // When
        val result = useCase.execute(titleWithSpaces)
        
        // Then
        assertTrue(result.isSuccess)
    }
    
    @Test
    fun `execute should return failure when title is empty`() = runTest {
        // When
        val result = useCase.execute("")
        
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
    fun `execute should return failure when title is only whitespace`() = runTest {
        // When
        val result = useCase.execute("   ")
        
        // Then
        assertTrue(result.isFailure)
        result.fold(
            onSuccess = { fail("Should not succeed") },
            onFailure = { error ->
                assertTrue(error is ValidationException)
            }
        )
    }
    
    @Test
    fun `execute should return failure when title exceeds 200 characters`() = runTest {
        // Given
        val longTitle = "a".repeat(201)
        
        // When
        val result = useCase.execute(longTitle)
        
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
    
    @Test
    fun `execute should accept title with exactly 200 characters`() = runTest {
        // Given
        val title = "a".repeat(200)
        val createdTodo = TestFixtures.createTodoEntity(title = title)
        coEvery { repository.create(title) } returns Result.success(createdTodo)
        
        // When
        val result = useCase.execute(title)
        
        // Then
        assertTrue(result.isSuccess)
    }
}

