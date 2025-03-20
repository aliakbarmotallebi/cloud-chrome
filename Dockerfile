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
    ca-certificates \
    xrdp \
    pulseaudio \
    supervisor \
    x11vnc \
    fluxbox \
    xfce4 \
    fonts-takao \
    mc \
    dbus \
    dbus-x11 \
    gnome-session \
    gnome-shell \
    tightvncserver && \
    apt-get clean && \
    rm -rf /var/cache/* /var/log/apt/* /var/lib/apt/lists/*

RUN addgroup chrome-remote-desktop && \
    useradd -m -G chrome-remote-desktop,pulse-access -p chrome chrome && \
    echo "chrome:chrome" | chpasswd && \
    mkdir -p /home/chrome/.config/gnome-session && \
    chown -R chrome:chrome /home/chrome/.config/gnome-session

RUN echo "gnome-session" > /home/chrome/.xsession && \
    chown chrome:chrome /home/chrome/.xsession

ADD /supervisord.conf /

VOLUME ["/home/chrome"]

EXPOSE 5900 3389

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]
