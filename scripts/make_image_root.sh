#!/bin/sh
#

. `dirname $0`/libptxdist.sh

usage() {
	echo 
	[ -n "$1" ] && echo -e "error: $1\n"
	echo "usage: $0 -r <rootdir>"
	echo "          [-i <ipkgdir>]"
	echo "          -p permissions"
	echo "          -e eraseblocksize"
	echo "          -o outputfile"
	echo "          [-j jffs2_extra_args]"
	echo
	echo "  -r <rootdir>          use this directory as a file source"
	echo "  -i <ipkgdir>          use this directory as a ipkg packet source"
	echo "  -p <permissions>      path to permissions file"
	echo "  -e <eraseblocksize>   erase block size of the flash chips"
	echo "  -j <jffs2_extra_args> additional arguments for mkfs.jffs2"
	echo "  -o <outputfile>       JFFS2 output file"
	echo "  -f <ipkgconfig>       use this ipkg config file"
	echo
	exit 0
}

nflag=0
vlevel=0
ROOTDIR=
IPKGDIR=
PERMISSIONS=
ERASEBLOCKSIZE=
JFFS2EXTRA=
OUTFILE=

#
# Option parser
#
while [ $# -gt 0 ]; do
	case "$1" in 
		--help) usage ;;
		-r) ROOTDIR=`ptxd_abspath $2`;     shift 2 ;;
		-i) IPKGDIR=`ptxd_abspath $2`;     shift 2 ;;
		-p) PERMISSIONS=`ptxd_abspath $2`; shift 2 ;;
		-e) ERASEBLOCKSIZE=$2;             shift 2 ;;
		-j) JFFS2EXTRA=$2;                 shift 2 ;;
		-o) OUTFILE=`ptxd_abspath $2`;     shift 2 ;;
		-f) IPKGCONF=$2;                   shift 2 ;;
		*)  usage "unknown option" ;;
  	esac
done

#
# Sanity checks
#
[ -z "$ROOTDIR" ]                      && usage "error: -r for your root dir"
[ ! -f "$PERMISSIONS" ]                && usage "error: specify the permissions file with -p"
[ -z "$ERASEBLOCKSIZE" ]               && usage "error: erase block size not specified"
[ ! -x "`which mkfs.jffs2`" ]          && usage "error: you need mkfs.jffs2 in your path"
[ ! -x "`which fakeroot`" ]            && usage "error: you need fakeroot in your path"
[ -n "$IPKGDIR" ] && \
[ ! -x "`which ipkg-cl`" ]             && usage "error: you need ipkg-cl in your path"
[ -z "$OUTFILE" ]                      && usage "error: specify an output file with -o"

echo

#
# If we use ipkg, prepare a directory for that. For using a plain root
# directory we just select this. 
#
if [ -n "$IPKGDIR" ]; then 
	echo "-i specified, extracting ipkg packets"
	WORKDIR=`mktemp -d /tmp/ptxdist.XXXXXX`
else
	echo "-i not specified, using files from plain root directory"
	WORKDIR=$ROOTDIR
fi

echo

echo "ROOTDIR=$ROOTDIR"
echo "IPKGDIR=$IPKGDIR"
echo "PERMISSIONS=$PERMISSIONS"
echo "ERASEBLOCKSIZE=$ERASEBLOCKSIZE"
echo "JFFS2EXTRA=$JFFS2EXTRA"
echo "OUTFILE=$OUTFILE"
echo "WORKDIR=$WORKDIR"

echo

cd $WORKDIR

if [ -n "$IPKGDIR" ]; then
	for archive in $IPKGDIR/*.ipk; do
		# "Cannot create node" messages are ok here (nodes are handled with the permissions file)
		#  do not confuse the user with these error messages
		ipkg-cl -f $IPKGCONF -force-depends -o `pwd` install $archive 2>&1 1>/dev/null | grep -v "Cannot create node"
	done
fi

echo `awk -F: "$DOPERMISSIONS" $PERMISSIONS && echo "mkfs.jffs2 -d $WORKDIR --eraseblock=$ERASEBLOCKSIZE $JFFS2EXTRA -o $OUTFILE" ` | fakeroot --

if [ -n "$IPKGDIR" ]; then
	echo "cleaning up workdir"
	rm -fr $WORKDIR
fi

echo "finished:"
ls -l $OUTFILE


