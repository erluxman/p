# Todo App Spec (Example)

**Purpose**: Example feature specification following the project's spec format.

---

## Feature

Todo Management Application

## Purpose

Allow users to create, delete, edit, and toggle completion status of todos with additional fields (title, description, priority, dueDate, createdAt, updatedAt).

## Behavior

- Responsive web application displaying a list of todos sorted by due date (completed todos at bottom)
- Add, edit (via modal dialog), delete, and toggle completion functionality
- Todos persist in browser localStorage
- Architecture ready for backend API integration later
- Optimistic updates for better UX

## Constraints

- Must follow Hexagonal Architecture (domain/application/infrastructure/presentation layers)
- No business logic in UI components
- Use Redux Toolkit for state management
- Use MUI (Material-UI) for components
- Use Either/Result pattern for use cases
- Follow all React conventions from `.cursor/rules`
- No hardcoded values
- All errors must be handled
- Comprehensive validation logic for all fields

## Acceptance Criteria

- User can create todos with:
  - Title (required, min 1 char, max 200 chars)
  - Description (optional, max 1000 chars)
  - Priority (low/medium/high, default medium)
  - DueDate (optional, ISO 8601 string, must be future date if provided)
- Edit todos via modal dialog
- Delete todos (with confirmation)
- Toggle completion status
- Todos sorted by due date (completed at bottom)
- UI follows Material Design principles via MUI
- Application is responsive
- Todos persist across page refreshes
- All operations use Either/Result pattern
- All operations have error handling and user feedback
- Validation prevents invalid data entry
- Todos have UUID, createdAt, and updatedAt fields

## Testing Requirements

- Unit tests
- UI tests
- Integration test in browser
