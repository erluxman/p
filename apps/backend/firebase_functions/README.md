# Firebase Functions Backend

Firebase Functions backend service following Hexagonal Architecture principles.

## Architecture

This project follows **Hexagonal Architecture (Ports & Adapters)**:

- **`src/functions/`**: Function entrypoints/triggers (HTTP, callable, event-driven)
- **`src/core/domain/`**: Domain entities, value objects, and repository interfaces (ports)
- **`src/core/application/`**: Use cases, DTOs, and mappers
- **`src/infrastructure/`**: Adapters (Firebase Admin SDK, external services, repository implementations)

## Prerequisites

- Node.js 20+
- Firebase CLI: `npm install -g firebase-tools`
- Firebase project configured

## Setup

1. **Install dependencies:**

   ```bash
   npm install
   ```

2. **Configure Firebase:**

   ```bash
   # Copy the example firebase config
   cp .firebaserc.example .firebaserc

   # Edit .firebaserc with your project ID
   # Then login to Firebase
   firebase login
   ```

3. **Build the project:**

   ```bash
   npm run build
   ```

## Development

### Local Development

Run Firebase emulators:

```bash
npm run serve
```

This will:

- Build TypeScript
- Start Firebase emulators
- Functions available at `http://localhost:5001`

### Testing

Run all tests:

```bash
npm test
```

Run unit tests only:

```bash
npm run test:unit
```

Run integration tests:

```bash
npm run test:integration
```

Watch mode:

```bash
npm run test:watch
```

Coverage:

```bash
npm run test:coverage
```

### Linting

```bash
npm run lint
npm run lint:fix
```

## Deployment

Deploy all functions:

```bash
npm run deploy
```

Deploy specific function:

```bash
firebase deploy --only functions:helloWorldFunction
```

## Project Structure

```text
apps/firebase_functions/
├── src/
│   ├── functions/          # Function entrypoints
│   ├── core/
│   │   ├── domain/         # Entities, value objects, ports
│   │   └── application/    # Use cases, DTOs, mappers
│   └── infrastructure/     # Adapters, implementations
├── test/
│   ├── unit/               # Unit tests
│   └── integration/        # Integration tests
├── lib/                    # Compiled JavaScript (generated)
├── package.json
├── tsconfig.json
└── firebase.json
```

## Principles

### Function Design

- **Small and single-purpose**: Each function should do one thing well
- **Stateless**: Avoid shared mutable state between invocations
- **Input validation**: Never trust client-provided data
- **Error handling**: Always handle errors gracefully

### Authentication

- **Verify tokens**: Use Firebase Admin SDK to verify authentication tokens
- **Never log tokens**: Never log authentication tokens or sensitive headers
- **Untrusted by default**: Assume all requests are untrusted until verified

### Logging

- **Safe logging**: Never log secrets, tokens, or PII
- **Request tracking**: Include request IDs for debugging
- **Error context**: Log enough context to debug issues

## Testing Requirements

- **Domain**: 100% coverage target (entities, value objects, domain services)
- **Application**: 80% coverage target (use cases, mappers)
- **Infrastructure**: 70% coverage target (adapters, repositories)
- **Functions**: 60% coverage target (entrypoints)

## Environment Variables

Set environment variables using Firebase CLI:

```bash
firebase functions:config:set someservice.key="THE API KEY"
```

Access in code:

```typescript
const config = functions.config();
const apiKey = config.someservice.key;
```

## CI/CD

This project has GitHub Actions CI/CD configured. See [CI_CD_SETUP.md](./CI_CD_SETUP.md) for setup instructions.

The workflow automatically:

- Runs tests on every push/PR
- Deploys to Firebase on pushes to `main` branch

## Related Documentation

- [Project Constitution](../../../project_constitution.md)
- [Workflow Protocol](../../../workflow_protocol.md)
- [Firebase Functions Platform Guide](../../../ai-dev/platform_guides/backend_firebase_functions.md)
- [CI/CD Setup Guide](./CI_CD_SETUP.md)
