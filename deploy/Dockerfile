FROM python:3.9.0-alpine

RUN pip install awscli --upgrade

RUN wget -q -O /usr/local/bin/kubectl \
  https://storage.googleapis.com/kubernetes-release/release/`wget -q -O - https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl \
  && chmod a+x /usr/local/bin/kubectl

RUN apk add --no-cache --update ca-certificates git zip

ARG HELM_VERSION=3.3.1

RUN wget -q "https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz" \
    && tar zx -f helm-v${HELM_VERSION}-linux-amd64.tar.gz linux-amd64/helm \
    && mv linux-amd64/helm /usr/bin/ \
    && rm helm-v${HELM_VERSION}-linux-amd64.tar.gz

RUN apk add --no-cache --virtual .fetchdeps bash curl git \
    && helm plugin install https://github.com/hypnoglow/helm-s3.git \
    && helm plugin install https://github.com/sstarcher/helm-release \
    && apk del .fetchdeps
