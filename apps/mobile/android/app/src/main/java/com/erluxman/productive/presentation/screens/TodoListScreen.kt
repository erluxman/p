package com.erluxman.productive.presentation.screens

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.Icon
import androidx.compose.material3.Scaffold
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.hilt.navigation.compose.hiltViewModel
import com.erluxman.productive.core.domain.entities.TodoEntity
import com.erluxman.productive.presentation.state.TodoUiState
import com.erluxman.productive.presentation.ui.CreateTodoDialog
import com.erluxman.productive.presentation.ui.EditTodoDialog
import com.erluxman.productive.presentation.ui.EmptyState
import com.erluxman.productive.presentation.ui.ErrorMessage
import com.erluxman.productive.presentation.ui.TodoItem
import com.erluxman.productive.presentation.viewmodels.TodoViewModel

@Composable
fun TodoListScreen(
    viewModel: TodoViewModel = hiltViewModel(),
    modifier: Modifier = Modifier
) {
    val uiState by viewModel.uiState.collectAsState()
    var showCreateDialog by remember { mutableStateOf(false) }
    var todoToEdit by remember { mutableStateOf<TodoEntity?>(null) }

    Scaffold(
        floatingActionButton = {
            FloatingActionButton(onClick = { showCreateDialog = true }) {
                Icon(Icons.Default.Add, contentDescription = "Add Todo")
            }
        }
    ) { paddingValues ->
        Box(
            modifier = modifier
                .fillMaxSize()
                .padding(paddingValues)
        ) {
            // FIX: Assign to a local variable to enable smart casting
            val state = uiState

            when (state) {
                is TodoUiState.Loading -> {
                    CircularProgressIndicator(
                        modifier = Modifier.align(Alignment.Center)
                    )
                }
                is TodoUiState.Error -> {
                    ErrorMessage(
                        message = state.message, // Now smart cast to Error
                        onRetry = { viewModel.loadTodos() },
                        modifier = Modifier.fillMaxSize()
                    )
                }
                is TodoUiState.Empty -> {
                    EmptyState(
                        modifier = Modifier.fillMaxSize()
                    )
                }
                is TodoUiState.Success -> {
                    LazyColumn(
                        modifier = Modifier.fillMaxSize()
                    ) {
                        items(
                            items = state.todos, // Now smart cast to Success
                            key = { it.id }
                        ) { todo ->
                            TodoItem(
                                todo = todo,
                                onToggle = { viewModel.toggleTodo(it) },
                                onDelete = { viewModel.deleteTodo(it) },
                                onEdit = { todoToEdit = todo }
                            )
                        }
                    }
                }
            }
        }
        if (showCreateDialog) {
            CreateTodoDialog(
                onDismiss = { showCreateDialog = false },
                onConfirm = { title ->
                    viewModel.createTodo(title)
                    showCreateDialog = false
                }
            )
        }
        
        todoToEdit?.let { todo ->
            EditTodoDialog(
                todo = todo,
                onDismiss = { todoToEdit = null },
                onConfirm = { updatedTodo ->
                    viewModel.updateTodo(updatedTodo)
                    todoToEdit = null
                }
            )
        }
    }
}
