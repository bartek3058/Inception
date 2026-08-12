# User Documentation

## Provided Services
This stack provides a fully functioning WordPress site served securely over HTTPS via NGINX with a MariaDB database backend.

## How to Start and Stop
- **Start Services:** Run `make` or `make up` in the root folder.
- **Stop Services:** Run `make down`[cite: 1].

## Accessing the Website
1. Ensure `127.0.0.1 brogalsk.42.fr` is added to your `/etc/hosts` file.
2. Open your web browser and navigate to: `https://brogalsk.42.fr`.
3. Access the WordPress Administration Panel at: `https://brogalsk.42.fr/wp-admin`

## Credentials Management
Credentials are stored securely in local text files inside the `secrets/` directory:
- Database Root Password: `secrets/db_root_password.txt`
- Database User Password: `secrets/db_password.txt`
- WordPress Admin Credentials: `secrets/credentials.txt`

## Service Health Check
To verify that all services are running properly, execute:
```bash
docker compose -f srcs/docker-compose.yml ps