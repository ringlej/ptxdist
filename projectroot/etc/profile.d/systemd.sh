#!/bin/sh

if [ -r /etc/locale.conf ]; then
  . /etc/locale.conf
  export LANG
fi

# set 'r', otherwise less breaks UTF-8 chars without UTF-8 locale
export SYSTEMD_LESS="FrSXMK"

# make sure TERM is always defined
if [ -z "${TERM}" ]; then
  export TERM="linux"
fi
