#!/bin/sh
exec xterm -ls -sb -bg black -fg white -geometry 90x50 -e /usr/bin/c3270 172.17.7.10 -port 3270 &
