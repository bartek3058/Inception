---

**3. Developer Setup Guide (`DEV_DOC.md`)**

```markdown
# Developer Documentation

## Prerequisites & Environment Setup
- **Operating System:** Debian 11/12 or Alpine Linux
- **Required Packages:** `docker.io`, `docker-compose-v2`, `make`
- Required host directory structure:
  `/home/brogalsk/data/wordpress`
  `/home/brogalsk/data/mariadb`

## Build and Launch
1. Clone the project repository.
2. Verify that `secrets/` contains valid password files and `srcs/.env` is configured.
3. Compile and build the stack:
   ```bash
   make