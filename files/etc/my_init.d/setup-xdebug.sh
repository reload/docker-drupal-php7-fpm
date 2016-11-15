#!/usr/bin/env bash
set -euo pipefail

echo "Start watching for profiling files..."
exec /etc/scripts/xdebug/watch.sh &
