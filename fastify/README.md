# PROJECT_NAME_PLACEHOLDER

Fastify API server built with TypeScript.

## Development Setup

### Prerequisites

- Node.js 22+

### Installation

1. Install dependencies:
   ```bash
   npm install
   ```

2. Copy environment variables:
   ```bash
   cp .env.example .env
   ```

3. Start the development server:
   ```bash
   npm run dev
   ```

The server will start on http://localhost:3000

### Available Scripts

- `npm run dev` - Start development server with hot reload
- `npm run build` - Build for production
- `npm start` - Start production server
- `npm test` - Run tests in watch mode
- `npm run test -- --run` - Run tests once
- `npm run lint` - Run ESLint

### API Documentation

Visit http://localhost:3000/docs to view the Swagger UI documentation.

### Health Check

The server includes a basic health check endpoint at `GET /health`.

## Project Structure

```
src/
├── api/           # Route handlers (auto-loaded by Fastify)
├── hooks/         # Fastify hooks and utilities
├── lib/           # Business logic and utilities
└── schemas/       # JSON schemas for validation
```

## Development Guidelines

- Follow the TypeScript and Prettier configurations
- Write tests for all routes and utilities
- Use the provided SDK components for consistency
- Follow the established patterns for route handlers
- Add appropriate JSDoc comments for public functions
