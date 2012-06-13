dnl
dnl Process this file with autoconf to produce a configure script.
dnl Most parts of this configure script have been borrowed from quilt.
dnl
AC_PREREQ(2.59)

AC_INIT([ptxdist],
	m4_esyscmd([scripts/kernel/setlocalversion .tarball-version]),
	[ptxdist@pengutronix.de])
AC_CONFIG_AUX_DIR(scripts/autoconf)
AC_CANONICAL_BUILD
AC_CANONICAL_HOST

dnl
dnl Check if the user has extracted the patches archive
dnl
AC_MSG_CHECKING(for ptxdist patches)
if test -d `dirname $0`/patches
then
	AC_MSG_RESULT(yes)
else
	AC_MSG_RESULT(no)
	AC_MSG_ERROR([install the ptxdist-patches archive into the same directory as ptxdist.])
fi


dnl
dnl Check header files, mostly for lxdialog & kconfig
dnl
AC_HEADER_STDC

AC_CHECK_HEADER([regex.h], [], AC_MSG_ERROR([Cannot find regex.h.]))

AC_SEARCH_LIBS(regcomp, [regex gnuregex],,
	AC_MSG_ERROR([POSIX regex required.]))
CONF_LIBS=${LIBS}
AC_SUBST(CONF_LIBS)

AC_SEARCH_LIBS(mvaddch, [curses ncurses pdcurses], [CURSES_LIB=$ac_lib],
	[AC_MSG_ERROR([curses development library not found, please install libncurses-dev])])
MCONF_LIBS=${LIBS}
AC_SUBST(MCONF_LIBS)

AC_CHECK_HEADERS(
	[curses.h ncurses.h ncurses/curses.h ncurses/ncurses.h pdcurses.h pdcurses/curses.h pdcurses/pdcurses.h],
	[CURSES_LOC="<$ac_header>";found_curses_headers=yes; break;])
AS_IF([test "x$CURSES_LOC" = "x"],
	[AC_MSG_ERROR([curses headers not found])])
AC_SUBST(CURSES_LOC)

AC_ARG_WITH(ncurses, AS_HELP_STRING([--with-ncurses],[Include path to the ncurses headers]),
	[
		if test "x$withval" != "xyes"; then
			CPPFLAGS="-I$withval"
			AC_SUBST(CPPFLAGS)
		fi
		with_ncurses=yes
	],[
		with_ncurses=auto
])

AC_CHECK_HEADER(
	[menu.h],
	[NCURSES_FOUND=yes],[
	if test "$with_ncurses" = "yes"; then
		AC_MSG_ERROR([Cannot find menu.h (ncurses).])
	else
		AC_MSG_WARN([Cannot find menu.h (ncurses). Not building nconf.])
	fi
])
AM_CONDITIONAL(BUILD_NCONF, test "x$NCURSES_FOUND" = "xyes")


AC_SYS_INTERPRETER
if test "$interpval" != yes ; then
	AC_MSG_WARN([no

bash scripts may not be invoked correctly due to problems with your
systems implementation of #! being either broken or non-existant.
])
fi

