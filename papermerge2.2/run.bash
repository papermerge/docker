#!/bin/bash

case $1 in
  server)
  exec /usr/bin/supervisord
  ;;
esac
