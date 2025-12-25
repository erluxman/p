package com.erluxman.productive

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.ui.Modifier
import com.erluxman.productive.presentation.screens.TodoListScreen
import com.erluxman.productive.ui.theme.ProductiveTheme
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            ProductiveTheme {
                TodoListScreen(
                    modifier = Modifier.fillMaxSize()
                )
            }
        }
    }
}