dnl Check for Bourne-Again Shell
unset BASH  # bash sets this itself!
AC_ARG_WITH(bash, AS_HELP_STRING([--with-bash],[name of the bash executable to use]),
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
AC_PATH_PROGS(SED, gsed sed,, $PATH)
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

dnl check for gnu tools
dnl   $1: tool to search for
dnl   $2: package where the tool is (e.g. 'coreutils')
AC_DEFUN([GNU_TOOL],
	[AC_CACHE_CHECK([for GNU $1], [ac_cv_path_gnu_$1],
		[AC_PATH_PROGS_FEATURE_CHECK([gnu_$1], [g$1 $1.gnu $1],
			[[out=`$ac_path_gnu_$1 --version 2>/dev/null | $SED -ne "s/.*\(GNU\) $2.*/\1/p"`
				test "x$out" = xGNU && ac_cv_path_gnu_$1=$ac_path_gnu_$1 ac_path_gnu_$1_found=:]],
			[AC_MSG_ERROR([could not find GNU $1])])])
	AC_SUBST([GNU_$1], [$ac_cv_path_gnu_$1])])

GNU_TOOL(chmod, coreutils)
GNU_TOOL(chown, coreutils)
GNU_TOOL(mv, coreutils)
GNU_TOOL(cp, coreutils)
GNU_TOOL(rm, coreutils)
GNU_TOOL(rmdir, coreutils)
GNU_TOOL(md5sum, coreutils)
GNU_TOOL(mkdir, coreutils)
GNU_TOOL(install, coreutils)
GNU_TOOL(stat, coreutils)
GNU_TOOL(mknod, coreutils)
GNU_TOOL(sort, coreutils)
GNU_TOOL(readlink, coreutils)
GNU_TOOL(tar, tar)
GNU_TOOL(find, findutils)

dnl Check for egrep
AC_PROG_EGREP

dnl Check for gcc
AC_PROG_CC
if test -z "$CC"; then
	AC_MSG_ERROR([gcc could not be found, please install])
fi

dnl Check for g++
AC_PROG_CXX
if test -z "$CXX"; then
	AC_MSG_ERROR([g++ could not be found, please install])
fi

dnl Check for awk
AC_PROG_AWK
AC_PATH_PROGS(AWK, ${AWK},)
AC_MSG_CHECKING([awk version])
AWK_VERSION=`$AWK --version 2>/dev/null | $SED -ne "s/GNU [[Aa]]wk \([[0-9\.]]*\)/\1/p"`
case "$AWK_VERSION" in
"") AC_MSG_ERROR([we need GNU awk]) ;;
*)  ;;
esac
AC_MSG_RESULT([$AWK_VERSION])

# fall back to 'false' for systems which do not provide a 'sysctl' tool
AC_PATH_PROGS(SYSCTL, sysctl false,, $PATH)

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


AC_MSG_CHECKING([whether yacc is bison++])
if $YACC --version 2>/dev/null | grep bison++ -q; then
   AC_MSG_ERROR([your $YACC turns out to be bison++, please install plain bison])
else
   AC_MSG_RESULT([no, this is good])
fi

AC_MSG_CHECKING([yacc/bison version])
YACC_VERSION=`$YACC --version 2>/dev/null | $SED -ne "s/.*GNU Bison.* \([[0-9.]]*\).*/\1/p"`
case "${YACC_VERSION}" in
     1.*)
     AC_MSG_ERROR([$YACC_VERSION, your bison version is too old, install 2.3 or sth. like that]) ;;
     "")
     AC_MSG_WARN([no GNU bison found, continuing anyway....]) ;;
     *)
     AC_MSG_RESULT([$YACC_VERSION]) ;;
esac

dnl Check for makeinfo
AC_PATH_PROGS(MAKEINFO, makeinfo,, $PATH)
if test -z "$MAKEINFO"; then
	AC_MSG_ERROR([makeinfo could not be found, please install the texinfo package])
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

dnl Check for unzip
AC_PATH_PROGS(UNZIP, gunzip,, $PATH)
if test -z "$UNZIP"; then
	AC_MSG_ERROR([unzip could not be found, please install])
fi

dnl Check for mktemp
AC_PATH_PROGS(MKTEMP, mktemp,, $PATH)
if test -z "$MKTEMP"; then
	AC_MSG_ERROR([mktemp could not be found, please install])
fi

dnl Check for wget
AC_PATH_PROGS(WGET, wget,, $PATH)
if test -z "$WGET"; then
	AC_MSG_ERROR([wget could not be found, please install])
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

AC_MSG_CHECKING([find version])
FIND_VERSION=`$GNU_find --version 2>/dev/null | $SED -ne "s/.*\s\+\([[0-9]]\+\.[[0-9]]\+\.[[0-9]]\+\).*$/\1/p"`
case "$FIND_VERSION" in
4.*) ;;
*)   AC_MSG_ERROR([we need at least GNU find 4.x]) ;;
esac
AC_MSG_RESULT([$FIND_VERSION])

dnl Check for xargs
AC_PATH_PROGS(XARGS, xargs,, $PATH)
if test -z "$XARGS"; then
	AC_MSG_ERROR([xargs could not be found, please install])
fi

