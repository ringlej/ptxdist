#!/bin/bash
# b.buerger@pengutronix.de, Wed Feb  1 07:44:35 UTC  2006
PROGRAM_DESCRIPTION="Create Release Archives / Tarballs"

# Source generic ptxdist shell functions:
[ -e "$(dirname $0)/libptxdist.sh" ] && . $(dirname $0)/libptxdist.sh
#
# DEFAULTS:
#
TOPDIR=$(pwd) 
BASE="$(cd $TOPDIR ; cd .. ; pwd)"
ARCHPATH="$TOPDIR/.."
PROJECTSPATH="$TOPDIR/local_projects"
ACTION=create
RELEASE="undefined"
TAR="tar"

# 
# Parser (fuzzy testimplementation, proof of concept)
#
# <SYMBOL> 	<LONGOPTION>	<HELPTEXT>
source $(cat << EOF | ptxd_generic_option_parser 
ACTION   	action     create | check   -> Action 			 (Default: create)
TOPDIR  	topdir     <dir>            -> PTXDIST TOPDIR 		 (Default: $TOPDIR)
RELEASE  	release    <string>         -> PTXDIST Release Name 	 (Default: from Makefile)
ARCHPATH  	archpath   <path>           -> Where to put the Archives (Default: $ARCHPATH)
PROJECTSPATH  	projects   <path>           -> Path to local_projects    (Default: $PROJECTS)
EOF
)
invoke_parser $@

#
# Variable Defonitions
#
BASE=$TOPDIR/../
LOCKFILE="$BASE/.make_archive.lock"

#
# sanity checks
#

[ -e "$LOCKFILE" ] && ptxd_exit "Topdir is locked ($(cat $LOCKFILE))" 1
[ -d "$TOPDIR" ] || ptxd_exit "invalid --topdir ($TOPDIR)" 1
[ -d "$BASE" ] || ptxd_exit "invalid base directory ($BASE)" 1
[ -d "$ARCHPATH" ] || ptxd_exit "invalid --arch-path ($ARCHPATH)" 1
[ -d "$PROJECTSPATH/" ] && PROJECTSPATH=$(cd $PROJECTSPATH; pwd)

ARCHPATH="$(cd $ARCHPATH ; pwd)"
TOPDIR="$(cd $TOPDIR ; pwd)"
BASE="$(cd $TOPDIR ; cd .. ; pwd)"

if [ "$RELEASE" == "undefined" ] ; then
[ -e "$TOPDIR/Makefile" ] || ptxd_exit "could not determine release tag" 1
RELEASE=$(export $(egrep \
	"^PROJECT[[:blank:]]|^VERSION[[:blank:]]|^PATCHLEVEL[[:blank:]]|^SUBLEVEL[[:blank:]]|^EXTRAVERSION[[:blank:]]" \
	$TOPDIR/Makefile | sed s/'[\t ]*:=[\t ]*'/'='/g); \
	echo "$PROJECT-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION" \
	)
fi
[ -z "$RELEASE" ] && ptxd_exit "RELEASE Version is empty" 1

ARCHIVE_DIST=$ARCHPATH/$RELEASE.tgz
ARCHIVE_PATCHES=$ARCHPATH/$RELEASE-patches.tgz

#
# functions
#

#
info(){
echo "RELEASE Version ............. $RELEASE"
echo "TOPDIR  ..................... $TOPDIR"
echo "BASE ........................ $BASE"
echo "ARCHPATH .................... $ARCHPATH"
echo "PROJECTSPATH ................ $PROJECTSPATH"
echo "Please be patient ..."
}

goodbye(){
echo 
echo "Your Package Archives:"
ls -la $ARCHPATH/$RELEASE*.tgz
echo 
echo "Have a nice day :-)"
}

