#!/bin/sh

# don't recreate configure. Otherwise we would need libgcrypt for
# AM_PATH_LIBGCRYPT
aclocal -I m4 &&
automake
