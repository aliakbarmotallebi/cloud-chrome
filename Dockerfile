FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:99

RUN apt-get update && apt-get install -y \
    wget \
    xvfb \
    x11vnc \
    chromium-browser \
    supervisor && \
    apt-get clean

RUN mkdir -p /root/.vnc && x11vnc -storepasswd "123456789" /root/.vnc/passwd

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 5900

CMD ["/usr/bin/supervisord"]
