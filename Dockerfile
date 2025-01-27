FROM ubuntu:24.04

ENV USER=root
ENV PASSWORD=password1
ENV DEBIAN_FRONTEND=noninteractive 
ENV DEBCONF_NONINTERACTIVE_SEEN=true

RUN apt-get update && apt-get install -y \
  abiword \
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
  tightvncserver \
  virtualgl \
  turbovnc \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
  && apt install -y ./google-chrome-stable_current_amd64.deb \
  && rm google-chrome-stable_current_amd64.deb

RUN mkdir -p ~/.vnc ~/.dosbox && \
  echo $PASSWORD | vncpasswd -f > ~/.vnc/passwd && \
  chmod 0600 ~/.vnc/passwd && \
  echo "set border 1" > ~/.ratpoisonrc && \
  echo "exec google-chrome --no-sandbox" >> ~/.ratpoisonrc

RUN openssl req -x509 -nodes -newkey rsa:2048 -keyout ~/novnc.pem -out ~/novnc.pem -days 3650 -subj "/C=US/ST=NY/L=NY/O=NY/OU=NY/CN=NY/emailAddress=email@example.com"

EXPOSE 80

CMD /opt/TurboVNC/bin/vncserver && websockify -D --web=/usr/share/novnc/ --cert=~/novnc.pem 80 localhost:5901 && tail -f /dev/null
