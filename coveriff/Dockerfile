FROM python:3-alpine

RUN apk add --update --no-cache git
RUN pip install diff_cover

COPY coveriff.sh /usr/local/bin/coveriff.sh

WORKDIR /workspace

ENTRYPOINT ["/usr/local/bin/coveriff.sh"]
