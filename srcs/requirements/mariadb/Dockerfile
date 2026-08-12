# Use penultimate stable Debian version
FROM debian:bookworm

# Install MariaDB server
RUN apt-get update && apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

# Copy configuration and startup script
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/mariadb_start.sh /usr/local/bin/mariadb_start.sh

# Set executable permissions
RUN chmod +x /usr/local/bin/mariadb_start.sh

# Expose internal database port
EXPOSE 3306

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/mariadb_start.sh"]