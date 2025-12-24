# Prompt: Feature Spec (10 lines)

@project_constitution.md @workflow_protocol.md

Write a 10-line spec using this format:

```text
**Feature**: Todo
**Purpose**: Create, delete, edit, check on/off the todo
**Behavior**: responsive app
**Constraints**: follow all the architectural criteria and limitation as defined in cursor rules, .cursor.rules
**Acceptance Criteria**: Create, delete, edit, check on/off the todo and follows material deisgn

Shall have unit and ui tests

Shall have integration test in browser
```

Rules:

- Ask clarifying questions if anything is ambiguous.
- Do not propose implementation yet. STOP. Wait for approval.

---

# Feature Spec: Todo App

**Feature**: Todo Management Application **Purpose**: Allow users to manage their todos by creating, editing, deleting, and toggling completion status **Behavior**: Responsive web application that displays a list of todos with ability to add new todos, edit existing ones, delete todos, and toggle completion status; todos persist across page refreshes **Constraints**: Must follow Hexagonal Architecture (domain/application/infrastructure/presentation layers), no business logic in UI components, use Zustand or Redux Toolkit for state management, follow React component conventions from .cursor/rules, no hardcoded values, all errors must be handled **Acceptance Criteria**:

- User can create a new todo with a title (required field)
- User can edit an existing todo's title
- User can delete a todo
- User can toggle a todo's completed status (check/uncheck)
- UI follows Material Design principles
- Application is responsive (works on mobile and desktop)
- Todos persist in browser storage (localStorage)
- All operations have proper error handling and user feedback
- Unit tests cover domain entities, use cases, and repository logic
- UI component tests cover all user interactions
- Integration tests in browser (Playwright) verify complete user flows
