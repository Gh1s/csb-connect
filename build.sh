#!/bin/bash

while [[ "$#" -gt 0 ]]; do
  case $1 in
    -f|--env-file) envfile="$2"; shift ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

export $(cat $envfile | xargs)
export BUILD_TYPE=${BUILD_TYPE:-apk}
export BUILD_CONFIG=${BUILD_CONFIG:-release}

echo "FTPE_URL_API is: $FTPE_URL_API"
echo "ALERTS_TOPIC is: $ALERTS_TOPIC"
echo "BUILD_TYPE is: $BUILD_TYPE"
echo "BUILD_CONFIG is: $BUILD_CONFIG"

flutter build $BUILD_TYPE \
  --dart-define=FTPE_URL_API=$FTPE_URL_API \
  --dart-define=ALERTS_TOPIC=$ALERTS_TOPIC \
  --$BUILD_CONFIG