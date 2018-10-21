#! /bin/sh

set -e

echo "EXTRA_DIST =" > gtk-doc.make
echo "CLEANFILES =" >> gtk-doc.make

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

