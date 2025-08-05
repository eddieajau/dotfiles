
#!/bin/bash

# Bootstrap a basic Fastify Application
# Creates a new Fastify application with the same tooling and structure
# Usage: Run from your project directory: ./fastify.sh


# Bootstrap Fastify-specific setup
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Helper function to copy template files
copy_template() {
    local filename="$1"
    cp "$SCRIPT_DIR/fastify/$filename" "$filename"
}

# Helper function to copy template files with directory structure
copy_template_dir() {
    local source_path="$1"
    local target_dir="$(dirname "$source_path")"
    mkdir -p "$target_dir"
    cp "$SCRIPT_DIR/fastify/$source_path" "$source_path"
}


# Run TypeScript-agnostic setup
# "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"/typescript.sh

# Install Fastify-specific runtime dependencies
echo "npm i"
npm i \
  @fastify/autoload \
  @fastify/cors \
  @fastify/sensible \
  @fastify/swagger \
  @fastify/swagger-ui \
  fastify \
  fastify-plugin \
  ajv \
  dotenv \
  pino

npm i -D \
  pino-pretty

# Create project structure
mkdir -p src/{api,hooks,lib,schemas/{fastify/{plugins,schemas},auth0,cache,jwt,rest}}
mkdir -p test/fixtures
mkdir -p test/rest

# Create main application file
copy_template_dir "src/main.ts"

# Create basic logger
copy_template_dir "src/hooks/logger.ts"

# Create hooks index
copy_template_dir "src/hooks/index.ts"

# Create test structure
copy_template_dir "test/fixtures/index.ts"
copy_template_dir "test/rest/app.rest"


# Create environment files
copy_template_dir ".env.example"
cp .env.example .env

# Create README.md
copy_template "README.md"
sed -i'' "s/PROJECT_NAME_PLACEHOLDER/$PROJECT_NAME/g" README.md

# Fastify AI instructions
copy_template_dir ".github/specs/fastify.md"
echo "* [Fastify Development Requirements](./specs/fastify.md)" >> .github/copilot-instructions.md
