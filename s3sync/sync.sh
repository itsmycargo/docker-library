#!/bin/sh

set -eu

: ${SOURCE}
: ${TARGET}
: ${INTERVAL:=60}

verify() {
  echo "Verifying Source Bucket..."
  if ! aws s3 ls "${SOURCE}"; then
    exit 1
  fi
}

sync() {
  echo "$(date) - Syncing..."
  aws s3 sync --delete "${SOURCE}" "${TARGET}"
}

echo "   Source Bucket: ${SOURCE}"
echo "Target Directory: ${TARGET}"
echo "        Interval: ${INTERVAL}"
echo ""

mkdir -p "${TARGET}"

verify

while true; do
  sync

  sleep "${INTERVAL}"
done
