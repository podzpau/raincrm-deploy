#!/usr/bin/env bash
# exit on error
set -o errexit

echo "Installing Ruby dependencies..."
bundle install --deployment

echo "Setting up database..."
bundle exec rake db:create db:migrate

echo "Build complete - skipping asset precompilation for runtime compilation"