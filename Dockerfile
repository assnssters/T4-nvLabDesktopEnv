FROM nvidia/cuda:12.9.0-cudnn-devel-ubuntu24.04
COPY ./start.sh /usr/local/bin/start.sh
RUN mkdir -f /pkg
RUN apt update -y && apt upgrade -y && apt install -y \
    xrdp xrfb \
    tightvncserver xfce4 xfce4-terminal xfce4-goodies

WORKDIR /pkg
RUN useradd -ms /bin/bash user
RUN echo 'user ALL=(ALL:ALL) ALL' >> /etc/sudoers
RUN echo "123456" | passwd user --stdin

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O chrome.deb && apt install -y "./chrome.deb" 
RUN wget https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/releases/download/v2.17.2/Heroic-2.17.2-linux-amd64.deb -O ./heroic.deb && apt install -y "./heroic.deb"
RUN wget https://github.com/LizardByte/Sunshine/releases/download/v2025.615.34501/sunshine-debian-bookworm-amd64.deb -O sunshine.deb && apt install -y "./sunshine.deb"

CMD ["/usr/local/bin/start.sh"]
