#! /bin/sh

set -e

autoreconf \
	--force \
	--install \
	--warnings=cross \
	--warnings=syntax \
	--warnings=obsolete \
	--warnings=unsupported
