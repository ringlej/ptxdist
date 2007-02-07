dnl
dnl Process this file with autoconf to produce a configure script.
dnl Most parts of this configure script have been borrowed from quilt.
dnl
dnl FIXME: how to have the version number only in one place?
dnl

AC_INIT([ptxdist],[0.10.svn],[ptxdist@pengutronix.de])
AC_CONFIG_AUX_DIR(autoconf)
AC_PREREQ(2.59)
AC_REVISION ($Revision: 1.38 $)

PACKAGE_RELEASE=1
AC_SUBST(PACKAGE_RELEASE)

dnl
dnl Check if the user has extracted the patches archive
dnl

AC_MSG_CHECKING(for ptxdist patches)
if test -d `dirname $0`/patches
then
	AC_MSG_RESULT(yes)
else
	AC_MSG_RESULT(no)
	AC_MSG_ERROR([install the ptxdist-patches archive into the same directory as ptxdist.],[1])
fi


dnl
dnl Check header files, mostly for lxdialog & kconfig
dnl

AC_HEADER_STDC
AC_CHECK_HEADER(
	[ncurses.h],
	[],
	AC_MSG_ERROR([Cannot find ncurses.h. Please install the ncurses development packet.])
)

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


dnl Check for sed >= 4.0
AC_PATH_PROGS(SED, sed,, $PATH)
if test -z "$SED"; then
	AC_MSG_ERROR([sed could not be found, please install])
fi

AC_MSG_CHECKING([sed version])
SED_VERSION=`$SED --version 2>/dev/null | $SED -ne "s/.*version \([[0-9\.]]*\)/\1/p"`
case "$SED_VERSION" in
3.*) AC_MSG_ERROR([we need at least GNU sed 4.x but found $SED_VERSION]) ;;
4.*) ;;
*)   AC_MSG_ERROR([we need at least GNU sed 4.x]) ;;
esac
AC_MSG_RESULT([$SED_VERSION])

dnl Check for egrep
AC_PROG_EGREP

dnl Check for install
AC_PROG_INSTALL
if test -z "${INSTALL}"; then
	AC_MSG_ERROR([install could not be found, please install e.g.: GNU coreutils])
fi

dnl Check for gcc
AC_PROG_CC
if test -z "$CC"; then
	AC_MSG_ERROR([gcc could not be found, please install])
fi

dnl Check for awk
AC_PROG_AWK
AC_MSG_CHECKING([awk version])
AWK_VERSION=`$AWK --version 2>/dev/null | $SED -ne "s/GNU [[Aa]]wk \([[0-9\.]]*\)/\1/p"`
case "$AWK_VERSION" in
"") AC_MSG_ERROR([we need GNU awk]) ;;
*)  ;;
esac
AC_MSG_RESULT([$AWK_VERSION])

# FIXME: we might want localedef as hosttool later
dnl Check for localedef >= 2.2.0
AC_PATH_PROGS(LOCALEDEF, localedef,, $PATH)
if test -z "$LOCALEDEF"; then
	AC_MSG_ERROR([localedef could not be found, please install])
fi

AC_MSG_CHECKING([localedef version])
LOCALEDEF_VERSION=`$LOCALEDEF --version 2>/dev/null | $SED -ne "s/.*[bin|libc]. \([[0-9\.]]*\)/\1/p"`
case "$LOCALEDEF_VERSION" in
2.[[01]]*) AC_MSG_ERROR([we need at least GNU localedef 2.2.x but found $LOCALEDEF_VERSION]) ;;
2.[[23456789]]*) ;;
*)   AC_MSG_ERROR([we need at least GNU localedef 2.2.x]) ;;
esac
AC_MSG_RESULT([$LOCALEDEF_VERSION])

dnl Check for lex
AC_PROG_LEX
AC_PATH_PROGS(LEX, ${LEX},, $PATH)
if test -z "${LEX}"; then
   AC_MSG_ERROR([(f)lex could not be found, please install])
fi

