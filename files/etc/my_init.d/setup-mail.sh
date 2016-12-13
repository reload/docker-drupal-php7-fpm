#!/usr/bin/env bash
# Enable a simple "module" that will override the path to sendmail if the
# user has specified one via the environment variable PHP_SENDMAIL_PATH.
set -euo pipefail
IFS=$'\n\t'

if [[ ! -z "${PHP_SENDMAIL_PATH+x}" ]]; then
    echo "Configuring sendmail path"
    phpenmod mailpath
else
    phpdismod mailpath
fi;

