# Node.js Backend

A Node.js backend service built with Express and TypeScript, following Hexagonal Architecture principles.

## Tech Stack

- **Runtime**: Node.js 20+
- **Framework**: Express.js
- **Language**: TypeScript
- **Testing**: Jest with Supertest for E2E tests

## Project Structure

```
apps/backend/node/
├── src/
│   ├── presentation/
│   │   ├── controllers/    # Request handlers
│   │   └── routes/         # Route definitions
│   └── index.ts            # Application entry point
├── test/
│   ├── unit/               # Unit tests
│   └── e2e/                # End-to-end tests
├── dist/                   # Compiled JavaScript (generated)
└── package.json
```

## Getting Started

### Install Dependencies

```bash
npm install
```

### Development

Run in development mode with hot reload:

```bash
npm run dev
```

### Build

Compile TypeScript to JavaScript:

```bash
npm run build
```

### Start Production Server

```bash
npm start
```

The server will start on `http://localhost:3000`

## Testing

### Run All Tests

```bash
npm test
```

### Run Unit Tests Only

```bash
npm run test:unit
```

### Run E2E Tests Only

```bash
npm run test:e2e
```

### Run Tests with Coverage

```bash
npm run test:coverage
```

### Watch Mode

```bash
npm run test:watch
```

## API Endpoints

### GET /api/hello

Returns a hello world message.

**Response:**
```json
{
  "message": "Hello, World!"
}
```

## CI/CD

GitHub Actions workflow automatically runs tests on push and pull requests to `main` and `develop` branches. The workflow only triggers when files in `apps/backend/node/**` are changed.

## Architecture

This project follows Hexagonal Architecture (Ports & Adapters):

- **Presentation Layer**: Routes and controllers (HTTP boundaries)
- **Application Layer**: Use cases and business logic (to be added)
- **Domain Layer**: Entities and value objects (to be added)
- **Infrastructure Layer**: External services and adapters (to be added)

