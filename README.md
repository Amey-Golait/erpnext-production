# Useful Bench Commands

bench start                           # Start dev server
bench new-site erp.amey.local              # Create new site
bench drop-site erp.amey.local             # Delete site
bench --site erp.amey.local install-app app_name    # Install app
bench --site erp.amey.local migrate        # DB + schema migrations
bench build                           # Rebuild assets
bench clear-cache                     # Clear Frappe cache
bench run-tests --app app_name        # Run tests
bench --site erp.amey.local backup         # Backup site
bench --site erp.amey.local --force restore path    # Restore from backup


# Activate virtualenv
source env/bin/activate

# Install apps (order matters)
bench --site erp.amey.local install-app frappe
bench --site erp.amey.local install-app erpnext
bench --site erp.amey.local install-app clinic_app
bench --site erp.amey.local install-app student_master
bench --site erp.amey.local install-app payments_processor
bench --site erp.amey.local install-app payment_integration_utils
bench --site erp.amey.local install-app razorpayx_integration

# Start the development server (runs Redis, web, socketio, etc.)
bench start

# Apply schema changes, sync doctypes, run patch logic
bench --site erp.amey.local migrate

# Install dev dependencies
bench setup requirements --dev

# Run tests for a specific app
bench --site erp.amey.local run-tests --app clinic_app

# Clear caches
bench --site erp.amey.local clear-cache
bench --site erp.amey.local clear-website-cache
bench clear-cache

# Rebuild JS, CSS, translations
bench build


# Remove all __pycache__ directories
find . -name "__pycache__" -type d -exec rm -rf {} +
find . -name "*.pyc" -delete

# Initialize git in custom app
cd apps/clinic_app
git init
git remote add origin https://github.com/your-org/clinic_app.git

# Commit and push
git add .
git commit -m "Initial setup"
git push origin main


# DANGER: Completely deletes DB for the site
bench drop-site erp.amey.local
