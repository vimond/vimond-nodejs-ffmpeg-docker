FROM phusion/passenger-customizable:0.9.18

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

RUN export LANGUAGE=en_US.UTF-8 \
    && export LANG=en_US.UTF-8 \
	&& export LC_ALL=en_US.UTF-8 \
	&& locale-gen en_US.UTF-8 \
	&& DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

ENV TERM=linux TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV REFRESHED_AT 2015-09-30 10:40:00

RUN apt-mark hold initscripts \
    && add-apt-repository -y ppa:mc3man/trusty-media \
    && apt-get -qq update \
    && DEBIAN_FRONTEND=noninteractive apt-get -qq -y upgrade \
    && curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - \
    && DEBIAN_FRONTEND=noninteractive /pd_build/nodejs.sh \
    && DEBIAN_FRONTEND=noninteractive /pd_build/python.sh \
    && DEBIAN_FRONTEND=noninteractive apt-get -qq -y install ffmpeg nginx findutils libcairo2-dev libjpeg8-dev libpango1.0-dev libgif-dev build-essential g++ \
    && DEBIAN_FRONTEND=noninteractive apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*