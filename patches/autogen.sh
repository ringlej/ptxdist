#!/bin/bash

aclocal $ACLOCAL_FLAGS

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

