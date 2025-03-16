FROM php:8.4-fpm-alpine

# Install required system dependencies for PHP extensions and tools.
RUN apk add --no-cache \
    openssl-dev \
    libzip-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    oniguruma-dev \
    curl-dev \
    zip unzip \
    wget

# Download and install the docker-php-extension-installer script.
RUN curl -fsSL https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions \
    -o /usr/local/bin/install-php-extensions && \
    chmod +x /usr/local/bin/install-php-extensions

# Install PHP extensions using the extension installer.
# This installs: pdo_mysql, curl, mbstring, zip, gd, and xml (for SimpleXML).
RUN install-php-extensions pdo_mysql curl mbstring zip gd xml @composer

# Set the working directory.
WORKDIR /var/www/html
