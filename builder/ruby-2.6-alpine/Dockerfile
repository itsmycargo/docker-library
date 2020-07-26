FROM ruby:2.6-alpine

RUN apk add --no-cache \
  automake \
  build-base \
  cmake \
  geos-dev \
  git \
  graphviz \
  nodejs \
  npm \
  postgresql-dev \
  tzdata

# Install MJML
RUN npm install -g 'mjml@4.3.1'
