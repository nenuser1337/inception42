#!/bin/sh

# Wait for MariaDB to be ready
while ! mysqladmin ping -h"mariadb" -u"${USER}" -p"${PASS}" --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 1
done

# Create wp-config.php if it doesn't exist
if [ ! -f "wp-config.php" ]; then
    wp config create --allow-root \
        --dbname="${DB_NAME}" \
        --dbuser="${USER}" \
        --dbpass="${PASS}" \
        --dbhost="mariadb:3306"
    
    echo "wp-config.php created successfully"
fi

# Install WordPress if not already installed
if ! wp core is-installed --allow-root; then
    wp core install --allow-root \
        --url="${DOMAIN_NAME}" \
        --title="${TITLE}" \
        --admin_user="${ADMIN}" \
        --admin_password="${ADMIN_PASS}" \
        --admin_email="${ADMIN_EMAIL}"
    
    wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
        --user_pass="${WP_PASS}" \
        --role="${ROLE}" \
        --allow-root

    echo "WordPress installed successfully"
fi

# Ensure correct permissions
chown -R nobody:nobody /var/www
chmod -R 755 /var/www

echo "Starting PHP-FPM..."
exec php-fpm83 -F