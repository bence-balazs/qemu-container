FROM alpine:3.18.0

ENV CPU_CORE="4" \
    MEMORY="6144" \
    ISO=""

RUN apk add qemu-system-x86_64 qemu-img ovmf \
    && rm -rf /var/cache/apk/*

# Copy docker-entrypoint.sh
COPY docker-entrypoint.sh /
# Copy functions.sh
COPY functions.sh /opt

# VNC specific
COPY easy-novnc /
ENV NOVNC_ADDR=:5901 \
    NOVNC_BASIC_UI=true

ENTRYPOINT [ "/docker-entrypoint.sh" ]

EXPOSE 5901
