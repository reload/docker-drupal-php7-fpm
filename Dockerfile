FROM sunfoxcz/baseimage:0.10.1

MAINTAINER Mads H. Danquah <mads@reload.dk>

# Basic package installation
RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get -y install \
      php7.0-fpm \
      php7.0-curl \
      php7.0-gd \
      php7.0-xml \
      php7.0-mysql \
      php-xdebug \
      # Mysql-client added to support eg. drush sqlc
      mysql-client \
      # Git and unzip are required by composer
      git \
      unzip \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Setup fpm paths and log
RUN \
  mkdir /run/php/ && \
  chown www-data:www-data /run/php/ && \
  touch /var/log/fpm-php.www.log && \
  chown www-data:www-data /var/log/fpm-php.www.log

# Install composer 1.1.1
RUN \
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
  php -r "if (hash_file('SHA384', 'composer-setup.php') === '92102166af5abdb03f49ce52a40591073a7b859a86e8ff13338cf7db58a19f7844fbc0bb79b2773bf30791e935dbd938') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
  php composer-setup.php --version=1.1.1 --filename=composer --install-dir=/usr/local/bin && \
  php -r "unlink('composer-setup.php');"

# Install drush 8 via composer
# See http://docs.drush.org/en/master/install-alternative/#install-a-global-drush-via-composer
RUN \
  mkdir --parents /opt/drush-8.x && \
  cd /opt/drush-8.x && \
  composer init --require=drush/drush:8.* -n && \
  composer config bin-dir /usr/local/bin && \
  composer install

# Put our configurations in place, done as the last step to be able to override
# default settings from packages.
COPY files/etc/ /etc/

EXPOSE 9000
