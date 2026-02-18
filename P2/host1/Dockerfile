FROM alpine:latest

RUN apk update && apk add --no-cache \
    bash \
    iproute2 \
    iputils

ENV TERM=xterm

CMD ["/bin/sh"]
