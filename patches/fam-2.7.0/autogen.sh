#!/bin/sh

# configure must be writable or autom4te will fail
chmod +w configure

exec "$(dirname $0)/../autogen.sh"
