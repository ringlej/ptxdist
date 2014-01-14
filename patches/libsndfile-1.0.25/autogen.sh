#!/bin/bash

set -e

aclocal $ACLOCAL_FLAGS

libtoolize \
	--force \
	--copy

autoreconf \
	--include=M4 \
	--force \
	--install \
	--warnings=cross \
	--warnings=syntax \
	--warnings=obsolete \
	--warnings=unsupported

