FROM alpine:latest

RUN apk update && apk add --no-cache \
    iproute2 \
    iputils  \
    frr

COPY ./daemons /etc/frr/daemons
COPY ./start.sh .

CMD ["/bin/sh", "./start.sh"]
