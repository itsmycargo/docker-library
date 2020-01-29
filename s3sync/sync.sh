#!/bin/sh

set -eu

: ${SOURCE}
: ${TARGET}
: ${INTERVAL:=60}

verify() {
  echo "Verifying Source Bucket..."
  if aws s3 ls "${SOURCE}"; then
    echo "Done."
  else
    echo "Source ${SOURCE} does not exist!"
    exit 1
  fi
}

sync() {
  aws s3 sync "${SOURCE}" "${TARGET}"
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