dnl Check for yacc
AC_PROG_YACC
AC_PATH_PROGS(YACC, ${YACC},, $PATH)
if test -z "${YACC}"; then
   AC_MSG_ERROR([yacc/bison could not be found, please install])
fi

dnl Check for bunzip2
AC_PATH_PROGS(BUNZIP2, bunzip2,, $PATH)
if test -z "$BUNZIP2"; then
	AC_MSG_ERROR([bunzip2 could not be found, please install])
fi

dnl Check for gunzip
AC_PATH_PROGS(GUNZIP, gunzip,, $PATH)
if test -z "$GUNZIP"; then
	AC_MSG_ERROR([gunzip could not be found, please install])
fi

dnl Check for readlink
AC_PATH_PROGS(READLINK, readlink,, $PATH)
if test -z "$READLINK"; then
	AC_MSG_ERROR([readlink could not be found, please install])
fi

dnl Check for mktemp
AC_PATH_PROGS(MKTEMP, mktemp,, $PATH)
if test -z "$MKTEMP"; then
	AC_MSG_ERROR([mktemp could not be found, please install])
fi

dnl Check for pkg-config
AC_PATH_PROGS(PKG_CONFIG, pkg-config,, $PATH)
if test -z "${PKG_CONFIG}"; then
	AC_MSG_ERROR([pkg-config could not be found, please install])
fi

dnl Check for wget
AC_PATH_PROGS(WGET, wget,, $PATH)
if test -z "$WGET"; then
	AC_MSG_ERROR([wget could not be found, please install])
fi 

dnl Check for tar
AC_PATH_PROGS(TAR, tar,, $PATH)
if test -z "$TAR"; then
	AC_MSG_ERROR([tar could not be found, please install])
fi

dnl Check for dirname
AC_PATH_PROGS(DIRNAME, dirname,, $PATH)
if test -z "$DIRNAME"; then
	AC_MSG_ERROR([dirname could not be found, please install])
fi

dnl Check for cat
AC_PATH_PROGS(CAT, cat,, $PATH)
if test -z "$CAT"; then
	AC_MSG_ERROR([cat could not be found, please install])
fi

dnl Check for find
AC_PATH_PROGS(FIND, find,, $PATH)
if test -z "$FIND"; then
	AC_MSG_ERROR([find could not be found, please install])
fi

AC_MSG_CHECKING([find version])
FIND_VERSION=`$FIND --version 2>/dev/null | $SED -ne "s/.*version \([[0-9\.]]*\)/\1/p"`
case "$FIND_VERSION" in
4.*) ;;
*)   AC_MSG_ERROR([we need at least GNU find 4.x]) ;;
esac
AC_MSG_RESULT([$FIND_VERSION])

dnl Check for sort
AC_PATH_PROGS(SORT, sort,, $PATH)
if test -z "$SORT"; then
	AC_MSG_ERROR([sort could not be found, please install])
fi

dnl Check for perl
AC_PATH_PROGS(PERL, perl,, $PATH)
if test -z "$PERL"; then
	AC_MSG_ERROR([perl could not be found, please install])
fi

dnl Check for expect
AC_PATH_PROGS(EXPECT, expect,, $PATH)
if test -z "$EXPECT"; then
	AC_MSG_ERROR([expect could not be found, please install])
fi

dnl Check for make
AC_PATH_PROGS(MAKE, gmake gnumake make,, $PATH)
if test -z "$MAKE"; then
	AC_MSG_ERROR([make could not be found, please install])
fi

dnl Check for file
AC_PATH_PROGS(FILE, file,, $PATH)
if test -z "$FILE"; then
	AC_MSG_ERROR([file could not be found, please install])
fi

dnl Check for gcc
AC_PATH_PROGS(GCC, gcc,, $PATH)

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

dnl Check for kermit for pelts

dnl Check for rpmbuild (v4) vs. rpm (v3)
dnl AC_PATH_PROGS(RPMBUILD, [rpmbuild rpm])
dnl AC_SUBST(RPMBUILD)


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
AC_CONFIG_FILES( \
	Makefile \
	scripts/ptxdist_version.sh \
	rules/ptxdist-version.in \
)
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
