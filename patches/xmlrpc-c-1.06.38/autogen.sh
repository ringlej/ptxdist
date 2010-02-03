#!/bin/bash

set -e

aclocal $ACLOCAL_FLAGS

#
# use automake to install the file "missing"
#
# automake fill fail, because the package doesn't use automake.
# but this is the easiest way :)
#
automake \
	-f \
	--copy \
	--add-missing || true

libtoolize \
	--force \
	--copy

autoheader \
	--force \
	-Wall

autoconf \
	--force \
	-Wall
