FROM ubuntu:22.04

COPY GRANULE_* /tmp/
COPY issue-230-workaround /usr/local/bin/
RUN apt-get update && \
    apt-get install -y wget unzip locales && \
    wget https://github.com/granule-project/granule/releases/download/v$(cat /tmp/GRANULE_VERSION)/granule-v$(cat /tmp/GRANULE_VERSION)-linux_x86_64.zip \
        -O /tmp/granule.zip && \
    locale-gen "en_US.UTF-8" && \
    update-locale LC_ALL="en_US.UTF-8" && \
    cd /tmp && \
    unzip granule.zip && \
    mv granule*/* /usr/local/bin &&\
    cd / && \
    apt-get remove -y wget unzip && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/granule*
ENV LC_ALL="en_US.UTF-8"
