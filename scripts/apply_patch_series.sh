#!/bin/bash
#
# apply_patch_series: apply a patch series to a directory
#

. `dirname $0`/libptxdist.sh

usage() {
	echo
	[ -n "$1" ] && echo -e "${PREFIX} error: $1\n"
	echo "usage: $0 <args>"
	echo
	echo " Arguments:"
	echo
	echo "  -s <file>      series file to use"
	echo "  -d <directory> target directory"
	exit 1
}

#
# Option parser
#
while [ $# -gt 0 ]; do
	case "$1" in
		-s) SERIES=`ptxd_abspath $2`;	shift 2 ;;
		-d) TARGET=`ptxd_abspath $2`;	shift 2 ;;
		*) usage "unknown option $1" ;;
	esac
done

#
# Sanity checks
#
[ -z "$SERIES" ]       && usage "${PREFIX} error: specify a series file with -s"
[ -z "$TARGET" ]       && usage "${PREFIX} error: specify a target directory with -d"

pushd "$TARGET" || exit 1

cat "$SERIES" | egrep -v "^[[:space:]]*#" | egrep -v "^[[:space:]]*$" | while read patchfile unused; do
	abspatch=`dirname $SERIES`/"$patchfile"
	if [ ! -e "$abspatch" ]; then
		echo "patch $abspatch does not exist. aborting"
		exit 1
	fi
	case `basename $abspatch` in
	*.gz)
		CAT=zcat
		;;
	*.bz2)
		CAT=bzcat
		;;
	*)
		CAT=cat
		;;
	esac;
	echo "applying $abspatch"
	$CAT "$abspatch" | patch -p1 || exit 1
done

if [ "$?" != 0 ]; then
	exit 1;
fi

popd

