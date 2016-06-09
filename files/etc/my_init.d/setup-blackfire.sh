#!/usr/bin/env bash
# Ensure Blackfire is only enabled if we have the necessary configuration.
set -euo pipefail
IFS=$'\n\t'

if [[ ! -z "${BLACKFIRE_SOCKET+x}" ]]; then
    echo "Enabling blackfire"
    phpenmod blackfire
else
    phpdismod blackfire
fi;

