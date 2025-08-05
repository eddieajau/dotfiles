#!/bin/bash

# Bootstrap a basic TypeScript project
# Usage: Source or run from your project directory: ./typescript.sh

set -e

# Use current directory name as project name
PROJECT_NAME=$(basename "$(pwd)")
echo "Bootstrapping TypeScript project: $PROJECT_NAME"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Helper function to copy template files
copy_template() {
    local filename="$1"
    cp "$SCRIPT_DIR/typescript/$filename" "$filename"
    echo "Copied template file: $filename"
}

# Helper function to copy template files with directory structure
copy_template_dir() {
    local source_path="$1"
    local target_dir="$(dirname "$source_path")"
    mkdir -p "$target_dir"
    cp "$SCRIPT_DIR/typescript/$source_path" "$source_path"
}

# Initialize git repository
copy_template ".gitignore"
git init

# Create package.json from template
copy_template "package.json"
sed -i'' "s/PROJECT_NAME_PLACEHOLDER/$PROJECT_NAME/g" package.json

# Install TypeScript agnostic dependencies (need Prettier because VS Code's plugin is out of date)
npm i -D \
  @tsconfig/node22 \
  @types/node \
  eslint \
  pino-pretty \
  prettier \
  rimraf \
  tsconfig-paths \
  ts-node \
  typescript \
  typescript-eslint \
  vitest

# Create TypeScript configuration from template
copy_template "tsconfig.json"

# Create testing configuration
copy_template "vitest.config.ts"

# Create Prettier configuration
copy_template ".prettierrc.json"

# Create VS Code configuration
copy_template_dir ".vscode/settings.json"

# Create GitHub Copilot instructions
copy_template_dir ".github/copilot-instructions.md"
