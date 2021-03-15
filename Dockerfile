FROM debian:stable as builder

# fahclient version
ARG CLIENT_MAJOR_VERSION=7.6
ARG CLIENT_MINOR_VERION=21

USER root
RUN apt update && \
    apt install -y curl bzip2 debconf-utils

# Install folding@home fahclient
WORKDIR /root
RUN curl -O https://download.foldingathome.org/releases/beta/release/fahclient/debian-stable-arm64/v${CLIENT_MAJOR_VERSION}/fahclient_${CLIENT_MAJOR_VERSION}.${CLIENT_MINOR_VERION}_arm64.deb
RUN dpkg -i --force-depends fahclient_${CLIENT_MAJOR_VERSION}.${CLIENT_MINOR_VERION}_arm64.deb

# Copy init config file
COPY init.sh /root/init.sh
RUN chmod u+x /root/init.sh

#############################################
# Multi-stage build to trim down image size #
#############################################
FROM debian:stable-slim
LABEL maintainer="beastob.mark1@gmail.com"

# Default configuration parameters for folding client
ENV FOLD_ANON=true \
    FOLD_USER='' \
    FOLD_PASSKEY='' \
    FOLD_TEAM=0 \
    FOLD_POWER=full \
    FOLD_ALLOW_IP=''

RUN apt update

WORKDIR /
COPY --from=builder /usr/bin/FAH* /usr/bin/
COPY --from=builder /etc/init.d/FAHClient /etc/init.d/FAHClient
COPY --from=builder /root/init.sh /root/init.sh
COPY --from=builder /etc/fahclient /etc/fahclient

CMD /root/init.sh

EXPOSE 7396
