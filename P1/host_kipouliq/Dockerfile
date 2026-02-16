FROM alpine:latest

RUN apk update && apk add --no-cache \
    bash \
    iproute2 \
    iputils \
    busybox-extras

RUN ip addr add 10.10.1.10/24 dev eth0

ENV TERM=xterm

CMD ["/bin/sh"]
