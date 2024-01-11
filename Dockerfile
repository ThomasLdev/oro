FROM php:8.2-fpm

RUN apt-get update && apt-get install -y --fix-missing   \
    nginx\
    git \
    zip  \
    libzip-dev  \
    unzip  \
    libfreetype6-dev  \
    libjpeg62-turbo-dev  \
    libxslt-dev  \
    libpng-dev  \
    libc-client-dev  \
    libkrb5-dev  \
    libldap2-dev \
    libpq-dev \
    postgresql-client \
    postgresql \
    wget \
    nano \
    locate

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get -y install nodejs
RUN npm install -g npm@9.3.1

RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-install ldap

RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install imap

RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql && \
    docker-php-ext-install pdo pdo_pgsql pgsql

RUN docker-php-ext-install opcache \
RUN pecl install apcu && docker-php-ext-enable apcu

RUN docker-php-ext-install -j$(nproc) gd xsl intl zip soap pcntl sockets bcmath

RUN pecl install mongodb && docker-php-ext-enable mongodb

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Dev tools >
# --- Xdebug
RUN pecl install xdebug-3.2.1 && docker-php-ext-enable xdebug
RUN rm /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# --- Symfony CLI
RUN wget https://get.symfony.com/cli/installer -O - | bash && mv /root/.symfony5/bin/symfony /usr/local/bin/symfony

# --- Bash aliases
COPY ./php/.bashrc /root/.bashrc
# Dev tools <

# PHP configuration >
COPY ./php/conf.d /usr/local/etc/php/conf.d
# PHP configuration <

RUN rm /etc/nginx/sites-enabled/default
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY ./docker-entrypoint /docker-entrypoint

EXPOSE 80
ENTRYPOINT [ "/bin/bash" ,"/docker-entrypoint"]
CMD [ "php-fpm" ]
