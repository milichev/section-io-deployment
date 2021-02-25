#FROM node:14.16-alpine
FROM ubuntu:20.04

# for ubuntu
RUN apt-get update && \
    apt-get -y install curl tar unzip git openssh-client && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash && \
    apt-get -y install nodejs && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt update && \
    apt -y upgrade && \
    apt -y install yarn

# for alpine
# sectionctl requires a linker from libc6-compat
#RUN apk add --no-cache libc6-compat curl tar unzip bash git openssh

ENV SECTIONCTL_VERSION="v1.7.0"
RUN curl -L https://github.com/section/sectionctl/releases/download/$SECTIONCTL_VERSION/sectionctl-$SECTIONCTL_VERSION-linux-amd64.tar.gz -o /tmp/sectionctl.tar.gz && \
    cd /tmp && \
    tar zxvf sectionctl.tar.gz && \
    mv sectionctl /usr/local/bin/ && \
    chmod +x /usr/local/bin/sectionctl && \
    rm -rf LICENSE README.md sectionctl.tar.gz

#RUN adduser -D -u 1000 non-privileged \
RUN mkdir /git && \
    chown -R 1000:1000 /git && \
    chown -R 1000:1000 /tmp

USER 1000

VOLUME /git
WORKDIR /git

# for testing purposes, we mount the /git directory to the host current dir.
# in real life, here we have a build pipeline performed by Drone CI.
