# Use the official PHP image as a base image
FROM php:8.2-fpm-alpine

# Set the working directory
WORKDIR /var/www/html

# Copy source files
COPY ./src/ ./

# Install dependencies
RUN apk add --no-cache --virtual .build-deps \
    autoconf \
    gcc \
    make \
    g++ \
    linux-headers \
    && apk add --no-cache \
    nginx \
    mariadb-client \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set environment variable to allow Composer to run as root
ENV COMPOSER_ALLOW_SUPERUSER=1

# Install PHP dependencies
#RUN composer install
# dependencies are already included in src with this image

# Expose the port the app runs on
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]
