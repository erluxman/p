package com.erluxman.productive.presentation.ui

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.CheckCircle
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material.icons.filled.RadioButtonUnchecked
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.text.style.TextDecoration
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.erluxman.productive.core.domain.entities.TodoEntity

@Composable
fun TodoItem(
    todo: TodoEntity,
    onToggle: (String) -> Unit,
    onDelete: (String) -> Unit,
    onEdit: (TodoEntity) -> Unit = {},
    modifier: Modifier = Modifier
) {
    Row(
        modifier = modifier
            .fillMaxWidth()
            .padding(16.dp)
            .semantics {
                contentDescription = "Todo: ${todo.title}, ${if (todo.isCompleted) "completed" else "not completed"}"
            },
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        Row(
            modifier = Modifier.weight(1f),
            verticalAlignment = Alignment.CenterVertically
        ) {
            IconButton(
                onClick = { onToggle(todo.id) },
                modifier = Modifier.semantics {
                    contentDescription = "Toggle todo completion"
                }
            ) {
                Icon(
                    imageVector = if (todo.isCompleted) {
                        Icons.Default.CheckCircle
                    } else {
                        Icons.Default.RadioButtonUnchecked
                    },
                    contentDescription = if (todo.isCompleted) {
                        "Mark as incomplete"
                    } else {
                        "Mark as complete"
                    },
                    tint = if (todo.isCompleted) {
                        MaterialTheme.colorScheme.primary
                    } else {
                        MaterialTheme.colorScheme.onSurfaceVariant
                    }
                )
            }
            Text(
                text = todo.title,
                fontSize = 16.sp,
                textDecoration = if (todo.isCompleted) {
                    TextDecoration.LineThrough
                } else {
                    null
                },
                color = if (todo.isCompleted) {
                    MaterialTheme.colorScheme.onSurfaceVariant
                } else {
                    MaterialTheme.colorScheme.onSurface
                },
                modifier = Modifier
                    .weight(1f)
                    .clickable { onEdit(todo) }
            )
        }
        IconButton(
            onClick = { onDelete(todo.id) },
            modifier = Modifier.semantics {
                contentDescription = "Delete todo"
            }
        ) {
            Icon(
                imageVector = Icons.Default.Delete,
                contentDescription = "Delete todo",
                tint = MaterialTheme.colorScheme.error
            )
        }
    }
}

