#!/bin/bash

cd /home/frappe/frappe-bench

# Build production assets
bench build --production --force

# Start development server (for Render)
bench serve --port ${PORT:-8000}
