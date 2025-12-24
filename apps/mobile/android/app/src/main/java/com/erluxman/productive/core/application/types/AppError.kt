package com.erluxman.productive.core.application.types

sealed class AppError {
    data class ValidationError(val message: String) : AppError()
    data class NetworkError(val message: String) : AppError()
    data class RepositoryError(val message: String) : AppError()
    data class NotFoundError(val message: String) : AppError()
    data class UnknownError(val message: String) : AppError()
    
    fun toUserMessage(): String = when (this) {
        is ValidationError -> message
        is NetworkError -> "Network error: $message"
        is RepositoryError -> "Data error: $message"
        is NotFoundError -> "Not found: $message"
        is UnknownError -> "An error occurred: $message"
    }
}