AC_MSG_CHECKING([if xargs -r works as expected])
echo | ${XARGS} -r false
if test $? -ne 0; then
	AC_MSG_ERROR([xargs with "-r" support needed, please install GNU xargs (unsually located in the "findutils" package])
fi
AC_MSG_RESULT([ok])

dnl Check for make
AC_PATH_PROGS(MAKE, gmake gnumake make,, $PATH)
if test -z "$MAKE"; then
	AC_MSG_ERROR([make could not be found, please install])
fi
MAKE_VERSION=`$MAKE --version 2>/dev/null | $SED -ne "s/^GNU Make \([[0-9]]\+\.[[0-9.]]\+\).*$/\1/p"`
MINOR_MAKE_VERSION="${MAKE_VERSION#*.}"
MAJOR_MAKE_VERSION="${MAKE_VERSION%.*}"
if test -z "${MAJOR_MAKE_VERSION}"  -o -z "${MINOR_MAKE_VERSION}" ; then
	AC_MSG_ERROR([could not parse make version. GNU make >= 3.81 required])
fi
if test $MAJOR_MAKE_VERSION -eq 3 -a $MINOR_MAKE_VERSION -lt 81 -o $MAJOR_MAKE_VERSION -lt 3 ; then
	AC_MSG_ERROR([GNU make >= 3.81 required ($MAKE_VERSION found)])
fi

dnl Check for file
AC_PATH_PROGS(FILE, file,, $PATH)
if test -z "$FILE"; then
	AC_MSG_ERROR([file could not be found, please install])
fi

dnl Check for msgfmt
AC_PATH_PROGS(MSGFMT, msgfmt,, $PATH)
if test -z "$MSGFMT"; then
	AC_MSG_ERROR([gettext could not be found, please install])
fi

dnl Check for tty
AC_PATH_PROGS(TTY, tty,, $PATH)
if test -z "$TTY"; then
	AC_MSG_ERROR([tty could not be found, please install])
fi

dnl Check for gcc
AC_PATH_PROGS(GCC, gcc,, $PATH)

dnl
dnl Checks for python, needed for ipkg-utils
dnl
AC_ARG_WITH(python, AS_HELP_STRING([--with-python],[name of the python executable to use]),
    [
	PYTHON="$withval"
	AC_SUBST(PYTHON)
	AC_MSG_NOTICE([Using python executable $PYTHON])
    ],[
	AC_PATH_PROGS(PYTHON, python2.7 python2.6 python)
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

AC_MSG_CHECKING(whether python development files are present)
PYTHON_CONFDIR=`$PYTHON -v -c "import distutils" 2>&1 | $EGREP distutils | $EGREP directory | $SED -ne "s/^[[^\/]]*\([[^[:space:]]]*\).*/\1/p"`/../config/
if test -e "$PYTHON_CONFDIR/Makefile"; then
	AC_MSG_RESULT(yes)
else
	AC_MSG_RESULT(no)
	AC_MSG_ERROR([some python development files could not be found, you are
		      likely using suse or redhat system as host. In this case
		      please install the python-devel packages])
fi

dnl Check for patch
AC_ARG_WITH(patch, AS_HELP_STRING([--with-patch],[name of the patch executable to use]),
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

dnl check if bash completion is desired (adapted from 'source-highlight' by Lorenzo Bettini)
dnl don't use sysconfdir! as bash_completion does not check multiple directories, we use the system default

AC_ARG_WITH([bash-completion],
	AS_HELP_STRING([--with-bash-completion@<:@=DIR@:>@], [install bash_completion file (default: yes) - optionally specify bash_completion directory (default: /etc/bash_completion.d)]),
	[
	if test "$withval" = "no"; then
		BASH_COMPLETION_DIR=""
	elif test "$withval" = "yes"; then
		BASH_COMPLETION_DIR=/etc/bash_completion.d
	else
		BASH_COMPLETION_DIR="$withval"
	fi
	],
	[BASH_COMPLETION_DIR=/etc/bash_completion.d]
)
AC_SUBST(BASH_COMPLETION_DIR)

AC_MSG_RESULT([])
AC_CONFIG_FILES( \
	Makefile \
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
