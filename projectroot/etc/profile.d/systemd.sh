#!/bin/sh

if [ -r /etc/locale.conf ]; then
  . /etc/locale.conf
  export LANG
fi

# make sure TERM is always defined
if [ -z "${TERM}" ]; then
  export TERM="linux"
fi
