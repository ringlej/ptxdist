#!/bin/sh

./autogen.sh --help


echo "Generating configuration files for $package, please wait...."

echo "  aclocal -I m4"
aclocal -I m4 || exit 1
echo "  libtoolize --automake --force"
libtoolize --automake --force || exit 1
echo "  autoheader"
autoheader || exit 1
echo "  automake --add-missing"
automake --add-missing || exit 1
echo "  autoconf"
autoconf || exit 1


