#!/bin/sh

cd /root/src/activemq-broker-and-webconsole-overlay-war \
  && mvn install \
  && cd with-jstl-overlay \
  && mvn package
