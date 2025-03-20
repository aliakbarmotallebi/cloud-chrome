#!/bin/bash

export XDG_RUNTIME_DIR="/tmp/runtime-$USER"
mkdir -p $XDG_RUNTIME_DIR

dbus-launch --exit-with-session fluxbox &
x11vnc -display :99 -forever -usepw &
xvfb-run --server-args="-screen 0 ${SCREEN_WIDTH}x${SCREEN_HEIGHT}x${SCREEN_DEPTH}" google-chrome-stable --no-sandbox --disable-gpu --remote-debugging-port=9222 --disable-software-rasterizer --headless --disable-dev-shm-usage
