#!/bin/bash
#
# collect_sources.sh
# 
# b.buerger@pengutronix.de
# Fri Jul 16 19:23:52 CEST 2004

exit_release() {
cat << _EOF_
---------------------------------------------

Something went wrong. ../release.lck indicates,
that there was a PTXDist Directory 
>>$(cat ../release.lck)<< which was renamed 
during a make archive release cycle. 

_EOF_
exit;
}

my_error() {
cat << _EOF_
---------------------------------------------

Something went wrong. 
Please investigate. 

_EOF_
exit;
}

test -e ../release.lck && exit_release

if [ "$1" == "" ]; then {
cat << _EOF_
---------------------------------------------
                W A R N I N G
---------------------------------------------

Script: $0

This should be run from the main Make file.

# make archive

or 

# RELEASE="<RELEASE TAG>" make archive

---------------------------------------------
_EOF_

exit;

}
fi;

# -------------------------------------------
# Command line arguments:
# -------------------------------------------
# TOPDIR is the TOP of PTX Directory
TOPDIR=$1
# ARCH_PATH is where the archives will be created
ARCH_PATH=$TOPDIR/..
# ARCH_BASENAME is the basename of the archive,
# usually the name of the ptxdist-directory
ARCH_BASENAME=$2

cat << EOF
TOPDIR=$TOPDIR
ARCH_PATH=$ARCH_PATH
ARCH_BASENAME=$ARCH_BASENAME
EOF

# -------------------------------------------
# The Release TAG:
# -------------------------------------------

if [ "$RELEASE" == "" ]; then {
RELEASE="$ARCH_BASENAME"
cat << _EOF_
---------------------------------------------
                N O T I C E
---------------------------------------------

Using >>$RELEASE<< as RELEASE TAG

If you intend otherwise, hit Strg+C and 
use 

# RELEASE="<RELEASE TAG>" make archive

to build a specific archive.

(press key to continue)

---------------------------------------------

_EOF_
read
}
elif [ "$RELEASE" != "" ]; then {
cat << _EOF_
---------------------------------------------
                N O T I C E
---------------------------------------------

As you requested, the archive will be built
with a specific RELEASE TAG. 

TAG: $RELEASE

Hit Strg+C to abort...

(press key to continue)

---------------------------------------------

_EOF_
read

echo $ARCH_BASENAME > ../release.lck
cd $TOPDIR/..
mv -v $ARCH_BASENAME $RELEASE || my_error
ARCH_BASENAME=$RELEASE
TOPDIR="$(dirname $TOPDIR)/$RELEASE"
ARCH_PATH=$TOPDIR/..

cat << EOF
TOPDIR=$TOPDIR
ARCH_PATH=$ARCH_PATH
ARCH_BASENAME=$ARCH_BASENAME
EOF

cd $TOPDIR
sleep 3;
}
fi; 

# -------------------------------------------
# Prerequisites:
# -------------------------------------------
MAGIC=`whoami`-`eval date +%s`-tmp
STATE_DIR="state";
RULE_DIR="rules";
PKG_LIST="$STATE_DIR/packetlist"
SRC_DIR=$TOPDIR/src
SRC_TMP=/tmp/ptxdist_src-$MAGIC
SRC_TAR=$ARCH_PATH/$RELEASE-additional_sources.tar
PATCH_TAR=$ARCH_PATH/$RELEASE-additional_patches.tar
PTXDIST_TAR=$ARCH_PATH/$RELEASE.tgz
ZIP="bzip2"
TAR="tar"

echo "preparing ... " 
mkdir -p $SRC_TMP/src && echo "OK"
rm -rf $SRC_TMP/src/*

rm -f $SRC_TAR
rm -f $PATCH_TAR $PATCH_TAR.gz $PATCH_TAR.bz2

echo "sorting packet list..."
sort -u $PKG_LIST > $PKG_LIST.tmp && mv $PKG_LIST.tmp $PKG_LIST && echo "DONE"

# -------------------------------------------
# First, the software packages and patches
# -------------------------------------------

echo "copying package-archives to $SRC_TMP"
while read package ; do {
cp -a $SRC_DIR/$package $SRC_TMP/src/ || exit	
}
done < $PKG_LIST

echo "copying patch directories to $SRC_TMP"
cp -a patches feature-patches $SRC_TMP/

echo "constructing tar archives from $SRC_TMP"
$TAR -C $SRC_TMP -cvf $SRC_TAR src
$TAR -C $SRC_TMP -cvf $PATCH_TAR patches feature-patches

#echo "compressing patch archive"
#$ZIP $PATCH_TAR

echo "removing temp dir..."
rm -rf $SRC_TMP && echo "OK"

# -------------------------------------------
# Second, the main ptxdist archive
# -------------------------------------------

echo "constructing ptxdist archive"

# echo "WHRERE AM I ? $(pwd)"
echo "$ARCH_BASENAME"

$TAR -C $TOPDIR/.. -zcvf $PTXDIST_TAR 			\
	--exclude CVS					\
	--exclude .svn					\
	--exclude $ARCH_BASENAME/build/*		\
	--exclude $ARCH_BASENAME/state/*		\
	--exclude $ARCH_BASENAME/src/*			\
	--exclude $ARCH_BASENAME/src 			\
	--exclude $ARCH_BASENAME/root/*			\
	--exclude $ARCH_BASENAME/local/*		\
	--exclude $ARCH_BASENAME/bootdisk/*		\
	--exclude $ARCH_BASENAME/PATCHES-INCOMING	\
	--exclude $ARCH_BASENAME/patches		\
	--exclude $ARCH_BASENAME/Documentation/manual	\
	--exclude "\.#*"				\
	$ARCH_BASENAME

# -------------------------------------------
# Cleanup
# -------------------------------------------

if [ -e $TOPDIR/../release.lck ]; then {

ARCH_BASENAME=$(cat ../release.lck)
echo "archive release cycle for >>$RELEASE<< has ended,"
echo "restoring old name >>$ARCH_BASENAME<<"

cd $TOPDIR/..
mv -v $(basename $TOPDIR) $ARCH_BASENAME
rm -v release.lck

echo "I am done. Have a nice day :-)"
}
fi;



