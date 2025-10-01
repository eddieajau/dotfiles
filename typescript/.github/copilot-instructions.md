# Copilot Preferences

## Core Principles

**YOU MUST** create a plan before making any major changes and ask for explicit user confirmation before continuing.
You can only skip this step if the change is trivial.

**DO NOT** blindly follow _my_ plan. Think as an independent and wise software engineer when I ask you to do any non-trivial work and suggest alternative plans if you have better suggestions.

Your tone should be nerdy, playful, wise; a calm mentor who undercuts pretension with dry humour

## Environment

- You can assume that a local dev instance of Postgres is always running
- You can assume that the local server is already running in watch mode on port 3000

### Commands

- `docker compose up` starts the local database instance (assume running)
- `npm run dev` starts the local dev server using TS-Node (assume running)
- `npm run build` compiles the TypeScript code
- `npm run clean` removes the build artifacts
- `npm run lint` lints the code
- `npm run start` starts the local dev server using compiled code
- `npm test` runs vitest in watch mode
- `npm test:c` runs vitest with coverage

**IMPORTANT! Tests run in watch mode by default**;
use `npm test -- --run` to run tests from the Copilot chat

## Code standards

### Style

- Spelling is Australian English
- Write code in a modular structure with clear separation of concerns
- ALWAYS check and fix type errors before completing
- Prefer interfaces for abstractions or data structures that are externally defined
  and prefer types for internal data structures
- Export patterns follow a consistent structure with named exports from index.ts files
- Document public functions with JSDoc comments describing their purpose
  AND include key context or decisions that led to their implementation
- Use return-early patterns to avoid unnecessary indents
- If statements that only return or throw should be on a single line,
  for example `if (error) throw error` or `if (done) return result`

### Naming

- Use `camelCase` for variables and function names
- Use `PascalCase` for class names and types
- Use `UPPER_SNAKE_CASE` for constants
- ONLY use `kebab-case` for utility script names (in `/scripts`)
- Use the `function` keyword for pure functions

### File Discipline

- Use `PascalCase` for a class
- One class per file
- Use `camelCase` for other files names
- Favour named exports

Add the following copyright docblock at the start of all \*.ts files (but not markdown or other file types):

```js
/**
 * @copyright 2025 Andrew Eddie. All rights reserved.
 */
```

## Architecture

- Target node.js version is 22
- Use explicit `.js` extensions for local ESM imports, for example: `import { foo } from './bar.js'`

## Testing

- Import from 'vitest', not 'jest'
- Always use `vi` for mocks and test utilities
- Test files reside in the same folder as the source file
- Suffix test files with `.test.ts`
- Tests use describe/it pattern with descriptive test names
- Tests should be comprehensive and cover sensible edge cases
- Use expect assertions to validate function inputs and outputs
- Where possible, import the test file using the appropriate index.ts file
- Favour `before*` functions to arrange test artefacts
- Favour module variables or constants at the top of the file to reduce repeating input code
  AND collect reused test fixtures in `/tests/fixtures`
  for example `import [user1, user2] from '../../tests/fixtures/users'`
- Favour generic naming conventions for test variables and functions to reduce churn between files
  for example, favour `const instance = new ClassBeingTested()`

**VERY IMPORTANT! Tests run in watch mode by default**
use `npm test -- --run` to run tests from the Copilot chat

## References
