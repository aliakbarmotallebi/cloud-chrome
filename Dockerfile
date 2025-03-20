# استفاده از Ubuntu به عنوان پایه
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    wget \
    x11vnc \
    xvfb \
    xfce4 \
    xfce4-terminal \
    supervisor \
    google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p ~/.vnc && \
    x11vnc -storepasswd mypassword ~/.vnc/passwd

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 5900

CMD ["/start.sh"]
