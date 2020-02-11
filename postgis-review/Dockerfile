FROM mdillon/postgis:11-alpine

RUN apk add --no-cache --update jq py2-pip
# Install aws-cli
RUN pip install awscli --upgrade

COPY reset.sh /usr/local/bin/
