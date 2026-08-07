*This project has been created as part of the 42 curriculum by brogalsk.*

## Description
Inception is a system administration project aimed at building a small, secure infrastructure using Docker Compose inside a Virtual Machine. The stack consists of NGINX (TLSv1.2/v1.3 only), WordPress with PHP-FPM, and MariaDB, each isolated in custom Docker containers built from scratch.

## Instructions
- **Build and Start:** `make`
- **Stop Infrastructure:** `make down`
- **Full Reset:** `make re`

## Project Description & Comparisons

### Virtual Machines vs Docker
Virtual Machines virtualize the underlying hardware, requiring a full guest operating system for each instance. Docker virtualizes at the operating system level, sharing the host kernel while isolating containerized processes. This makes Docker significantly lighter, faster to deploy, and more resource-efficient.

### Secrets vs Environment Variables
Environment variables are suitable for non-sensitive configuration parameters (such as domain names or database names). Secrets are securely mounted at runtime into isolated files (`/run/secrets/`), preventing sensitive credentials from being exposed in environment listings, process tables, or build logs.

### Docker Network vs Host Network
Using `host` networking bypasses Docker's network isolation, exposing all container ports directly on the host machine. A custom Docker bridge network creates an isolated private virtual network where containers communicate securely via internal DNS names without exposing unused ports externally.

### Docker Volumes vs Bind Mounts
Bind mounts link a specific host directory directly into a container, which depends heavily on host file system paths and permission structures. Docker named volumes are managed entirely by Docker, providing better isolation, persistence, performance, and portability across different host environments.

## Resources
- Official Docker Documentation: https://docs.docker.com/
- NGINX SSL Configuration Guide: https://nginx.org/en/docs/http/configuring_https_servers.html
- WordPress CLI Handbook: https://developer.wordpress.org/cli/commands/

### AI Usage
AI tools were used during this project to assist with:
- Generating starter templates for custom shell entrypoint scripts.
- Debugging NGINX fastcgi pass configurations for PHP-FPM.
- Structuring Markdown documentation according to project requirements.