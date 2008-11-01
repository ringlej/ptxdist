#!/bin/bash
#
# This script compiles all selected packages individually and
# makes clean after each package.
#
# This can be used to search for broken or missing dependencies
# and to compile all selected packages without stopping the whole
# process on broken packages
#
# Just call this script from a workspace dir (at least till it
# is integrated into ptxdist)
#

PTXDIST=${PTXDIST:-ptxdist}

packages=$(${PTXDIST} print PACKAGES | grep "PACKAGES is" | sed "s/PACKAGES is \"\(.*\)\"$/\1/")

for i in $packages; do
	# only build if logfile does not exist to be able to restart the script
	if [ ! -f logfile-$i ]; then
		echo $i > logfile;
		${PTXDIST} clean
		${PTXDIST} install $i
		mv logfile logfile-$i
	fi
done
