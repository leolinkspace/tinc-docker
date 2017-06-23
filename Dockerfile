FROM alpine:latest

LABEL \
    maintainer="zer <zerpex@gmail.com>"

RUN set -eux && \

    # Install packages

    apk add --no-cache --no-progress --virtual BUILD_DEPS \
           build-base \
           ca-certificates \
           curl \
           libpcap-dev \
           linux-headers \
           lzo-dev \
           openssl-dev \
           zlib-dev && \

    apk add --no-cache --no-progress \
           libpcap \
           libcrypto1.0 \
           lzo \
           tinc \
           ipcalc \
           zlib
    
# Clean
RUN apk del --no-progress BUILD_DEPS && \
    rm -f -r /tmp/*

EXPOSE 655/tcp 655/udp

VOLUME /etc/tinc

ADD first_run.sh /first_run.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 22

CMD ["/run.sh"]
