package com.erluxman.productive.presentation.state

import com.erluxman.productive.core.domain.entities.TodoEntity

sealed class TodoUiState {
    object Loading : TodoUiState()
    data class Success(val todos: List<TodoEntity>) : TodoUiState()
    data class Error(val message: String) : TodoUiState()
    object Empty : TodoUiState()
}

