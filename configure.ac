dnl
dnl Process this file with autoconf to produce a configure script.
dnl Most parts of this configure script have been borrowed from quilt.
dnl
dnl FIXME: how to have the version number only in one place?
dnl

AC_INIT([ptxdist],[0.10.2-svn],[ptxdist@pengutronix.de])
AC_CONFIG_AUX_DIR(autoconf)
AC_PREREQ(2.59)
AC_REVISION ($Revision: 1.38 $)

PACKAGE_RELEASE=1
AC_SUBST(PACKAGE_RELEASE)

dnl
dnl Check header files, mostly for lxdialog & kconfig
dnl

AC_HEADER_STDC
AC_CHECK_HEADER(
	[ncurses.h],
	[],
	AC_MSG_ERROR([Cannot find ncurses.h. Please install the ncurses development packet.])
)

AC_PROG_INSTALL

AC_SYS_INTERPRETER
if test "$interpval" != yes ; then
	AC_MSG_WARN([no

bash scripts may not be invoked correctly due to problems with your 
systems implementation of #! being either broken or non-existant.
])
fi

dnl Check for Bourne-Again Shell
unset BASH  # bash sets this itself!
AC_ARG_WITH(bash, AC_HELP_STRING(
    [--with-bash], [name of the bash executable to use]),
    [
	BASH="$withval"
	AC_SUBST(BASH)
	AC_MSG_NOTICE([Using bash executable $BASH])
    ],[
	AC_PATH_PROG(BASH, bash)
    ])
if test -z "$BASH" ; then
    AC_MSG_ERROR([Please specify the location of bash with the option '--with-bash'])
fi

# It would be nice not to have to use backticks, but too many retarded sh
# implementations still don't support $( )
# BEWARE:  There is a distinct possibility that we are currently running under
# bash in this configure script (/bin/sh being a symlink to /bin/bash).  Even
# though the result /could/ be available to us directly as $BASH_VERSION we
# don't want to use, or trust it, incase the user is specifying a different
# bash executable.
if `$BASH -c '[[ "$BASH_VERSION" \< "2.04" ]]'` ; then
    AC_MSG_ERROR([
$PACKAGE_NAME requires at least version 2.04 of bash, you can download a current
version of bash from ftp.gnu.org
])
fi

dnl Check for sed
dnl FIXME: which version do we need and how do we find out if it
dnl supports inplace?
AC_ARG_WITH(sed, AC_HELP_STRING(
    [--with-sed], [name of the sed executable to use]),
    [
	SED="$withval"
	AC_SUBST(SED)
	AC_MSG_NOTICE([Using sed executable $SED])
    ],[
	SED="sed"
	AC_SUBST(SED)
    ])

dnl Check for awk
AC_ARG_WITH(awk, AC_HELP_STRING(
    [--with-awk], [name of the awk executable to use]),
    [
	AWK="$withval"
	AC_SUBST(AWK)
	AC_MSG_NOTICE([Using awk executable $AWK])
    ],[
	AC_PATH_PROGS(AWK, [gawk awk])
    ])

dnl Test for awk features that may be mising?

dnl Checks for mktemp (for creating temporary files and directories)
AC_ARG_WITH(mktemp, AC_HELP_STRING(
    [--with-mktemp], [name of the mktemp executable to use (or 'none'
		      to use a quilt internal mechanism)]),
    [
	MKTEMP="$withval"
	AC_SUBST(MKTEMP)
	AC_MSG_NOTICE([Using mktemp executable $MKTEMP])
    ],[
	AC_PATH_PROG(MKTEMP, mktemp)
    ])
if test -z "$MKTEMP" -o "$MKTEMP" = "none" ; then
    MKTEMP=internal_mktemp
else
    AC_MSG_CHECKING(whether $MKTEMP -d works)
    if tempdir=`$MKTEMP -d /tmp/$PACKAGE_NAME.XXXXXX 2>/dev/null` && \
       rmdir "$tempdir" ; then
	AC_MSG_RESULT(yes)
    else
	AC_MSG_RESULT(no)
	AC_MSG_ERROR([
'$MKTEMP -d' does not create temporary directories.
If you don't have a version of mktemp that can create directories, you
can specify '--with-mktemp=none' and $PACKAGE_NAME will use its own
internal tempfile generation mechanism.
])
    fi
fi

dnl
dnl Checks for python, needed for ipkg-utils
dnl
AC_ARG_WITH(python, AC_HELP_STRING(
    [--with-python], [name of the python executable to use]),
    [
	PYTHON="$withval"
	AC_SUBST(PYTHON)
	AC_MSG_NOTICE([Using python executable $PYTHON])
    ],[
	PYTHON="python"
	AC_SUBST(PYTHON)
    ])
dnl
dnl We need the Python distutils
dnl
AC_MSG_CHECKING(whether $PYTHON finds distutils)
if test "`$PYTHON -c "import distutils" 2> /dev/null && echo yes`" = "yes"; then
	AC_MSG_RESULT(yes)
else
	AC_MSG_RESULT(no)
	AC_MSG_ERROR(Please install the Python distutils package)
fi


dnl
dnl Check for bison
dnl
AC_ARG_WITH(bison, AC_HELP_STRING(
    [--with-bison], [name of the bison executable to use]),
    [
	BISON="$withval"
	AC_SUBST(BISON)
	AC_MSG_NOTICE([Using bison executable $BISON])
    ],[
	BISON="bison"
	AC_SUBST(BISON)
    ])
AC_MSG_CHECKING(for $BISON)
if test "`type $BISON 2>&1 > /dev/null && echo yes`" = "yes"; then
	AC_MSG_RESULT(yes)
