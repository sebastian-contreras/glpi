FROM php:8.2-apache

# Instalar extensiones necesarias
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libldap2-dev \
    libzip-dev \
    zip unzip git curl \
    && docker-php-ext-install mysqli pdo pdo_mysql gd zip

# Descargar GLPI
WORKDIR /var/www/html
RUN curl -L https://github.com/glpi-project/glpi/releases/latest/download/glpi.tgz \
    -o glpi.tgz \
    && tar -xvzf glpi.tgz \
    && mv glpi/* . \
    && rm -rf glpi glpi.tgz

# Permisos
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

