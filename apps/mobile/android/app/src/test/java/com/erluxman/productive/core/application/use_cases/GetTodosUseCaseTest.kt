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
class GetTodosUseCaseTest {
    
    private val repository: TodoRepository = mockk()
    private val useCase = GetTodosUseCase(repository)
    
    @Test
    fun `execute should return success with todos list`() = runTest {
        // Given
        val todos = TestFixtures.createTodoList(3)
        coEvery { repository.getAll() } returns Result.success(todos)
        
        // When
        val result = useCase.execute()
        
        // Then
        assertTrue(result.isSuccess)
        result.fold(
            onSuccess = { resultTodos ->
                assertEquals(3, resultTodos.size)
                assertEquals(todos, resultTodos)
            },
            onFailure = { fail("Should not fail") }
        )
    }
    
    @Test
    fun `execute should return failure when repository fails`() = runTest {
        // Given
        val exception = Exception("Repository error")
        coEvery { repository.getAll() } returns Result.failure(exception)
        
        // When
        val result = useCase.execute()
        
        // Then
        assertTrue(result.isFailure)
        result.fold(
            onSuccess = { fail("Should not succeed") },
            onFailure = { error ->
                assertEquals(exception, error)
            }
        )
    }
    
    @Test
    fun `execute should return empty list when no todos exist`() = runTest {
        // Given
        coEvery { repository.getAll() } returns Result.success(emptyList())
        
        // When
        val result = useCase.execute()
        
        // Then
        assertTrue(result.isSuccess)
        result.fold(
            onSuccess = { todos ->
                assertTrue(todos.isEmpty())
            },
            onFailure = { fail("Should not fail") }
        )
    }
}

