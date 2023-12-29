#!/bin/bash

while [[ "$#" -gt 0 ]]; do
  case $1 in
    -f|--env-file) envfile="$2"; shift ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

export $(cat $envfile | xargs)

echo "FTPE_URL_API is: $FTPE_URL_API"
echo "ALERTS_TOPIC is: $ALERTS_TOPIC"

flutter run \
  -d $DEVICE \
  --dart-define=FTPE_URL_API=$FTPE_URL_API \
  --dart-define=ALERTS_TOPIC=$ALERTS_TOPIC