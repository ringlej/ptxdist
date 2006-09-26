#!/bin/sh
#
# scripts/make_image_tgz.sh: create tar.gz image of root filesystem
#
# $1: root filesystem to be packaged
# $2: permissions file
#

PROMPT="make_image_tgz"

scriptdir=`dirname $0`
rootdir=$1
here=`pwd`

. ${scriptdir}/libptxdist.sh
. ${scriptdir}/ptxdist_version.sh

# sanity checks
[ -d "$1" ] || ptxd_exit "first argument has to be a directory" 1
[ -f "$2" ] || ptxd_exit "second argument has to be a dependency list" 1

echo
echo "${PROMPT}: packing tgz archive..."
cd ${rootdir}; (awk -F: "${DOPERMISSIONS}" ${here}/$2 && echo "tar -zcvf ${here}/root.tgz . ") | fakeroot --
echo "${PROMPT}: done."
echo

