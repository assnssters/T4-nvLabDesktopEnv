FROM nvidia/cuda:12.9.0-cudnn-devel-ubuntu24.04
RUN mkdir -f /pkg
RUN apt update -y && apt upgrade -y && apt install -y \
    xrdp xrfb \
    tightvncserver xfce4 xfce4-terminal xfce4-goodies
WORKDIR /pkg
RUN useradd -ms /bin/bash user
RUN echo 'user ALL=(ALL:ALL) ALL' >> /etc/sudoers

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O chrome.deb && apt install -y "./chrome.deb" 
RUN wget https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/releases/download/v2.17.2/Heroic-2.17.2-linux-amd64.deb -O ./heroic.deb && apt install -y "./heroic.deb"
RUN
