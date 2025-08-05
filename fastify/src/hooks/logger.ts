/**
 * @copyright 2025 Andrew Eddie. All rights reserved.
 */

import { FastifyBaseLogger } from 'fastify'

let _logger: FastifyBaseLogger

export function logger(log?: FastifyBaseLogger) {
  if (log) {
    _logger = log
  }
  return _logger
}