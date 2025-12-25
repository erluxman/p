package com.erluxman.productive.core.application.use_cases

import com.erluxman.productive.core.domain.repositories.TodoRepository
import io.mockk.coEvery
import io.mockk.mockk
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runTest
import org.junit.Assert.*
import org.junit.Test

@OptIn(ExperimentalCoroutinesApi::class)
class DeleteTodoUseCaseTest {
    
    private val repository: TodoRepository = mockk()
    private val useCase = DeleteTodoUseCase(repository)
    
    @Test
    fun `execute should return success when todo is deleted`() = runTest {
        // Given
        val todoId = "1"
        coEvery { repository.delete(todoId) } returns Result.success(Unit)
        
        // When
        val result = useCase.execute(todoId)
        
        // Then
        assertTrue(result.isSuccess)
        result.fold(
            onSuccess = { unit ->
                assertEquals(Unit, unit)
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
    fun `execute should return failure when repository fails`() = runTest {
        // Given
        val todoId = "1"
        val exception = Exception("Delete failed")
        coEvery { repository.delete(todoId) } returns Result.failure(exception)
        
        // When
        val result = useCase.execute(todoId)
        
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

