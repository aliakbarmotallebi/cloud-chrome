#!/bin/bash

rm -f /tmp/.X99-lock

Xvfb :99 -screen 0 ${SCREEN_WIDTH}x${SCREEN_HEIGHT}x${SCREEN_DEPTH} &

x11vnc -display :99 -forever -nopw -bg &

sleep 3

exec google-chrome --no-sandbox --disable-dev-shm-usage --disable-infobars --kiosk https://www.google.com
