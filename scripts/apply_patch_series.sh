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

do_quilt() {
	# If there is a file called "series" we can't use quilt....

	if test -e series; then
		return 1
	fi

	if test -e patches; then
		export QUILT_PATCHES=_ptx_patches
		echo
		echo "I'm using \"_ptx_patches\" for quilt, not \"patches\""
		echo "(This is just a warning)"
		echo
	else
		export QUILT_PATCHES=patches
	fi

	ln -s "${PATCHESPATH}" ${QUILT_PATCHES}

	if [ -f "${SERIES}" ]; then
		ln -s "${SERIES}" series
	else
		(cd $PATCHESPATH && find  -name "*.patch" -or -name "*.diff" -or -name "*.gz" -or -name "*.bz2") > series
	fi

	quilt push -a
	if [ "$?" != 0 ]; then
		exit 1;
	fi

	exit 0;
}


do_classic() {
	{
		if [ -f "$SERIES" ]; then
			cat "$SERIES"
		else
			cd $PATCHESPATH && find  -name "*.patch" -or -name "*.diff" -or -name "*.gz" -or -name "*.bz2"
		fi
	} | egrep -v "^[[:space:]]*#" | egrep -v "^[[:space:]]*$" | while read patchfile patchpara; do
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

		echo "applying $abspatch (without quilt)"
		if [ $patchpara ] && [ `echo $patchpara | egrep '\-p[0-9]+'` ] ;then
			$CAT "$abspatch" | patch $patchpara || exit 1
		else
			$CAT "$abspatch" | patch -p1 || exit 1
		fi
	done

	[ $? -gt 0 ] && exit 1
	if test -e patches; then
		ln -s "${PATCHESPATH}" _ptx_patches
	else
		ln -s "${PATCHESPATH}" patches
	fi
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

if [ -e "$SERIES" ] && [ ! -s "$SERIES" ]; then
	echo "series file is empty, we assume that no patches have to be applied"
	exit 0
fi

pushd "$TARGET" || exit 1

# if we have quilt use it to apply the patchstack
which quilt 1> /dev/null 2>&1
if [ $? -eq 0 ]; then
	do_quilt # if do_quilt returns try classic method
fi
do_classic


if [ "$?" != 0 ]; then
	exit 1;
fi

popd

