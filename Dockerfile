FROM alpine:3.18.4
RUN \
    wget -q http://more.musl.cc/x86_64-linux-musl/aarch64-linux-musl-cross.tgz      -O - | tar -xz --strip-components=1 -f - -C /usr && \
    wget -q http://more.musl.cc/x86_64-linux-musl/armv6-linux-musleabihf-cross.tgz  -O - | tar -xz --strip-components=1 -f - -C /usr && \
    wget -q http://more.musl.cc/x86_64-linux-musl/armv7l-linux-musleabihf-cross.tgz -O - | tar -xz --strip-components=1 -f - -C /usr && \
    wget -q http://more.musl.cc/x86_64-linux-musl/powerpc64le-linux-musl-cross.tgz  -O - | tar -xz --strip-components=1 -f - -C /usr && \
    wget -q http://more.musl.cc/x86_64-linux-musl/s390x-linux-musl-cross.tgz        -O - | tar -xz --strip-components=1 -f - -C /usr && \
    wget -q http://more.musl.cc/x86_64-linux-musl/i686-linux-musl-cross.tgz         -O - | tar -xz --strip-components=1 -f - -C /usr && \
    wget -q http://more.musl.cc/x86_64-linux-musl/x86_64-linux-musl-cross.tgz       -O - | tar -xz --strip-components=1 -f - -C /usr && \
    apk add --no-cache cmake make pkgconfig autoconf automake

RUN \
    for i in aarch64-linux-musl armv6-linux-musleabihf armv7l-linux-musleabihf powerpc64le-linux-musl s390x-linux-musl i686-linux-musl x86_64-linux-musl; do \
        ln -s "/usr/${i}" /; \
    done && \
    apk add --no-cache --arch=aarch64 --root=/aarch64-linux-musl      --initdb && \
    apk add --no-cache --arch=armhf   --root=/armv6-linux-musleabihf  --initdb && \
    apk add --no-cache --arch=armv7   --root=/armv7l-linux-musleabihf --initdb && \
    apk add --no-cache --arch=ppc64le --root=/powerpc64le-linux-musl  --initdb && \
    apk add --no-cache --arch=s390x   --root=/s390x-linux-musl        --initdb && \
    apk add --no-cache --arch=x86     --root=/i686-linux-musl         --initdb && \
    apk add --no-cache --arch=x86_64  --root=/x86_64-linux-musl       --initdb && \
    for i in aarch64-linux-musl armv6-linux-musleabihf armv7l-linux-musleabihf powerpc64le-linux-musl s390x-linux-musl i686-linux-musl x86_64-linux-musl; do \
        cp /etc/apk/repositories "/${i}/etc/apk"; \
    done && \
    apk add --no-cache --arch=aarch64 --root=/aarch64-linux-musl      --allow-untrusted alpine-keys && \
    apk add --no-cache --arch=armhf   --root=/armv6-linux-musleabihf  --allow-untrusted alpine-keys && \
    apk add --no-cache --arch=armv7   --root=/armv7l-linux-musleabihf --allow-untrusted alpine-keys && \
    apk add --no-cache --arch=ppc64le --root=/powerpc64le-linux-musl  --allow-untrusted alpine-keys && \
    apk add --no-cache --arch=s390x   --root=/s390x-linux-musl        --allow-untrusted alpine-keys && \
    apk add --no-cache --arch=x86     --root=/i686-linux-musl         --allow-untrusted alpine-keys && \
    apk add --no-cache --arch=x86_64  --root=/x86_64-linux-musl       --allow-untrusted alpine-keys

COPY setvars /usr/local/bin/
