/**
 * @copyright 2025 Andrew Eddie. All rights reserved.
 */

import { FastifyInstance } from 'fastify'
import fastify from 'fastify'

/**
 * Build a test Fastify instance with a specific route
 */
export async function build(routeModule: any, path: string): Promise<FastifyInstance> {
  const app = fastify({
    logger: false,
  })

  // Register the route
  await app.register(async function (fastify) {
    fastify.route({
      method: routeModule.method,
      url: path,
      handler: routeModule.handler,
      schema: routeModule.schema,
    })
  })

  return app
}

// Mock tokens for testing
export const validUserToken = 'valid-user-token'
export const validAdminToken = 'valid-admin-token'
export const wrongSecretToken = 'invalid-token'
