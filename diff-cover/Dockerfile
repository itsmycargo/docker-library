FROM python:3.9.6-alpine

RUN apk add --update --no-cache git
RUN pip install diff_cover && diff-cover --version

COPY diff-cover.sh /usr/local/bin/diff-cover.sh

WORKDIR /workspace

ENTRYPOINT ["/usr/local/bin/diff-cover.sh"]
