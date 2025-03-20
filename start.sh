#!/bin/bash

Xvfb :99 -screen 0 1920x1080x24 &

startxfce4 &

x11vnc -display :99 -forever -usepw -shared &

DISPLAY=:99 google-chrome-stable --no-sandbox --kiosk "https://www.google.com"
