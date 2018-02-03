FROM ubuntu:16.04
LABEL maintainer="A.Erkan ÇELİK <erkan.celik@formalistech.com>"

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y language-pack-en
RUN update-locale LANG=en_US.UTF-8
RUN apt-get -y install software-properties-common
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 6494C6D6997C215E
RUN LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN apt-get update
RUN apt-get install -y mcrypt \
    nginx \
    php7.1-fpm \
    php7.1-pgsql \
    php7.1-intl \
    php7.1-gd \
    php7.1-memcached \
    php7.1-imagick \
    php7.1-xdebug \
    php7.1-curl \
    php7.1-apcu \
    php7.1-imap \
    php7.1-mongo \
    php7.1-xml \
    php7.1-zip \
    php7.1-sqlite3 \
    build-essential \
    chrpath \
    libssl-dev \
    libxft-dev \
    libfreetype6 \
    libfreetype6-dev \
    libfontconfig1 \
    libfontconfig1-dev \
    npm \
    wget \
    supervisor \
    git \
    unzip \
    curl \
    nano
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
ADD conf/supervisord.conf /etc/supervisord.conf
RUN rm -Rf /etc/nginx/nginx.conf
ADD conf/nginx.conf /etc/nginx/nginx.conf
RUN rm -Rf /var/www/* && \
    mkdir /var/vhosts/ && \
    chown -R www-data:www-data /var/www/ && \
    chown -R www-data:www-data /var/vhosts/
ADD src/index.php /var/www/index.php
ADD conf/nginx-site.conf /etc/nginx/sites-available/default
ADD conf/project-site.conf /etc/nginx/sites-available/symfony-site.conf
RUN ln -s /etc/nginx/sites-available/symfony-site.conf /etc/nginx/sites-enabled/symfony-site.conf
ADD conf/www.conf /etc/php/7.1/fpm/pool.d/www.conf
ADD conf/php-fpm.conf /etc/php/7.1/fpm/php-fpm.conf
ADD conf/php.ini /etc/php/7.1/fpm/php.ini
ADD conf/20-xdebug.ini /etc/php/7.1/fpm/conf.d/20-xdebug.ini
RUN echo "apc.enable_cli=1" > /etc/php/7.1/cli/php.ini
RUN chsh -s /bin/bash www-data

# Add Scripts
ADD scripts/start.sh /start.sh
RUN chmod 755 /start.sh

EXPOSE 80

CMD ["/start.sh"]
