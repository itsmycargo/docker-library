FROM ruby:3.0.0

RUN apt-get update && apt-get install -y \
      apt-transport-https \
      automake \
      build-essential \
      cmake \
      git \
      graphviz \
      libgeos-dev \
      libpq-dev \
      libssl-dev \
      locales \
      tzdata \
      wkhtmltopdf

RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales \
      && locale-gen C.UTF-8 \
      && /usr/sbin/update-locale LANG=C.UTF-8

RUN curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - \
      && echo "deb https://deb.nodesource.com/node_12.x stretch main" | tee /etc/apt/sources.list.d/nodesource.list \
      && apt-get update && apt-get install -y nodejs \
      && npm install -g 'mjml@4.3.1'
