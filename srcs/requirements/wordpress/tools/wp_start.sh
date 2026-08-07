#!/bin/sh

# Read secrets from files
DB_PASS=$(cat /run/secrets/db_password)
WP_ADMIN_PASS=$(cat /run/secrets/credentials)

# Navigate to WordPress web root
cd /var/www/wordpress

# Wait for MariaDB service to be accessible
echo "Waiting for MariaDB..."
until mariadb-admin ping -h"mariadb" --silent; do
    sleep 2
done

# Initialize WordPress if wp-config.php does not exist
if [ ! -f "wp-config.php" ]; then
    echo "Downloading WordPress core..."
    wp core download --allow-root

    echo "Creating wp-config.php..."
    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${DB_PASS}" \
        --dbhost="mariadb:3306" \
        --allow-root

    echo "Installing WordPress core..."
    wp core install \
        --url="https://${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASS}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email \
        --allow-root

    echo "Creating regular user..."
    wp user create \
        "${WP_USER}" \
        "${WP_USER_EMAIL}" \
        --user_pass="${WP_ADMIN_PASS}" \
        --role=author \
        --allow-root
fi

# Ensure correct permissions
chown -R www-data:www-data /var/www/wordpress

# Create run directory for PHP-FPM
mkdir -p /run/php

# Start PHP-FPM 7.4 in foreground (PID 1)
echo "Starting PHP-FPM..."
exec php-fpm7.4 -F