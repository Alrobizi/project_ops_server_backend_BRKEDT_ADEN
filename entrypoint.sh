#!/bin/bash
set -e

echo "Starting deployment setup..."

# Link storage
php artisan storage:link || true

# Run migrations if DB is configured
if [ -n "$DB_HOST" ] && [ "$DB_CONNECTION" != "sqlite" ]; then
    echo "Running database migrations..."
    php artisan migrate --force || echo "Migration warning: could not connect or migrate yet."
fi

# Cache configuration in production
php artisan config:cache || true
php artisan route:cache || true
php artisan view:cache || true

echo "Starting PHP-FPM and Nginx..."
php-fpm -D
nginx -g "daemon off;"
