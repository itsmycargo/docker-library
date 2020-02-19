FROM python:3-alpine

RUN apk add --update --no-cache git
RUN pip install \
  mkdocs \
  mkdocs-alabaster \
  mkdocs-git-revision-date-localized-plugin \
  mkdocs-minify-plugin \
  pygments

ENTRYPOINT ["/usr/local/bin/mkdocs"]
CMD ["-h"]