before_package(){
ptxd_debug "-- Remove old Archives --"
[ -e "$ARCHIVE_DIST" ] && rm -vf $ARCHIVE_DIST
[ -e "$ARCHIVE_PATCHES" ] && rm -vf $ARCHIVE_PATCHES
ptxd_debug "-- Prepare Packaging --"
date > $LOCKFILE
TMPDIR=`mktemp -d /tmp/ptxdist.XXXXXX` || exit 1
cd $BASE || ptxd_exit "Could not enter $BASE" 1

ptxd_debug "copy content to release directory $TMPDIR"
ptxd_debug "$(mkdir $TMPDIR/$RELEASE  2>&1 || ptxd_exit "Could not create temporary RELEASE directory" 1)"
$TAR -C $TOPDIR -cf - 					\
	--exclude .svn 					\
	--exclude local_projects 			\
	--exclude state 				\
	. | $TAR -C $TMPDIR/$RELEASE/ -xf -
if [ -d "$PROJECTSPATH" ] ; then
	ptxd_debug "$(mkdir -v $TMPDIR/$RELEASE/local_projects 2>&1 || ptxd_exit "Could not create temporary local_projects dir" 1)"
	$TAR -C $PROJECTSPATH -cf - --exclude .svn . | $TAR -C $TMPDIR/$RELEASE/local_projects/ -xf -
fi
}

package(){
ptxd_debug "-- Create Patch Archive from $TMPDIR/$RELEASE/patches/ --"
echo "packaging $ARCHIVE_PATCHES"
tar -C $TMPDIR -zcvf $ARCHIVE_PATCHES 			\
	--exclude .svn 					\
	$RELEASE/patches/ 				\
	2>&1 > $ARCHPATH/logfile.patches_package

ptxd_debug "-- Create Main Source Archive from $TMPDIR/$RELEASE/ --"
echo "packaging $ARCHIVE_DIST"
tar -C $TMPDIR -zcvf $ARCHIVE_DIST 			\
	--exclude .svn 					\
	--exclude $RELEASE/patches			\
	--exclude $RELEASE/local_projects		\
	$RELEASE/					\
	2>&1 > $ARCHPATH/logfile.release_package

ptxd_debug "-- Create Projects Source Archives from $TMPDIR/$RELEASE/local_projects/ --"
for file in $TMPDIR/$RELEASE/local_projects/*/*.ptxconfig; do
	if [ -e "$file" ]; then
		PROJECT_NAME=$(egrep "^PTXCONF_PROJECT=" $file | sed -e s/.*=//g -e s/\"//g )
		ptxd_debug "PROJECT_NAME is $PROJECT_NAME"
		PROJECT_VERSION=$(egrep "^PTXCONF_PROJECT_VERSION=" $file | sed -e s/.*=//g -e s/\"//g )
		ptxd_debug "PROJECT_VERSION is $PROJECT_VERSION"
		PROJECT_DIR=$(basename $(dirname $file))
		ptxd_debug "PROJECT_DIR is $PROJECT_DIR"
		ARCHIVE_PROJECT="$ARCHPATH/$RELEASE-${PROJECT_NAME}${PROJECT_VERSION}.tgz"
		[ -e "$ARCHIVE_PROJECT" ] && rm -vf $ARCHIVE_PROJECT
		echo "packaging local project $ARCHIVE_PROJECT"
		tar -C $TMPDIR -zcvf $ARCHIVE_PROJECT 	\
		--exclude .svn 				\
		$RELEASE/local_projects/$PROJECT_DIR/	\
		2>&1 > $ARCHPATH/logfile.${PROJECT_NAME}${PROJECT_VERSION}_package	
	else
		echo "skipping local projects - none found"
		echo "You might consider the --projects=<path of the local_projects directory> switch"
		[ -d "$TOPDIR/local_projects/" ] && echo "e.g. $0 $@ --projects $TOPDIR/local_projects"
	fi
done
}

after_package(){
cd $BASE || ptxd_exit "Could not enter $BASE" 1
ptxd_debug "-- Cleaning up after Packaging --"
ptxd_debug "$(rm -rvf $TMPDIR)"
ptxd_debug "$(rm -vf $LOCKFILE)"
}

info

#
# argument handling
#
case $ACTION in
	create)
	before_package
	package
	after_package
	;;
	check)
	echo "Not yet implemented"
	;;
	*)
	ptxd_exit "Sorry, unknown --action specified: $ACTION" 1
	;;
esac

goodbye

# vim: syntax=sh
# vim: tabstop=4
