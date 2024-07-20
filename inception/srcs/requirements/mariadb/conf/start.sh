#!/bin/sh

echo "Starting MariaDB..."
/usr/bin/mysqld_safe --datadir=/var/lib/mysql &

# Wait for MariaDB to be ready
for i in {30..0}; do
    if mysqladmin ping >/dev/null 2>&1; then
        echo "MariaDB is ready!"
        break
    fi
    echo "Waiting for MariaDB to be ready... $i seconds left"
    sleep 1
done

if [ "$i" = 0 ]; then
    echo >&2 "MariaDB did not become ready in time"
    exit 1
fi

echo "Initializing MariaDB..."

# Initialize root user
mysql -e "SELECT User, Host FROM mysql.user WHERE User='root';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"
echo "Root user initialized."

# Check and create database
if ! mysql -e "USE $DB_NAME;" 2>/dev/null; then
    echo "Creating database: $DB_NAME"
    mysql -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
    echo "Database created."
else
    echo "Database $DB_NAME already exists."
fi

# Check and create user
if ! mysql -e "SELECT User FROM mysql.user WHERE User='$USER';" | grep -q "$USER"; then
    echo "Creating user: $USER"
    mysql -e "CREATE USER '$USER'@'%' IDENTIFIED BY '$PASS';"
    mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$USER'@'%';"
    mysql -e "FLUSH PRIVILEGES;"
    echo "User created and privileges granted."
else
    echo "User $USER already exists."
fi

echo "MariaDB setup complete. Keeping container running..."
tail -f /dev/null