else
	AC_MSG_RESULT(no)
	AC_MSG_ERROR(Please install bison.)
fi


dnl Check for patch
AC_ARG_WITH(patch, AC_HELP_STRING(
    [--with-patch], [name of the patch executable to use]),
    [
	PATCH="$withval"
	AC_SUBST(PATCH)
	AC_MSG_NOTICE([Using patch executable $PATCH])
    ],[
	AC_PATH_PROG(PATCH, patch)
    ])
if test -z "$PATCH"; then
    AC_MSG_ERROR([Please specify the location of patch with the option '--with-patch'])
fi

# Sun's patch is a mess, issue a warning.  But we are going to continue with
# the build because you might just be lucky.
AC_MSG_CHECKING([whether $PATCH will work])
if $PATCH -v 2>&1 | grep -q "Sun" >/dev/null 2>&1; then
	AC_MSG_RESULT(no)
	AC_MSG_WARN([
Sorry, you have a Sun version of patch which is notoriously buggy.  $PACKAGE_NAME
may function correctly, or minor errors may occur due to Sun's patch tool.
Please consider upgrading to GNU patch, if you already have GNU patch then you
can supply its path with the '--with-patch=' option.
])
elif $PATCH --version 2>&1 | grep -q "patch 2.0" >/dev/null 2>&1; then
	AC_MSG_RESULT(no)
	AC_MSG_WARN([
Sorry, the version of patch you are using can cause severe problems when a patch
creates a directory.  $PACKAGE_NAME may well function correctly with this version
of patch or small problems could creep in.
Please consider upgrading your patch to a more recent version, if you already 
have a more recent version of patch then you can supply its path with the 
'--with-patch=' option.
])
else
	AC_MSG_RESULT(yes)
fi

dnl Check for rpmbuild (v4) vs. rpm (v3)
dnl AC_PATH_PROGS(RPMBUILD, [rpmbuild rpm])
dnl AC_SUBST(RPMBUILD)

AC_MSG_CHECKING([for dirname])
if test "`type dirname 2>&1 > /dev/null && echo yes`" = "yes"; then
	AC_MSG_RESULT(yes)
else
	AC_MSG_RESULT(no)
	AC_MSG_ERROR(Please install dirname.)
fi

AC_MSG_CHECKING([for cat])
if test "`type cat 2>&1 > /dev/null && echo yes`" = "yes"; then
	AC_MSG_RESULT(yes)
else
	AC_MSG_RESULT(no)
	AC_MSG_ERROR(Please install cat.)
fi

AC_MSG_CHECKING([for find])
if test "`type find 2>&1 > /dev/null && echo yes`" = "yes"; then
	AC_MSG_RESULT(yes)
else
	AC_MSG_RESULT(no)
	AC_MSG_ERROR(Please install find.)
fi

AC_MSG_CHECKING([for sort])
if test "`type sort 2>&1 > /dev/null && echo yes`" = "yes"; then
	AC_MSG_RESULT(yes)
else
	AC_MSG_RESULT(no)
	AC_MSG_ERROR(Please install sort.)
fi


dnl
dnl versions
dnl

VERSION_MAJOR=` echo "$PACKAGE_VERSION" | \
	sed -e "s/-/./g" | \
	(IFS=. read VERSION_MAJOR VERSION_MINOR VERSION_MICRO VERSION_EXTRA; echo $VERSION_MAJOR)`
VERSION_MINOR=` echo "$PACKAGE_VERSION" | \
	sed -e "s/-/./g" | \
	(IFS=. read VERSION_MAJOR VERSION_MINOR VERSION_MICRO VERSION_EXTRA; echo $VERSION_MINOR)`
VERSION_MICRO=` echo "$PACKAGE_VERSION" | \
	sed -e "s/-/./g" | \
	(IFS=. read VERSION_MAJOR VERSION_MINOR VERSION_MICRO VERSION_EXTRA; echo $VERSION_MICRO)`
VERSION_EXTRA=` echo "$PACKAGE_VERSION" | \
	sed -e "s/-/./g" | \
	(IFS=. read VERSION_MAJOR VERSION_MINOR VERSION_MICRO VERSION_EXTRA; echo $VERSION_EXTRA)`

if test -n "$VERSION_EXTRA"; then
	VERSION_EXTRA_SEP="-"
else
	VERSION_EXTRA_SEP=""
fi

AC_SUBST(PACKAGE_VERSION)
AC_SUBST(VERSION_MAJOR)
AC_SUBST(VERSION_MINOR)
AC_SUBST(VERSION_MICRO)
AC_SUBST(VERSION_EXTRA_SEP)
AC_SUBST(VERSION_EXTRA)

AC_MSG_RESULT([])
AC_CONFIG_FILES(Makefile scripts/ptxdistvars.sh rules/ptxdist-version.in)
AC_OUTPUT
AC_MSG_RESULT([])

dnl Print results
AC_MSG_RESULT([$PACKAGE_NAME version $PACKAGE_VERSION configured.])
AC_MSG_RESULT([Using '$prefix' for installation prefix.])

# we don't need to see this just for the backup-files command
# but we may as well spec it for the future
#AC_MSG_RESULT([Using '$CC' for C compiler.])
#AC_MSG_RESULT([Building with '$CFLAGS' for C compiler flags.])
#AC_MSG_RESULT([Building with '$LIBS' for linker flags.])

AC_MSG_RESULT([])
AC_MSG_RESULT([Report bugs to $PACKAGE_BUGREPORT])
AC_MSG_RESULT([])
