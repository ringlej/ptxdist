AC_PREREQ(2.69)

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

# support LFS
AC_SYS_LARGEFILE

AM_MAINTAINER_MODE
AM_INIT_AUTOMAKE([foreign no-exeext dist-xz silent-rules subdir-objects])

#
# Checks for programs.
#
AC_PROG_CC

##
# libsomething
##
#REQUIRES_LIBSOMETHING="libsomething >= 20090402-1"
#AC_SUBST(REQUIRES_LIBSOMETHING)
#PKG_CHECK_MODULES(libsomething, $REQUIRES_LIBSOMETHING)

PTX_COMMON_CHECKS
PTX_APPLICATION_CHECKS

# be very silent on request
AM_CONDITIONAL(BUILD_SILENTLY, test "x$AM_DEFAULT_VERBOSITY" = x0)

AC_CONFIG_FILES([
	Makefile
])
AC_OUTPUT

AC_MSG_RESULT([
	------------------------------------------------------
	Configure results for: ${PACKAGE}
	------------------------------------------------------

	Release State:
	------------------------------------------------------
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
	 Coverage:		${enable_code_coverage}
		CPPFLAGS:	${CODE_COVERAGE_CPPFLAGS}
		CFLAGS:		${CODE_COVERAGE_CFLAGS}
		LDFLAGS:	${CODE_COVERAGE_LDFLAGS}
	 Profiling:		${enable_profile}
	 optimisation goal:	${with_goal}
	 Private libs:		${LIBS}
	 Use abort():		${enable_abort}

	Install options:
	------------------------------------------------------
	 prefix:		${prefix}
	 sysconfdir:		${sysconfdir}
	 libdir:		${libdir}
	 includedir:		${includedir}
	 bindir:		${bindir}
])
