package com.erluxman.productive.infrastructure.di

import com.erluxman.productive.core.application.use_cases.CreateTodoUseCase
import com.erluxman.productive.core.application.use_cases.DeleteTodoUseCase
import com.erluxman.productive.core.application.use_cases.GetTodosUseCase
import com.erluxman.productive.core.application.use_cases.ToggleTodoUseCase
import com.erluxman.productive.core.application.use_cases.UpdateTodoUseCase
import com.erluxman.productive.core.domain.repositories.TodoRepository
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object UseCaseModule {
    @Provides
    @Singleton
    fun provideGetTodosUseCase(
        repository: TodoRepository
    ): GetTodosUseCase {
        return GetTodosUseCase(repository)
    }
    
    @Provides
    @Singleton
    fun provideCreateTodoUseCase(
        repository: TodoRepository
    ): CreateTodoUseCase {
        return CreateTodoUseCase(repository)
    }
    
    @Provides
    @Singleton
    fun provideUpdateTodoUseCase(
        repository: TodoRepository
    ): UpdateTodoUseCase {
        return UpdateTodoUseCase(repository)
    }
    
    @Provides
    @Singleton
    fun provideDeleteTodoUseCase(
        repository: TodoRepository
    ): DeleteTodoUseCase {
        return DeleteTodoUseCase(repository)
    }
    
    @Provides
    @Singleton
    fun provideToggleTodoUseCase(
        repository: TodoRepository
    ): ToggleTodoUseCase {
        return ToggleTodoUseCase(repository)
    }
}

