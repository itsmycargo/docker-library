FROM ruby:2.7-alpine

RUN apk add --update --no-cache git
RUN gem install danger -v8.0.0

ENTRYPOINT ["/usr/local/bundle/bin/danger"]
