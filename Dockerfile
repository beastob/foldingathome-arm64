FROM debian:stable

# fahclient version
ARG CLIENT_MAJOR_VERSION=7.6
ARG CLIENT_MINOR_VER=20

# Configuration parameters for folding client
ENV FOLD_ANON=true \
    FOLD_USER=Anonymous \
    FOLD_TEAM=0 \
    FOLD_POWER=FULL \
    FOLD_ALLOW_IP=''

USER root
RUN apt update && \
    apt install -y curl dialog bzip2

# Install folding@home fahclient
WORKDIR /root
RUN curl -O https://download.foldingathome.org/releases/beta/release/fahclient/debian-stable-arm64/v7.6/fahclient_${CLIENT_MAJOR_VERSION}.${CLIENT_MINOR_VER}_arm64.deb
RUN echo 'fahclient fahclient/user string ${FOLD_USER}\n\
fahclient fahclient/team string ${FOLD_TEAM}\n\
fahclient fahclient/passkey string changeit\n\
fahclient fahclient/power string ${FOLD_POWER}\n'\
>> debconf
RUN debconf-set-selections < debconf && \
    echo yes | dpkg -i --force-depends fahclient_${CLIENT_MAJOR_VERSION}.${CLIENT_MINOR_VER}_arm64.deb

# Copy init config file
COPY init.sh /root/init.sh
RUN chmod u+x /root/init.sh

CMD /root/init.sh

EXPOSE 7396
