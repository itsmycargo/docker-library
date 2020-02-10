FROM ruby:2.5-alpine

RUN apk add --update --no-cache git
RUN gem install danger

ENTRYPOINT ["/usr/local/bundle/bin/danger"]
