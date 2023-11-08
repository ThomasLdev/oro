FROM proxy-docker.norsys.fr/php:8.2-fpm

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
    wget
    
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get -y install nodejs
RUN npm install -g npm@9.3.1

RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-install ldap

RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install imap

RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql && \
    docker-php-ext-install pdo pdo_pgsql pgsql

RUN docker-php-ext-install -j$(nproc) gd xsl intl zip soap pcntl sockets bcmath

RUN pecl install mongodb && docker-php-ext-enable mongodb

COPY --from=composer:2.6.3 /usr/bin/composer /usr/local/bin/composer

RUN echo 'memory_limit = 1024M' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini;

RUN rm /etc/nginx/sites-enabled/default
COPY nginx.conf /etc/nginx/conf.d/default.conf 
COPY ./docker-entrypoint /docker-entrypoint

EXPOSE 80
ENTRYPOINT [ "/bin/bash" ,"/docker-entrypoint"]
CMD [ "php-fpm" ]
