#!/bin/sh

set -eux

: "${CHANGE_TARGET:=origin/master}"
: "${REPORT:=html}"

case "${REPORT}" in
  json )
    REPORT_ARG="--json-report report.json"
    ;;
  html )
    REPORT_ARG="--html-report report.html"
    ;;
esac

diff-cover --compare-branch=${CHANGE_TARGET} $REPORT_ARG "$@"
