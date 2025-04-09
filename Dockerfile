FROM php:8.3-apache

# Install required PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Enable Apache mod_rewrite
RUN a2enmod rewrite

ENV APACHE_DOCUMENT_ROOT=/var/www/html/public

# Update Apache's default site config
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/000-default.conf \
    && echo "<Directory /var/www/html/public>\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>" >> /etc/apache2/apache2.conf

    # Set working directory
WORKDIR /var/www/html

# Copy project files to container
COPY . /var/www/html

RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80