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


packages=$(ptxdist print PACKAGES | grep "PACKAGES is" | sed "s/PACKAGES is \"\(.*\)\"$/\1/")

for i in $packages; do
	echo $i > logfile;
	ptxdist clean
	ptxdist install $i
	mv logfile logfile-$i
done
