FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    wget \
    x11vnc \
    xvfb \
    xfce4 \
    xfce4-terminal \
    supervisor \
    curl \
    gnupg \
    ca-certificates

RUN curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable

RUN mkdir -p ~/.vnc && \
    x11vnc -storepasswd mypassword ~/.vnc/passwd

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 5900

CMD ["/start.sh"]
