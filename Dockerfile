FROM resin/armv7hf-systemd:latest

ENV INITSYSTEM on

RUN apt-get update \
 && apt-get install -y \
    git \
    curl \
    build-essential \
    autoconf \
    automake \
    cmake \
    libtool \
    libdaemon-dev \
    libasound2-dev \
    libpopt-dev \
    libconfig-dev \
    avahi-daemon \
    libavahi-client-dev \
    libpolarssl-dev \
    libsoxr-dev \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

RUN cd /root \
 && git clone https://github.com/mikebrady/shairport-sync.git \
 && cd /root/shairport-sync \
 && git checkout -q tags/2.9.2 \
 && autoreconf -i -f \
 && ./configure --with-alsa --with-pipe --with-avahi --with-ssl=polarssl --with-soxr --with-metadata --with-systemd \
 && make \
 && make install


ENV AIRPLAY_NAME Docker
ENV OUTPUT_NAME Speaker
ENV DISPLAY :0
ENV DBUS_SESSION_BUS_ADDRESS dbus:

COPY start.sh /start

ENTRYPOINT [ "/start" ]
