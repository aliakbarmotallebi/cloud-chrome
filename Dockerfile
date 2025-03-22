FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV SCREEN_WIDTH=1920
ENV SCREEN_HEIGHT=1080
ENV SCREEN_DEPTH=24
ENV DISPLAY=:99

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
    wget \
    curl \
    gnupg \
    ca-certificates \
    libx11-xcb1 \
    libgdk-pixbuf2.0-0 \
    libxss1 \
    libnss3 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libasound2 \
    libappindicator3-1 \
    libxrandr2 \
    x11-utils \
    libgtk-3-0 \
    x11vnc \
    xvfb \
    dbus-x11 \
    mesa-utils \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    xdg-utils

RUN mkdir -p ~/.vnc && x11vnc -storepasswd 123456 ~/.vnc/passwd

RUN curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-chrome-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/google-chrome-keyring.gpg] https://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update && apt-get install -y google-chrome-stable

CMD Xvfb :99 -screen 0 ${SCREEN_WIDTH}x${SCREEN_HEIGHT}x${SCREEN_DEPTH} & \
    sleep 2 && \
    x11vnc -forever -usepw -display :99 & \
    google-chrome-stable \
        --no-sandbox \
        --user-data-dir=/root/chrome-profile \
        --disable-gpu \
        --disable-software-rasterizer \
        --start-maximized \
        --disable-infobars \
        --disable-session-crashed-bubble \
        --disable-extensions \
        --force-device-scale-factor=1 \
        --window-position=0,0 \
        --window-size=${SCREEN_WIDTH},${SCREEN_HEIGHT} \
        --disable-features=VizDisplayCompositor \
        --disable-hardware-media-key-handling \
        --disable-software-rasterizer \
        --disable-accelerated-video-decode \
        --disable-accelerated-2d-canvas \
        --no-first-run \
        --no-default-browser-check \
        --disable-logging
