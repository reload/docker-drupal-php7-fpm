#!/bin/bash

PHP_EXTENSIONS="${PHP_DEFAULT_EXTENSIONS} ${PHP_EXTRA_EXTENSIONS}"
PHP_AVAILABLE_EXTENSIONS=$(/usr/sbin/phpquery -q -v "${PHP_VERSION}" -s ALL -M)

# Disable all modules first.
for m in ${PHP_AVAILABLE_EXTENSIONS}; do
    phpdismod -q -v "${PHP_VERSION}" -s ALL -m "${m}"
done

# Enable wanted modules now.
for m in ${PHP_EXTENSIONS}; do
    phpenmod -q -v "${PHP_VERSION}" -s ALL -m "${m}"
done
