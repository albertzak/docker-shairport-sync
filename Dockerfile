FROM resin/rpi-raspbian:wheezy-20160309

RUN apt-get update \
 && apt-get install -y \
    build-essential \
    autoconf \
    automake \
    cmake \
    git \
    libtool \
    libdaemon-dev \
    libasound2-dev \
    libpopt-dev \
    libconfig-dev \
    avahi-daemon \
    libavahi-client-dev \
    libpolarssl-dev \
 && rm -rf /var/lib/apt/lists/*

RUN cd /root \
 && git clone git://git.code.sf.net/p/soxr/code libsoxr \
 && cd libsoxr \
 && ./go \
 && cd Release \
 && make install \
 && ldconfig -v

RUN cd /root \
 && git clone https://github.com/mikebrady/shairport-sync.git \
 && cd /root/shairport-sync \
 && git checkout -q tags/2.9.2 \
 && autoreconf -i -f \
 && ./configure --with-alsa --with-pipe --with-avahi --with-ssl=polarssl --with-soxr --with-metadata \
 && make \
 && make install

COPY start.sh /start

ENV AIRPLAY_NAME Docker

ENTRYPOINT [ "/start" ]
