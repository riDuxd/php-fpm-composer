# php-fpm-composer

A lightweight Docker image based on **Alpine Linux** that includes **PHP-FPM**, **Composer**, and a set of commonly used PHP extensions. This image is ideal as a base for Laravel, Symfony, WordPress, or other PHP projects needing a minimal footprint and easy Composer usage.

## Features

- **PHP-FPM**: Handles PHP application processes efficiently (listens on port **9000** by default).
- **Composer**: Pre-installed for dependency management.
- **Alpine Linux**: Lightweight, secure, and minimal base.
- **Common Extensions**: pdo_mysql, curl, mbstring, zip, gd, xml, etc.
- **Easy Extensibility**: Uses [docker-php-extension-installer][mlocati-link] for quick installation of additional extensions.

## Usage

1. **Pull the Image**

   ```bash
   docker pull riduxd/php-fpm-composer:latest
   ```

2. **Run a Container**

   ```bash
   docker run -d \
     --name php_app \
     -p 9000:9000 \
     riduxd/php-fpm-composer:latest
   ```

   - By default, PHP-FPM listens on **port 9000** inside the container.
   - You can remap this port if needed (e.g., `-p 9001:9000`).

3. **In a Docker Compose Setup**

   ```yaml
   services:
     app:
       image: riduxd/php-fpm-composer:latest
       volumes:
         - ./src:/var/www/html
       # ...

     nginx:
       image: nginx:alpine
       ports:
         - "80:80"
       # ...
   ```

4. **Add or Update PHP Extensions**
   - If you want additional extensions, you can modify the Dockerfile and re-run:
     ```bash
     RUN install-php-extensions <new-extension>
     ```

## Example Dockerfile

If you want to build from source:

```dockerfile
FROM php:8-fpm-alpine

RUN apk add --no-cache wget curl zip unzip

# Download and install the docker-php-extension-installer script
RUN curl -fsSL https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions \
    -o /usr/local/bin/install-php-extensions && \
    chmod +x /usr/local/bin/install-php-extensions

# Install PHP extensions and Composer
RUN install-php-extensions \
    pdo_mysql \
    curl \
    mbstring \
    zip \
    gd \
    xml \
    @composer

WORKDIR /var/www/html
```

## Credits

**docker-php-extension-installer** script by [mlocati][mlocati-link]. This tool simplifies building and installing PHP extensions in Docker images.

## License

This project is provided under an MIT License. Refer to the [LICENSE](./LICENSE) file for details.

[mlocati-link]: https://github.com/mlocati/docker-php-extension-installer
