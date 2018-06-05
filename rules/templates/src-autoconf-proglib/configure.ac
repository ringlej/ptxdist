AC_PREREQ(2.69)

# TODO add useful information about this package
AC_INIT([@name@], 0.0.0, [bugs@yourdomain.to], [@name@], [http://www.yourdomain.to/])
AC_CONFIG_SRCDIR([@name@.c])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_MACRO_DIR([m4])
AC_CANONICAL_BUILD
AC_CANONICAL_HOST

# default is less output while building the package
AM_SILENT_RULES([yes])

# TODO If you don't want the default installation path to be '/usr/local' change it here
# AC_PREFIX_DEFAULT(<new prefix>)

# If possible, enable extensions to Posix
AC_USE_SYSTEM_EXTENSIONS

#
# libtool library versioning stuff
#
# Library code modified:            REVISION++
# Interfaces changed/added/removed: CURRENT++   REVISION=0
# Interfaces added:                 AGE++
# Interfaces removed:               AGE=0
LT_CURRENT=0
LT_REVISION=0
LT_AGE=0
AC_SUBST(LT_CURRENT)
AC_SUBST(LT_REVISION)
AC_SUBST(LT_AGE)

AM_MAINTAINER_MODE
AM_INIT_AUTOMAKE([foreign no-exeext dist-xz silent-rules subdir-objects])

#
# Checks for programs.
#
AC_PROG_CC
AC_PROG_LIBTOOL

LT_INIT

#
# TODO Check here for mandadory external libraries
#
# Rule of thumb: when your library needs an external library, add it
# to the 'LIBS' variable. Do _not_ add it manually into the Makefile.am files.
# These libraries _must_ be listed in the *.pc file.
#
# Don't add libraries without a check. Even if you know the 'sqrt()' requires
# 'libm' on most systems, check for its real need with 'AC_SEARCH_LIBS(sqrt, m)'.
# Doing it in this way will ensure an embedded developer knows exactly what
# dependencies your library has (because it gets listed in the *.pc file).
#
# Another way for checking libraries is the PKG_CHECK_MODULES macro. But please
# honor if a user switches off a feature you also switch of the test for a
# external component via PKG_CHECK_MODULES when it is no longer required!
# PKG_CHECK_MODULES returns *_CFLAGS and *_LIBS. Again, add the *_LIBS to the
# global 'LIBS', but for the CFLAGS you can decide if you add them to the
# CFLAGS, AM_CFLAGS or as substitution variables in the Makefile.am.
#

#REQUIRES_LIBSOMETHING="libsomething >= 20090402-1"
#AC_SUBST(REQUIRES_LIBSOMETHING)
#PKG_CHECK_MODULES(libsomething, $REQUIRES_LIBSOMETHING)

#
# TODO Check for functions and header files. First write your code and then run
# the 'autoscan' tool to get an idea what is still missing in your 'configure.ac'
#

# where to install pgk info files
PKG_INSTALLDIR

PTX_COMMON_CHECKS
PTX_LIBRARY_CHECKS
PTX_APPLICATION_CHECKS

# be very silent on request
AM_CONDITIONAL(BUILD_SILENTLY, test "x$AM_DEFAULT_VERBOSITY" = x0)

# add required lib information to the pkg-config file (on demand)
AC_SUBST(REQUIRES)

AC_CONFIG_FILES([
	lib@name@.pc
	Makefile
])
AC_OUTPUT

AC_MSG_RESULT([
	------------------------------------------------------
	Configure results for: ${PACKAGE}
	------------------------------------------------------

	Release State:
	------------------------------------------------------
	 Library release:	${LT_CURRENT}.${LT_REVISION}.${LT_AGE}
	 Package release:	${VERSION}

	General:
	------------------------------------------------------
	 Cross compiling:	${cross_compiling}
	 Compiler:		${CC}
	 Target CPU:		${host_cpu}
	 Target OS:		${host_os}

	Detected options:
	------------------------------------------------------
	 CPPFLAGS:		${CPPFLAGS}
	 CFLAGS:		${CFLAGS}
	 LDFLAGS:		${LDFLAGS}
	 Debug:			${enable_debug}
	 Hidden symbols		${enable_hide}
	 Coverage:		${enable_code_coverage}
		CPPFLAGS:	${CODE_COVERAGE_CPPFLAGS}
		CFLAGS:		${CODE_COVERAGE_CFLAGS}
		LDFLAGS:	${CODE_COVERAGE_LDFLAGS}
	 Profiling:		${enable_profile}
	 Optimisation goal:	${with_goal}
	 Private libs:		${LIBS}
	 Use abort():		${enable_abort}

	Install options:
	------------------------------------------------------
	 prefix:		${prefix}
	 sysconfdir:		${sysconfdir}
	 libdir:		${libdir}
	 includedir:		${includedir}
	 bindir:		${bindir}
	 pkgconfigdir:		${pkgconfigdir}
])
