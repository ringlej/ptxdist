#!/bin/sh
#
# automatic generate target install stage for ptx_dist
#

set -e

. `dirname $0`/libptxdist.sh

usage() {
	echo
	[ -n "$1" ] && echo -e "${PREFIX} error: $1\n"
	echo "usage: $0 <args>"
	echo
	echo " Arguments:"
	echo
	echo "	-b <path>			build directory" 
	echo "	-c				clean up the temp dir"
	echo "	-d <path>			root of install destination"
	echo "	-p <full filename or wildcard>	original filename pattern"
	echo "	-r <acces right>		access rights"
	echo "	-n <package name>		packagename"
	echo "	-o <owner>			owner of the file"
	echo "	-g <group>			group of the file"
	echo "	-s <path>			state dir"
	echo "	-h				show help"
	exit 1
}

while getopts "hcb:r:d:p:" OPT
do
    case "$OPT" in
        h)  usage
            exit 1
            ;;
	c)  CLEANUP=1;
	    ;;
	b)  BUILDDIR=`ptxd_abspath $OPTARG`;
	    ;;
	n)  PACKNAME=$OPTARG;
	    ;;
        p)  FILEPATTERN=`ptxd_abspath $OPTARG`;
            ;;
        r)  ACCRIGHT=$OPTARG;
            ;;
	s)  STATEDIR=$OPTARG;
	    ;;
	o)  FILEOWNER=$OPTARG;
	    ;;
	g)  FILEGROUP=$OPTARG;
	    ;;
        d)  DEST_ROOT=`ptxd_abspath $OPTARG`;
    esac
done
shift `expr $OPTIND - 1`

STAMP=auto_targetinstall.stamp
ORIG_DIR=`dirname "${FILEPATTERN}"`
ORIG_FILE=`basename "${FILEPATTERN}"`

cd ${BUILDDIR}

if [ -e $STAMP ];
	TMP_DEST=`cat auto_targetinstall.stamp`
else
	TMP_DEST=`mktemp -p ${BUILDDIR}`
	make install DEST_DIR=${TMP_DEST}
	echo ${TMP_DEST} > $STAMP
fi

ls ${TMP_DEST}/${FILEPATTER} >/dev/null
[ $? -ne 0 ] && exit 1

[ ! -d ${TMP_DEST} ] && exit 1

[ $CLEANUP == 1 ] && { rm -rf $TMP_DEST; return; }

cd ${TMP_DEST}

#find . -mindepth 1 -name "${ORIG_FILE}" \
#				-exec sh -c "echo {} | cut -c 2-" >> ${STATEDIR}/${PACKNAME}.perm \
#				-print
#				| cpio -pamd $DEST_ROOT
for i in `find . -mindepth 1 -name "${ORIG_FILE}"`; do
	echo $i | cpio -pamd $DEST_ROOT
	[ ! -d $i ] && echo "f:`echo $i | cut -c 2-`:${FILEOWNER}:${FILEGROUP}:${ACCRIGHT}" >> ${STATEDIR}/${PACKNAME}.perm
done
