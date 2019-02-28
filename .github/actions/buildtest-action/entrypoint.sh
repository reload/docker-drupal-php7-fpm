#!/bin/sh -l

set -euxo pipefail

# Build image.
docker build --file=Dockerfile-${VERSION} -t docker-drupal-php7-fpm:sut-${VERSION} .

# Build another baseed on the first with test tool.
docker build --build-arg VERSION=${VERSION} --file=Dockerfile-goss -t docker-drupal-php7-fpm:sut-${VERSION} .

# Run test. Set home for composer (else it gets angry) and use wait-for-it to wait for FPM startup.
docker run -e GOSS_PHP_VERSION=${VERSION} docker-drupal-php7-fpm:sut-${VERSION} /sbin/my_init -- sh -c "export HOME=/root && wait-for-it -t 5 localhost:9000 && /goss/goss -g /goss/goss.yaml validate --format documentation" 
