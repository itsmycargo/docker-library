#!/bin/sh

set -euo pipefail

: ${SOURCE}
: ${TARGET}
: ${INTERVAL:=60}

sync() {
  if aws s3 ls "${SOURCE}" >/dev/null 2>&1; then
    aws s3 sync "${SOURCE}" "${TARGET}"
  else
    echo "Source ${SOURCE} does not exist!"
    exit 1
  fi
}

echo "   Source Bucket: ${SOURCE}"
echo "Target Directory: ${TARGET}"
echo "        Interval: ${INTERVAL}"
echo ""

mkdir -p "${TARGET}"

while true; do
  sync
  sleep "${INTERVAL}"
done
