#!/bin/sh
#
# $1: topelevel Kconfig file
#

KCONFIG_TOPLEVEL=$1

if ! [ -f "$KCONFIG_TOPLEVEL" ]; then
	echo "error: toplevel Kconfig file $KCONFIG_TOPLEVEL does not exist."
	exit 1
fi



