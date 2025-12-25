package com.erluxman.productive.presentation.ui

import androidx.compose.ui.test.assertIsDisplayed
import androidx.compose.ui.test.assertTextEquals
import androidx.compose.ui.test.junit4.createComposeRule
import androidx.compose.ui.test.onNodeWithContentDescription
import androidx.compose.ui.test.onNodeWithText
import androidx.compose.ui.test.performClick
import com.erluxman.productive.core.domain.entities.TodoEntity
import com.erluxman.productive.test_utils.TestFixtures
import org.junit.Assert.*
import org.junit.Rule
import org.junit.Test

class TodoItemTest {
    
    @get:Rule
    val composeTestRule = createComposeRule()
    
    @Test
    fun todoItem_shouldDisplayTodoTitle() {
        // Given
        val todo = TestFixtures.createTodoEntity(title = "Test Todo")
        var toggleCalled = false
        var deleteCalled = false
        
        // When
        composeTestRule.setContent {
            TodoItem(
                todo = todo,
                onToggle = { toggleCalled = true },
                onDelete = { deleteCalled = true }
            )
        }
        
        // Then
        composeTestRule.onNodeWithText("Test Todo").assertIsDisplayed()
    }
    
    @Test
    fun todoItem_shouldCallOnToggle_whenToggleButtonIsClicked() {
        // Given
        val todo = TestFixtures.createTodoEntity(id = "1", title = "Test Todo")
        var toggleCalled = false
        var toggleId: String? = null
        
        // When
        composeTestRule.setContent {
            TodoItem(
                todo = todo,
                onToggle = { id ->
                    toggleCalled = true
                    toggleId = id
                },
                onDelete = {}
            )
        }
        
        // Then
        composeTestRule.onNodeWithContentDescription("Toggle todo completion")
            .performClick()
        
        assertTrue(toggleCalled)
        assertEquals("1", toggleId)
    }
    
    @Test
    fun todoItem_shouldCallOnDelete_whenDeleteButtonIsClicked() {
        // Given
        val todo = TestFixtures.createTodoEntity(id = "1", title = "Test Todo")
        var deleteCalled = false
        var deleteId: String? = null
        
        // When
        composeTestRule.setContent {
            TodoItem(
                todo = todo,
                onToggle = {},
                onDelete = { id ->
                    deleteCalled = true
                    deleteId = id
                }
            )
        }
        
        // Then
        composeTestRule.onNodeWithContentDescription("Delete todo")
            .performClick()
        
        assertTrue(deleteCalled)
        assertEquals("1", deleteId)
    }
    
    @Test
    fun todoItem_shouldShowCompletedStateCorrectly() {
        // Given
        val todo = TestFixtures.createTodoEntity(
            title = "Completed Todo",
            isCompleted = true
        )
        
        // When
        composeTestRule.setContent {
            TodoItem(
                todo = todo,
                onToggle = {},
                onDelete = {}
            )
        }
        
        // Then
        composeTestRule.onNodeWithText("Completed Todo").assertIsDisplayed()
        composeTestRule.onNodeWithContentDescription("Mark as incomplete").assertIsDisplayed()
    }
    
    @Test
    fun todoItem_shouldShowIncompleteStateCorrectly() {
        // Given
        val todo = TestFixtures.createTodoEntity(
            title = "Incomplete Todo",
            isCompleted = false
        )
        
        // When
        composeTestRule.setContent {
            TodoItem(
                todo = todo,
                onToggle = {},
                onDelete = {}
            )
        }
        
        // Then
        composeTestRule.onNodeWithText("Incomplete Todo").assertIsDisplayed()
        composeTestRule.onNodeWithContentDescription("Mark as complete").assertIsDisplayed()
    }
}

