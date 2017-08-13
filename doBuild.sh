#!/bin/sh

docker inspect bidms-build-amq > /dev/null
if [ $? != 0 ]; then
  echo "bidms-build-amq container not running"
  exit 1
fi

docker exec -t bidms-build-amq /root/doBuild.sh
