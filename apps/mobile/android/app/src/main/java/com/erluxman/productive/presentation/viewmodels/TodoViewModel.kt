package com.erluxman.productive.presentation.viewmodels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.erluxman.productive.core.application.use_cases.CreateTodoUseCase
import com.erluxman.productive.core.application.use_cases.DeleteTodoUseCase
import com.erluxman.productive.core.application.use_cases.GetTodosUseCase
import com.erluxman.productive.core.application.use_cases.ToggleTodoUseCase
import com.erluxman.productive.core.application.use_cases.UpdateTodoUseCase
import com.erluxman.productive.core.domain.entities.TodoEntity
import com.erluxman.productive.presentation.state.TodoUiState
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class TodoViewModel @Inject constructor(
    private val getTodosUseCase: GetTodosUseCase,
    private val createTodoUseCase: CreateTodoUseCase,
    private val updateTodoUseCase: UpdateTodoUseCase,
    private val deleteTodoUseCase: DeleteTodoUseCase,
    private val toggleTodoUseCase: ToggleTodoUseCase
) : ViewModel() {
    
    private val _uiState = MutableStateFlow<TodoUiState>(TodoUiState.Loading)
    val uiState: StateFlow<TodoUiState> = _uiState.asStateFlow()
    
    init {
        loadTodos()
    }
    
    fun loadTodos() {
        viewModelScope.launch {
            _uiState.value = TodoUiState.Loading
            getTodosUseCase.execute().fold(
                onSuccess = { todos ->
                    _uiState.value = if (todos.isEmpty()) {
                        TodoUiState.Empty
                    } else {
                        TodoUiState.Success(todos)
                    }
                },
                onFailure = { exception ->
                    _uiState.value = TodoUiState.Error(
                        exception.message ?: "Failed to load todos"
                    )
                }
            )
        }
    }
    
    fun createTodo(title: String) {
        viewModelScope.launch {
            createTodoUseCase.execute(title).fold(
                onSuccess = {
                    loadTodos()
                },
                onFailure = { exception ->
                    _uiState.value = TodoUiState.Error(
                        exception.message ?: "Failed to create todo"
                    )
                }
            )
        }
    }
    
    fun updateTodo(todo: TodoEntity) {
        viewModelScope.launch {
            updateTodoUseCase.execute(todo).fold(
                onSuccess = {
                    loadTodos()
                },
                onFailure = { exception ->
                    _uiState.value = TodoUiState.Error(
                        exception.message ?: "Failed to update todo"
                    )
                }
            )
        }
    }
    
    fun deleteTodo(id: String) {
        viewModelScope.launch {
            deleteTodoUseCase.execute(id).fold(
                onSuccess = {
                    loadTodos()
                },
                onFailure = { exception ->
                    _uiState.value = TodoUiState.Error(
                        exception.message ?: "Failed to delete todo"
                    )
                }
            )
        }
    }
    
    fun toggleTodo(id: String) {
        viewModelScope.launch {
            toggleTodoUseCase.execute(id).fold(
                onSuccess = {
                    loadTodos()
                },
                onFailure = { exception ->
                    _uiState.value = TodoUiState.Error(
                        exception.message ?: "Failed to toggle todo"
                    )
                }
            )
        }
    }
}

