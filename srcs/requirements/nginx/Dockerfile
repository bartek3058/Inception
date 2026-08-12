# Use penultimate stable Debian version
FROM debian:bookworm

# Install NGINX and OpenSSL
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Copy configuration and startup script
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf
COPY tools/nginx_start.sh /usr/local/bin/nginx_start.sh

# Set executable permissions
RUN chmod +x /usr/local/bin/nginx_start.sh

# Expose HTTPS port
EXPOSE 443

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/nginx_start.sh"]