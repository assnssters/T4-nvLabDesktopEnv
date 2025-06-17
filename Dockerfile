FROM nvidia/cuda:12.9.0-base-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
COPY ./start.sh /usr/local/bin/start.sh
RUN mkdir -p /pkg
RUN apt update -y && apt upgrade -y
RUN apt install -y xrdp xvfb \
    tightvncserver xfce4 xfce4-terminal xfce4-goodies \
    thunar xfce4-taskmanager p7zip-full p7zip-rar unzip sudo wget curl
WORKDIR /pkg
RUN useradd -ms /bin/bash user
RUN echo 'user ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers
RUN echo "123456" | passwd user --stdin

RUN sudo cp /etc/xrdp/startwm.sh /etc/xrdp/startwm.sh.bak
RUN echo -e '#!/bin/sh\n\n# Start XFCE4 session\nif [ -d /etc/xdg/xfce4 ]; then\n    startxfce4\nfi\n\ntest -x /etc/X11/Xsession && exec /etc/X11/Xsession\nexec /bin/sh /etc/X11/Xsession' > /etc/xrdp/startwm.sh && \
    chmod +x /etc/xrdp/startwm.sh
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O chrome.deb && apt install -y "./chrome.deb" 
RUN wget https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/releases/download/v2.17.2/Heroic-2.17.2-linux-amd64.deb -O ./heroic.deb && apt install -y "./heroic.deb"
RUN wget https://github.com/LizardByte/Sunshine/releases/download/v2025.615.34501/sunshine-debian-bookworm-amd64.deb -O sunshine.deb && apt install -y "./sunshine.deb"
USER user
WORKDIR /home/user
ENV DISPLAY=:0
EXPOSE 47989/tcp
EXPOSE 47984/tcp
EXPOSE 48010/udp
EXPOSE 47998/udp
EXPOSE 47999/udp
EXPOSE 47800/udp
EXPOSE 3389
EXPOSE 5910
CMD ["/usr/local/bin/start.sh"]
