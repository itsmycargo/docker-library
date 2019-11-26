FROM ruby:2.6

ENV LANG C.UTF-8
ENV TIME '\t%E real,\t%U user,\t%S sys,\t%K amem,\t%M mmem'

RUN apt-get update && apt-get install -y \
    cmake lcov time \
  && rm -rf /var/lib/apt/lists/*

RUN gem install undercover -v 0.3.2

COPY lcov2cobertura.py /usr/local/bin/lcov2cobertura
