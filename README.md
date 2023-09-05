# Generic Drupal-compatible PHP container

Includes composer and drush, exposes PHP via fpm.

## Deprecated

Use [reload/php-fpm](https://github.com/reload/php-fpm/) instead.

## Xdebug

Xdebug is disabled pr. default but the extension is available and
we ship with xdebug.remote_connect_back enabled (when the extension
is enabled). To enable the xdebug-extension execute
/usr/local/bin/xdebug-start via docker, eg:

```console
docker exec -ti <container id> xdebug-start
```

Or via docker-compose, eg. if the image is used by a service called
fpm:

```console
docker-compose exec fpm xdebug-start
```

The scripts enables xdebug and blocks until the user presses enter
or terminates the script after which xdebug is disabled again.

## PHP extensions

The following PHP extensions will be enabled by default:

* calendar
* ctype
* curl
* dom
* exif
* fileinfo
* ftp
* gd
* gettext
* iconv
* json
* mcrypt
* mysqli
* mysqlnd
* opcache
* pdo
* pdo_mysql
* pdo_sqlite
* phar
* posix
* readline
* shmop
* simplexml
* soap
* sockets
* sqlite
* sysvmsg
* sysvsem
* sysvshm
* tokenizer
* wddx
* xml
* xmlreader
* xmlwriter
* xsl
* mbstring
* zip

If you want extra extensions enabled add a space separated list of
extensions to the environment variable `PHP_EXTRA_EXTENSIONS`.

If you want fewer extensions enabled list _all_ the extensions you
want enabled in the environment variable `PHP_DEFAULT_EXTENSIONS`.

Currently the following extra extensions are supported:

* bcmath
* imagick
* intl

## Blackfire integration

If the image is run with the environment-variable BLACKFIRE_SOCKET set
a blackfire php-probe will be enabled and configured to use the
socket. The variable is expected to point to a running blackfire
agent.

Eg. do the following in a docker-compose.yml

```yaml
version: "2"

services:
    php:
        image: ghcr.io/reload/docker-drupal-php7-fpm:8.1
        ports:
          - '9000:9000'
        links:
          - blackfire
        environment:
          BLACKFIRE_SOCKET: 'tcp://blackfire:8707'

    blackfire:
        image: blackfire/blackfire:2
        ports:
         - '8707:8707'
        environment:
          BLACKFIRE_SERVER_ID: 'INSERT-SERVER-ID-HERE'
          BLACKFIRE_SERVER_TOKEN: 'INSERT-SERVER-TOKEN-HERE'

```

Or the following using a docker-compose.override.yml. (Notice that you
have to include any original keys you want to preserve in an overriden
array - the "db" link in the example below)

```yaml
# file: docker-compose.yml
version: "2"

services:
  php:
    image: ghcr.io/reload/docker-drupal-php7-fpm:8.1
    links:
      - db
    environment:
      SOME_IMPORTANT_ENV: 'secret'

# file: docker-compose.override.yml
version: "2"

services:
  php:
    environment:
      SOME_IMPORTANT_ENV: 'secret'
      BLACKFIRE_SOCKET: 'tcp://blackfire:8707'

blackfire:
    image: blackfire/blackfire:2
    ports:
     - '8707:8707'
    environment:
      BLACKFIRE_SERVER_ID: 'INSERT-SERVER-ID-HERE'
      BLACKFIRE_SERVER_TOKEN: 'INSERT-SERVER-TOKEN-HERE'
```

## Mailhog (and other mailcatcher) integration

You can specify the path to the sendmail php should use to either
setup a mail-catcher or disable mail-sending (set it to /bin/false).

You specify the path to sendmail via the PHP_SENDMAIL_PATH
environment-variable. Eg. for a permanent setup via docker-compose.yml
that has a mailhog container:

```yaml
version: "2"

services:
    php:
      image: ghcr.io/reload/docker-drupal-php7-fpm:8.1
      ...
      environment:
        PHP_SENDMAIL_PATH: /usr/local/bin/mhsendmail --smtp-addr="mailhog:1025"

    mailhog:
      image: mailhog/mailhog
      # Web-inteface exposed on port 8025
      ports:
        - "8025:8025"
```

This can also be done via docker-compose.override.yml for temporary
local setups, again, remember to bring over any environment-variables
you want to maintain as variables added via
docker-compose.override.yml's overrides the entire environment array.

```yaml
# file: docker-compose.yml
version: "2"

services:
  php:
    image: ghcr.io/reload/docker-drupal-php7-fpm:8.1
    ...
    environment:
      SOME_IMPORTANT_ENV: 'secret'

# file: docker-compose.override.yml
version: "2"

services:
  php:
    environment:
      SOME_IMPORTANT_ENV: 'secret'
      PHP_SENDMAIL_PATH: /usr/local/bin/mhsendmail --smtp-addr="mailhog:1025"

  mailhog:
    image: mailhog/mailhog
    ports:
      - "8025:8025"
```

In the above examples the mailhog interface will be accessible on port
8025.

## [Wait application](https://github.com/ufoscout/docker-compose-wait)

Allows for waiting on containers, that containers created from these images
depends upon.
