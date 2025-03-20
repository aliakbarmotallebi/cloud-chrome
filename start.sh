#!/bin/bash

Xvfb :99 -screen 0 1920x1080x24 &

sleep 2

fluxbox &

sleep 2

x11vnc -display :99 -forever -usepw -shared &

sleep 2

DISPLAY=:99 google-chrome-stable --no-sandbox --disable-dev-shm-usage --disable-gpu --kiosk "https://www.google.com" &
