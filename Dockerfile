FROM node:14.16-alpine

ENV SECTIONCTL_VERSION="v1.7.0"

# here we add sectionctl to the alpine image
# sectionctl requires a linker from libc6-compat
# please disregard git and openssh packages
RUN \
 apk add --no-cache libc6-compat curl tar unzip bash git openssh \
 && curl -L https://github.com/section/sectionctl/releases/download/$SECTIONCTL_VERSION/sectionctl-$SECTIONCTL_VERSION-linux-amd64.tar.gz -o /tmp/sectionctl.tar.gz \
 && cd /tmp \
 && tar zxvf sectionctl.tar.gz \
 && mv sectionctl /usr/local/bin/ \
 && chmod +x /usr/local/bin/sectionctl \
 && rm -rf LICENSE README.md sectionctl.tar.gz

#RUN adduser -D -u 1000 non-privileged \
RUN mkdir /git \
 && chown -R 1000:1000 /git \
 && chown -R 1000:1000 /tmp


USER 1000

VOLUME /git
WORKDIR /git

# for testing purposes, we mount the /git directory to the host current dir.
# in real life, here we have a build pipeline performed by Drone CI.
