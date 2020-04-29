#!/bin/sh

set -eux

: "${CHANGE_TARGET:=origin/master}"

diff-cover --compare-branch=${CHANGE_TARGET} --html-report report.html "$@"
