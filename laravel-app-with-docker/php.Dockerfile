FROM php:8.3.21-fpm-alpine3.20

# Ishchi katalogni o'rnatish
WORKDIR /var/www/laravel

# PHP kengaytmalarini o'rnatish
RUN apk add --no-cache \
        bash \
        libpng-dev \
        libjpeg-turbo-dev \
        libwebp-dev \
        libxpm-dev \
        freetype-dev \
        zip \
        unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pdo pdo_mysql bcmath

# Composer'ni o'rnatish
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN docker-php-ext-install pdo pdo_mysql

# Ishlatish uchun ruxsatlar berish
RUN chown -R www-data:www-data /var/www/laravel \
    && chmod -R 775 /var/www/laravel

# Default user
USER www-data
