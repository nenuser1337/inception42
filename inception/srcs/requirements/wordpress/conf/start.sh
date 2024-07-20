#!/bin/sh

sleep 3

if ! [ -f "wp-config.php" ]
then

    echo config not found ... creating one

    wp config create --allow-root --dbname="${DB_NAME}" --dbuser="${USERR}" --dbpass="${PASS}" --dbhost="mariadb:3306"

    wp core install --url="${DOMAIN_NAME}" --title="${TITLE}" --admin_user="${ADMIN}" --admin_password="${ADMIN_PASS}" --admin_email="${ADMIN_EMAIL}" --allow-root

    wp user create "${WP_USER}" "${WP_USER_EMAIL}" --user_pass="${WP_PASS}" --role=editor --allow-root

else 
    echo config is already there 

fi

chmod -R 0777 wp-content/

exec php-fpm83 -F