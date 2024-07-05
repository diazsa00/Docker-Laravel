# Use PHP with Apache as the base image
FROM php:8.3-apache as web

# Configura el directorio de trabajo
WORKDIR /var/www/html

# Install Additional System Dependencies
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Enable Apache mod_rewrite for URL rewriting
RUN a2enmod rewrite

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql zip

# Configure Apache DocumentRoot to point to Laravel's public directory
# and update Apache configuration files
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Copy the application code
COPY . /var/www/html

# Set the working directory
WORKDIR /var/www/html

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV COMPOSER_ALLOW_SUPERUSER=1

# Install project dependencies
RUN if [ -f composer.lock ]; then composer install --prefer-dist --no-scripts --no-dev --no-autoloader; else composer update; fi

# Crea los directorios necesarios y asigna los permisos adecuados
RUN mkdir -p /var/www/html/storage /var/www/html/bootstrap/cache \
    && chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html 
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/

# Expone el puerto 80
EXPOSE 80
EXPOSE 8000

# Inicia Apache
CMD ["apache2-foreground"]