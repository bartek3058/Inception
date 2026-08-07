#!/bin/sh

# Generate SSL certificate if it does not exist
if [ ! -f /etc/nginx/ssl/inception.crt ]; then
    echo "Generating self-signed SSL certificate..."
    mkdir -p /etc/nginx/ssl
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/inception.key \
        -out /etc/nginx/ssl/inception.crt \
        -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=${DOMAIN_NAME}"
fi

# Start NGINX in foreground (PID 1) without using hacky tail/sleep loops
echo "Starting NGINX server..."
exec nginx -g "daemon off;"