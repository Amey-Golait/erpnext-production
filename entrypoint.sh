#!/bin/bash
set -e

echo "[entrypoint] Starting ERPNext Docker container..."

SITE_NAME="erp.amey.local"
SITES_DIR="/home/frappe/frappe-bench/sites"
SITE_PATH="$SITES_DIR/$SITE_NAME"

cd /home/frappe/frappe-bench

echo "[entrypoint] Checking if site '$SITE_NAME' exists at $SITE_PATH..."
if [ -d "$SITE_PATH" ]; then
  echo "[entrypoint] Site '$SITE_NAME' already exists."
else
  echo "[entrypoint] ERROR: Site directory not found at $SITE_PATH"
  echo "[entrypoint] You must create the site locally and push it with database config."
  exit 1
fi

echo "[entrypoint] Setting current site to $SITE_NAME"
echo "$SITE_NAME" > "$SITES_DIR/currentsite.txt"

echo "[entrypoint] Checking and installing apps..."
installed_apps=$(bench --site "$SITE_NAME" list-apps || true)
for app in clinic_app student_master payments_processor payment_integration_utils razorpayx_integration; do
  if ! echo "$installed_apps" | grep -q "$app"; then
    echo "[entrypoint] Installing app: $app"
    bench --site "$SITE_NAME" install-app "$app"
  else
    echo "[entrypoint] ✔️ App $app already installed."
  fi
done

echo "[entrypoint] Running database migrations..."
bench --site "$SITE_NAME" migrate

echo "[entrypoint] Starting Frappe server using Gunicorn on port $PORT..."
exec bench serve --port "$PORT"
