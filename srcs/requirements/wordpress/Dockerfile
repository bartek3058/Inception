# Use penultimate stable Debian version
FROM debian:bookworm

# Install PHP-FPM, PHP extensions, MariaDB client, and curl
RUN apt-get update && apt-get install -y \
    php7.4-fpm \
    php7.4-mysqli \
    php7.4-curl \
    php7.4-dom \
    php7.4-mbstring \
    php7.4-xml \
    mariadb-client \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install WP-CLI (WordPress Command Line Interface)
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copy PHP-FPM pool configuration and startup script
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/wp_start.sh /usr/local/bin/wp_start.sh

# Set executable permissions
RUN chmod +x /usr/local/bin/wp_start.sh

# Create web root directory
RUN mkdir -p /var/www/wordpress

# Expose PHP-FPM port
EXPOSE 9000

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/wp_start.sh"]