#!/bin/bash

set -e

aclocal $ACLOCAL_FLAGS

am_macro_dir=m4 \
libtoolize \
	--force \
	--copy

autoreconf \
	--force \
	--install \
	--warnings=cross \
	--warnings=syntax \
	--warnings=obsolete \
	--warnings=unsupported

