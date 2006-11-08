#!/bin/bash
#
# automatic generate target install stage for ptx_dist
#

set -e

#. `dirname $0`/libptxdist.sh

usage() {
	echo
	[ -n "$1" ] && echo -e "${PREFIX} error: $1\n"
	echo "usage: $0 <args>"
	echo
	echo " Arguments:"
	echo
	echo "	-t <path>			top directory containing source package" 
	echo "	-c				clean up the temp dir"
	echo "	-d <path>			root of install destination"
	echo "	-p <full filename or wildcard>	original filename pattern"
	echo "	-r <acces right>		access rights"
	echo "	-n <package name>		packagename"
	echo "  -f <full package name>		full packagename"
	echo "	-o <owner>			owner of the file"
	echo "	-g <group>			group of the file"
	echo "	-s <path>			state dir"
	echo "	-i <strip program>		name of the program to strip the binary"
	echo "	-h				show help"
	exit 1
}

while getopts "hct:n:f:p:r:s:o:g:i:d:" flag 
do
    case "$flag" in
        h)  usage
            exit 1
            ;;
	c)  CLEANUP=1
	    ;;
	t)  TOPDIR=$OPTARG
	    ;;
	n)  PACKNAME=$OPTARG
	    ;;
	f)  FPACKNAME=$OPTARG
	    ;;
	p)  FILEPATTERN=$OPTARG
            ;;
        r)  ACCRIGHT=$OPTARG
            ;;
	s)  STATEDIR=$OPTARG
	    ;;
	o)  FILEOWNER=$OPTARG
	    ;;
	g)  FILEGROUP=$OPTARG
	    ;;
	i)  STRIPPER=$OPTARG
	    ;;
        d)  DEST_ROOT=$OPTARG
	    ;;
    esac
done

shift `expr $OPTIND - 1`

ORIG_DIR=`dirname "${FILEPATTERN}"`
ORIG_FILE=`basename "${FILEPATTERN}"`

BUILDDIR=${TOPDIR}/${FPACKNAME}
STAMP=${BUILDDIR}/auto_targetinstall.stamp

[ ! -d "${BUILDDIR}" ] && { echo "Source dir ${BUILDDIR} not found"; exit 1; }

[ ! -e "${DEST_ROOT}" ] && { echo "creating ${DEST_ROOT}"; mkdir -p ${DEST_ROOT}; }

cd ${BUILDDIR}
echo "DEBUG: builddir: ${BUILDDIR}, dest_root: ${DEST_ROOT}, fileowner: $FILEOWNER"

if [ -e $STAMP ];then
	TMP_DEST=`cat auto_targetinstall.stamp`
else
	TMP_DEST=`mktemp -d -p ${BUILDDIR}`
	echo "DEBUG: tmpdir : $TMP_DEST"
	make install DESTDIR=${TMP_DEST}
	echo ${TMP_DEST} > $STAMP
	ls ${TMP_DEST}/${FILEPATTERN} >/dev/null
	[ $? -ne 0 ] && { echo "no valid installation found in ${TMP_DEST}" >&2; exit 1; }
fi


[ ! -d ${TMP_DEST} ] && exit 1

[ ! -z $CLEANUP ] && { rm -rf $TMP_DEST; return; }

cd ${TMP_DEST}

[ -e ${TMP_DEST}/tmp.perms ] && rm ${TMP_DEST}/tmp.perms

for i in `find . -mindepth 1 -name "${ORIG_FILE}"`; do
	if [ ! -d $i ];then
		echo "f:`echo $i | cut -c 2-`:${FILEOWNER}:${FILEGROUP}:${ACCRIGHT}" >> ${TMP_DEST}/tmp.perms
	fi
	[ ! -z ${STATEDIR} ] && mv ${TMP_DEST}/tmp.perms ${STATEDIR}/${PACKNAME}.perms
	[ ! -z ${STRIPPER} ] && ${STRIPPER} -R .note -R .comment $i
	echo $i | cpio -pamd $DEST_ROOT
done
