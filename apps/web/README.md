# React Web App

A React web application built with Vite and TypeScript, following Hexagonal Architecture principles.

## Tech Stack

- **Framework**: React 19
- **Build Tool**: Vite
- **Language**: TypeScript
- **Testing**: Vitest (unit) + Playwright (e2e)

## Project Structure

```
apps/web/
├── src/
│   ├── presentation/
│   │   └── components/    # React components
│   └── App.tsx             # Main app component
├── test/
│   ├── unit/               # Unit tests
│   └── e2e/                # End-to-end tests
└── package.json
```

## Getting Started

### Install Dependencies

```bash
npm install
```

### Development

Run in development mode:

```bash
npm run dev
```

The app will be available at `http://localhost:5173`

### Build

Build for production:

```bash
npm run build
```

### Preview Production Build

```bash
npm run preview
```

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

### Watch Mode

```bash
npm run test:watch
```

### Coverage

```bash
npm run test:coverage
```

## CI/CD

GitHub Actions workflow automatically runs tests on push and pull requests to `main` and `develop` branches. The workflow only triggers when files in `apps/web/**` are changed.

## Architecture

This project follows Hexagonal Architecture (Ports & Adapters):

- **Presentation Layer**: React components and UI
- **Application Layer**: Use cases and business logic (to be added)
- **Domain Layer**: Entities and value objects (to be added)
- **Infrastructure Layer**: External services and adapters (to be added)
