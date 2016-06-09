# Generic Drupal-compatible php7 container
Includes composer and drush, exposes PHP via fpm.

## Blackfire integration
If the image is run with the environment-variable BLACKFIRE_SOCKET set a blackfire php-probe will be enabled and configured to use the socket. The variable is expected to point to a running blackfire agent.
Eg. do the following in a docker-compose.yml
```
version: "2"

services:
    php:
        image: reload/drupal-php7-fpm
        ports:
          - '9000:9000'
        links:
          - blackfire
        environment:
          BLACKFIRE_SOCKET: 'tcp://blackfire:8707'

    blackfire:
        image: blackfire/blackfire
        ports:
         - '8707:8707'
        environment:
          BLACKFIRE_SERVER_ID: 'INSERT-SERVER-ID-HERE'
          BLACKFIRE_SERVER_TOKEN: 'INSERT-SERVER-TOKEN-HERE'

```
Or the following using a docker-compose.override.yml. (Notice that you have to include any original keys you want to preserve in an overriden array - the "db" link in the example below)
```
# file: docker-compose.yml
version: "2"

services:
  php:
    image: reload/drupal-php7-fpm
    links:
      - db

# file: docker-compose.override.yml
version: "2"

services:
  php:
    links:
      - db
      - blackfire
    environment:
      BLACKFIRE_SOCKET: 'tcp://blackfire:8707'

blackfire:
    image: blackfire/blackfire
    ports:
     - '8707:8707'
    environment:
      BLACKFIRE_SERVER_ID: 'INSERT-SERVER-ID-HERE'
      BLACKFIRE_SERVER_TOKEN: 'INSERT-SERVER-TOKEN-HERE'
```
