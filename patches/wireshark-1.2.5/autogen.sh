#!/bin/sh

ACLOCAL_FLAGS="-Iaclocal-fallback"
export ACLOCAL_FLAGS

`dirname $0`/autogen-generic.sh

