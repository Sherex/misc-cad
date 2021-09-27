FROM alpine:edge

RUN apk add openscad --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/

RUN mkdir /data
WORKDIR /data

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]