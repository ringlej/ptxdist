#!/bin/bash

set -e

aclocal $ACLOCAL_FLAGS

libtoolize \
	--force \
	--copy

AUTOPOINT='intltoolize --automake --copy' \
autoreconf \
	--force \
	--install \
	--warnings=cross \
	--warnings=syntax \
	--warnings=obsolete \
	--warnings=unsupported

