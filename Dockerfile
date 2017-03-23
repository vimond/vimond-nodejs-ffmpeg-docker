FROM phusion/passenger-customizable:0.9.20

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]
ENV TERM=linux

RUN apt-mark hold initscripts \
    && add-apt-repository -y ppa:jonathonf/ffmpeg-3 \
    && apt-get -qq update \
    && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y nodejs \
    && DEBIAN_FRONTEND=noninteractive /pd_build/python.sh \
    && DEBIAN_FRONTEND=noninteractive apt-get -qq -y install ffmpeg nginx findutils libcairo2-dev libjpeg8-dev libpango1.0-dev libgif-dev build-essential g++ \
    && DEBIAN_FRONTEND=noninteractive apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
