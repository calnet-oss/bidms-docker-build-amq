#!/bin/sh

mkdir -p /root/src
cd /root/src

if [ ! -d activemq-broker-and-webconsole-overlay-war ]; then
  git clone https://github.com/calnet-oss/activemq-broker-and-webconsole-overlay-war.git
else
  (cd activemq-broker-and-webconsole-overlay-war; git pull)
fi
git_exit_code=$?
if [ $git_exit_code != 0 ]; then
  echo "Cloning or pulling activemq-broker-and-webconsole-overlay-war failed"
  exit $git_exit_code
fi

cd activemq-broker-and-webconsole-overlay-war \
  && ./gradlew war \
  && ./gradlew publish
