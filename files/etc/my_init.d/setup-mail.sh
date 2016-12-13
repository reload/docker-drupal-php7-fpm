#!/usr/bin/env bash
# Ensure Blackfire is only enabled if we have the necessary configuration.
set -euo pipefail
IFS=$'\n\t'

if [[ ! -z "${PHP_SENDMAIL_PATH+x}" ]]; then
    echo "Configuring sendmail path"
    phpenmod mailpath
else
    phpdismod mailpath
fi;

