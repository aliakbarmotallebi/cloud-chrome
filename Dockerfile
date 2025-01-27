FROM ubuntu:24.04

ENV PASSWORD=password1
ENV USER=root

RUN apt-get update && apt-get install -y \
  gnupg \
  apt-transport-https \
  wget \
  software-properties-common \
  ratpoison \
  novnc \
  websockify \
  libxv1 \
  libglu1-mesa \
  xauth \
  x11-utils \
  xorg \
  tightvncserver

RUN wget -q -O- https://packagecloud.io/dcommander/virtualgl/gpgkey | gpg --dearmor > /etc/apt/trusted.gpg.d/VirtualGL.gpg
RUN wget -q -O- https://packagecloud.io/dcommander/turbovnc/gpgkey | gpg --dearmor > /etc/apt/trusted.gpg.d/TurboVNC.gpg
RUN wget https://raw.githubusercontent.com/VirtualGL/repo/main/VirtualGL.list -O /etc/apt/sources.list.d/VirtualGL.list
RUN wget https://raw.githubusercontent.com/TurboVNC/repo/main/TurboVNC.list -O /etc/apt/sources.list.d/TurboVNC.list

RUN apt-get update && apt-get install -y \
  virtualgl \
  turbovnc \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
  && apt install -y ./google-chrome-stable_current_amd64.deb \
  && rm google-chrome-stable_current_amd64.deb

RUN mkdir -p ~/.vnc ~/.novnc && \
  echo $PASSWORD | vncpasswd -f > ~/.vnc/passwd && \
  chmod 0600 ~/.vnc/passwd

RUN openssl req -x509 -nodes -newkey rsa:2048 -keyout ~/.novnc/novnc.pem -out ~/.novnc/novnc.pem -days 3650 -subj "/C=US/ST=NY/L=NY/O=NY/OU=NY/CN=NY/emailAddress=email@example.com"

COPY .ratpoisonrc /root/.ratpoisonrc

RUN echo "exec chromium --no-sandbox" > ~/.novnc/novnc_startup.sh
RUN chmod +x ~/.novnc/novnc_startup.sh

EXPOSE 80

CMD x11vnc -display :0 -nopw -listen localhost -forever & \
    websockify -D --web=/usr/share/novnc/ --cert=~/.novnc/novnc.pem 80 localhost:5900 && \
    openbox & \
    tail -f /dev/null
