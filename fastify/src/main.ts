/**
 * @copyright 2025 Andrew Eddie. All rights reserved.
 */

import { addResponseTime, getEnv, useSchemas } from '@eddieajau/fastify'
import fastifyAutoload from '@fastify/autoload'
import fastifyCors from '@fastify/cors'
import fastifySensible from '@fastify/sensible'
import fastifySwagger from '@fastify/swagger'
import fastifySwaggerUi from '@fastify/swagger-ui'
import dotenv from 'dotenv'
import fastify from 'fastify'
import path, { dirname } from 'path'
import { fileURLToPath } from 'url'
import pkg from '../package.json' with { type: 'json' }
// import applicationSchemas from './schemas/index.js'
import { logger } from './hooks/logger.js'

dotenv.config()


const __filename = fileURLToPath(import.meta.url)
const __dirname = dirname(__filename)

async function startServer() {
  // Ensure these environment variables are set in the .env file
  const name = getEnv('NAME', pkg.name)
  const logLevel = getEnv('LOG_LEVEL', 'info')
  const port = Number(getEnv('TARGET_PORT', '3000'))
  const { description, version } = pkg

  const server = fastify({
    logger: { level: logLevel },
    ajv: {
      customOptions: {
        allErrors: true, // Return all validation errors, not just the first one
        verbose: true, // Include more detailed error information
      }
    }
  })

  // Initialise the logger
  logger(server.log)

  // Register CORS plugin
  await server.register(fastifyCors, {
    origin: true,
    credentials: true,
  })

  // Setup sensible (errors)
  server.register(fastifySensible)

  // Log routes when added
  server.addHook('onRoute', route => {
    server.log.trace(`Route registered: ${route.method} ${route.url}`)
  })

  // Add metrics
  server.register(addResponseTime)

  // Register schemas with application schemas passed as an option
  await server.register(useSchemas /*, { schemas: applicationSchemas }*/)

  // Setup swagger
  server.register(fastifySwagger, {
    openapi: {
      info: { title: name, description, version },
      servers: [],
    },
  })

  // Setup swagger ui
  server.register(fastifySwaggerUi, {
    routePrefix: '/docs',
  })

  // Setup autoload
  server.register(fastifyAutoload, {
    dir: path.join(__dirname, 'api'),
    routeParams: true,
    ignorePattern: /\.test\./,
  })

  await server.listen({ port, host: '0.0.0.0' })
  server.log.info('Server started')
}

startServer().catch(err => {
  console.error('\nFATAL application error caught in main.ts\n', err)
  process.exit(1)
})
