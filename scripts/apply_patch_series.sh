#!/bin/bash
#
# apply_patch_series: either apply a patch series to a directory or
#                     apply all patches from a given directory
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
	echo "  -p <path>      apply all patches from <path>"
	echo "  -d <directory> target directory"
	exit 1
}

#
# Option parser
#
while getopts "hs:d:p:" OPT
do
    case "$OPT" in
        h)  usage
	    exit 1
            ;;
        s)  SERIES=`ptxd_abspath $OPTARG`;
            ;;
	d)  TARGET=`ptxd_abspath $OPTARG`;
	    ;;
	p)  PATCHESPATH=`ptxd_abspath $OPTARG`;
    esac
done
shift `expr $OPTIND - 1`

#
# Sanity checks
#
[ -z "$SERIES" ] && [ -z "$PATCHESPATH" ] && usage "${PREFIX} error: specify a series file with -s or a patches directory with -p"
[ -n "$SERIES" ] && [ -n "$PATCHESPATH" ] && usage "${PREFIX} error: the -s and -p option may not be used together"
[ -z "$TARGET" ]                          && usage "${PREFIX} error: specify a target directory with -d"

[ -n "$SERIES" ] && PATCHESPATH=`dirname $SERIES`

pushd "$TARGET" || exit 1

# if we have quilt use it to apply the patchstack
if [ -n "$(which quilt)" ]; then
	ln -s $PATCHESPATH patches

	if [ -f "$SERIES" ]; then
		ln -s "$SERIES" series
	else
		(cd $PATCHESPATH && find  -name "*.patch" -or -name "*.diff" -or -name "*.gz" -or -name "*.bz2") > series
	fi

	quilt push -a

	if [ "$?" != 0 ]; then
		exit 1;
	fi
	exit 0;
fi

{
	if [ -f "$SERIES" ]; then
		cat "$SERIES"
	else
		cd $PATCHESPATH && find  -name "*.patch" -or -name "*.diff" -or -name "*.gz" -or -name "*.bz2"
	fi
} |
egrep -v "^[[:space:]]*#" | egrep -v "^[[:space:]]*$" | while read patchfile patchpara; do
	abspatch="$PATCHESPATH"/"$patchfile"
	if [ ! -e "$abspatch" ]; then
		echo "patch $abspatch does not exist. aborting"
		exit 1
	fi
	case "$patchfile" in
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
	if [ $patchpara ] && [ `echo $patchpara | egrep '\-p[0-9]+'` ] ;then
		$CAT "$abspatch" | patch $patchpara || exit 1
	else
		$CAT "$abspatch" | patch -p1 || exit 1
	fi
done

if [ "$?" != 0 ]; then
	exit 1;
fi

popd

