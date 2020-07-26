FROM debian:stretch-slim

RUN apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends \
    curl \
  && rm -rf /var/lib/apt/lists/*

ARG IMPOSM_VERSION=0.10.0
RUN curl -skLo /tmp/imposm-${IMPOSM_VERSION}-linux-x86-64.tar.gz \
    https://github.com/omniscale/imposm3/releases/download/v${IMPOSM_VERSION}/imposm-${IMPOSM_VERSION}-linux-x86-64.tar.gz \
  && tar -zxf /tmp/imposm-${IMPOSM_VERSION}-linux-x86-64.tar.gz -C /usr/local \
  && mv /usr/local/imposm-0.10.0-linux-x86-64 /usr/local/imposm \
  && rm /tmp/imposm-${IMPOSM_VERSION}-linux-x86-64.tar.gz

ENTRYPOINT ["/usr/local/imposm/imposm3"]
