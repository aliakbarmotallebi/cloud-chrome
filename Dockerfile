FROM ubuntu:22.04

ENV VNC_PASSWORD="" \
    DEBIAN_FRONTEND="noninteractive" \
    LC_ALL="C.UTF-8" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8"

RUN apt-get update && apt-get install -y \
    wget \
    gnupg2 \
    lsb-release \
    ca-certificates && \
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome-remote-desktop/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update

RUN apt-get install -y \
    google-chrome-stable \
    chrome-remote-desktop \
    xrdp \
    pulseaudio \
    supervisor \
    x11vnc \
    fluxbox \
    xfce4 \
    fonts-takao \
    mc \
    dbus \
    dbus-x11 && \
    apt-get clean && \
    rm -rf /var/cache/* /var/log/apt/* /var/lib/apt/lists/*

RUN addgroup chrome-remote-desktop && \
    useradd -m -G chrome-remote-desktop,pulse-access -p chrome chrome && \
    echo "chrome:chrome" | chpasswd && \
    mkdir -p /home/chrome/.config/chrome-remote-desktop && \
    mkdir -p /home/chrome/.fluxbox && \
    chown -R chrome:chrome /home/chrome/.config /home/chrome/.fluxbox

RUN echo 'session.screen0.toolbar.visible: false\n\
session.screen0.fullMaximization: true\n\
session.screen0.maxDisableResize: true\n\
session.screen0.maxDisableMove: true\n\
session.screen0.defaultDeco: NONE\n' > /home/chrome/.fluxbox/init && \
    chown chrome:chrome /home/chrome/.fluxbox/init

ADD conf/ / 

VOLUME ["/home/chrome"]

EXPOSE 5900 3389

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]
