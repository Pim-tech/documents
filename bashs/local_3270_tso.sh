#!/bin/sh

if [ -z "$1" ]; then
        host='127.0.0.1'
else
        host="$1"
fi

xterm -geometry 316x79 -e screen -S "hercules" -m /usr/bin/hercules -f /mnt/vgmass/zos110_images/CONF/ABCD_LINUX.CONF  &
sleep 3
xterm -geometry 86x30 -fa 'DejaVu Sans Mono' -fs 14  -e screen -S maincons -m c3270  -port 3270 $host &
sleep 2
x3270 -port 3270 $host &
sleep 2
x3270 -port 3270 $host &


