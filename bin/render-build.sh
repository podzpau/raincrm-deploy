#!/usr/bin/env bash
# exit on error
set -o errexit

echo "Installing Ruby dependencies..."
bundle install --deployment

echo "Running database migrations..."
bundle exec rake db:migrate

echo "Build complete - skipping asset precompilation for runtime compilation"