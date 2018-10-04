#!/usr/bin/env bash
#
# Builds all versions of the image.
#
set -xeuo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${SCRIPT_DIR}"

readonly IMAGE_NAME=reload/drupal-php7-fpm

readonly DOCKERFILES=Dockerfile*
for dockerfile in $DOCKERFILES ; do
    # Extract the trailing version for taggging.
    version="${dockerfile##*-}"

    docker build -t "${IMAGE_NAME}:${version}" -f "${dockerfile}" .
done
