FROM alpine:3.11

RUN apk add --update --no-cache python tini

RUN apk add --update --no-cache --virtual .build-deps \
  py-pip \
  && pip install awscli \
  && apk del .build-deps

COPY sync.sh /usr/local/bin/sync.sh

ENTRYPOINT ["/sbin/tini", "-g", "--"]
CMD ["/usr/local/bin/sync.sh"]
