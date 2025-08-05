# Fastify Development

- Fastify plugins use fastify-plugin and follow the Fastify plugin pattern
- Fastify plugins are organized in a modular way with clear responsibilities
- Reply handlers should return the response directly or a Fastify Sensible error
- Always use Fastify's schema to validate the request header, path, query, or body parameters
- Unless asked, do not add logging in handlers - logging is configured on the Fastify instance

## API Autoloading

- Route plugins are under the `/src/api` folder following the conventions for the Fastify autoload plugin
- Files are named using a `methodContext.ts` convention. For example `GET /things` would be implemented in `src/api/things/getThings.ts`
- Route handlers use custom sugar found in `@eddieajau/fastify`.
- The `handler` function should just return the data and let it, or any errors, to be handled by Fastify internals
- The `schema` variable defines the validation for query parameters, path parameters, request body or the response using Fastify internals.

### Example GET Route Handler

```typescript
/**
 * @copyright 2025 Andrew Eddie. All rights reserved.
 */

import { GET } from '@eddieajau/fastify'
import { RouteHandler } from 'fastify'

interface GetThingsQuery {
  id?: number[]
}

const handler: RouteHandler<{ Querystring: GetThingsQuery }> = async (
  request,
  reply
) => {
  // Compute the data to be returned
  return data
}

const schema = {
  querystring: {
    allOf: [
      {
        type: 'object',
        properties: {
          id: {
            description: 'Filter the list of records by one or more IDs',
            type: 'array',
            items: { type: 'number' },
          },
        },
      },
    ],
  },
  response: {
    200: {
      description: 'Get a list of Thing records.',
      content: {
        'application/json': {
          schema: {
            allOf: [
              {
                type: 'object',
                properties: {
                  data: {
                    type: 'array',
                    items: {
                      $ref: 'Thing',
                    },
                  },
                },
              },
            ],
          },
        },
      },
    },
  },
}

// POST, PUT, DELETE and PATCH wrappers are also supported
export default GET(handler, { schema })
```
