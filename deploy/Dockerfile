FROM alpine:3.14.0

RUN apk add --no-cache --update \
  aws-cli \
  ca-certificates \
  git \
  rsync \
  wget \
  zip

COPY --from=lachlanevenson/k8s-kubectl:v1.18.10 /usr/local/bin/kubectl /usr/local/bin/kubectl

ARG HELM_VERSION=3.4.0
RUN wget -q "https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz" \
    && tar zx -f helm-v${HELM_VERSION}-linux-amd64.tar.gz linux-amd64/helm \
    && mv linux-amd64/helm /usr/bin/ \
    && rm helm-v${HELM_VERSION}-linux-amd64.tar.gz
