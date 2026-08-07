#!/bin/sh

# Read secrets from files
DB_ROOT_PASS=$(cat /run/secrets/db_root_password)
DB_PASS=$(cat /run/secrets/db_password)

# Create system directories
mkdir -p /run/mysqld /var/lib/mysql
chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Initialize database directory if empty
if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null

    # Create temporary SQL initialization file
    TMP_FILE=$(mktemp)
    cat << EOF > "$TMP_FILE"
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    # Run initialization via bootstrap mode
    echo "Configuring database users and permissions..."
    mysqld --user=mysql --bootstrap < "$TMP_FILE"
    rm -f "$TMP_FILE"
fi

# Execute MariaDB in foreground (PID 1)
echo "Starting MariaDB server..."
exec mysqld --user=mysql