FROM ubuntu:22.04

ENV DISPLAY=:99
ENV SCREEN_WIDTH=1920
ENV SCREEN_HEIGHT=1080
ENV SCREEN_DEPTH=24

RUN apt-get update

RUN apt-get install -y \
    wget \
    x11vnc \
    xvfb \
    fluxbox \
    supervisor \
    curl \
    gnupg2 \
    dbus-x11

RUN if [ -d /var/lib/apt/lists ]; then rm -rf /var/lib/apt/lists/*; fi

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable

RUN if [ -d /var/lib/apt/lists ]; then rm -rf /var/lib/apt/lists/*; fi

COPY start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
