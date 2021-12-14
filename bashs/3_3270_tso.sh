#!/bin/sh

if [ -z "$1" ]; then
        host='127.0.0.1'
else
        host="$1"
fi

xterm -geometry 90x30 -fa 'DejaVu Sans Mono' -fs 14  -e screen -S maincons -m c3270  -port 3270 $host &
sleep 2
x3270 -port 3270 $host &
sleep 2
x3270 -port 3270 $host &


