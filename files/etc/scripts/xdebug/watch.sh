#!/bin/sh

#
# Script options (exit script on command fail).
#
set -e

echo "[Starting inotifywait...]"
inotifywait -m -r /var/xdebug/internal -e close_write | while read -r path action file;
do
    echo "$path $action $file"
    if [ "$path" = "/var/xdebug/internal/profiler/" ] ; then
        echo "moved to /var/xdebug/external/profiler/"
        mv $path$file /var/xdebug/external/profiler/$file
    else
        echo "moved to /var/xdebug/external/trace/"
        mv $path$file /var/xdebug/external/trace/$file
    fi
done
