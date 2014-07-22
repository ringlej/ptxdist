AC_PREREQ(2.69)

# TODO add useful information about this package
AC_INIT([@name@], 0.0.0, [bugs@yourdomain.to], [@name@], [http://www.yourdomain.to/])
AC_CONFIG_SRCDIR([config.h.in])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_MACRO_DIR([m4])
AC_CANONICAL_BUILD
AC_CANONICAL_HOST

# default is less output while building the package
AM_SILENT_RULES([yes])

# TODO If you don't want the default installation path to be '/usr/local' change it here
# AC_PREFIX_DEFAULT(<new prefix>)

# TODO If possible, enable extensions to Posix
AC_USE_SYSTEM_EXTENSIONS

#
# libtool library versioning stuff
#
# Using these variables results into
#
# lib<something>-<API_RELEASE>.so.<LT_CURRENT.LT_REVISION.LT_AGE>
#
# API_RELEASE: API compatibility. Its up to you to define a specific version here
#
# LT_CURRENT.LT_REVISION.LT_AGE: binary compatibility.
#   Here the rule is:
#   - library code was modified: LT_REVISION++
#   - interfaces changed/added/removed: LT_CURRENT++ and REVISION = 0
#   - interfaces added: LT_AGE++
#   - interfaces removed: LT_AGE = 0
#
API_RELEASE=0.0
AC_SUBST(API_RELEASE)

# TODO Library release
LT_CURRENT=0
LT_REVISION=0
LT_AGE=0

AC_SUBST(LT_CURRENT)
AC_DEFINE_UNQUOTED(@NAME@_MAJOR, ${LT_CURRENT}, [libs major number])
AC_SUBST(LT_REVISION)
AC_DEFINE_UNQUOTED(@NAME@_MINOR, ${LT_REVISION}, [libs minor number])
AC_SUBST(LT_AGE)
AC_DEFINE_UNQUOTED(@NAME@_MICRO, ${LT_AGE}, [libs micro number])

AM_MAINTAINER_MODE
AM_INIT_AUTOMAKE([foreign no-exeext dist-bzip2])

#
# Checks for programs.
#
AC_PROG_CC

#
# TODO to only build the static library uncomment the following line
# AC_DISABLE_SHARED([])
# TODO to only build the shared library uncomment the following line
# AC_DISABLE_STATIC([])

LT_INIT

#
# Using additional preprocessor, compiler or linker flags:
# - add them to AM_CPPFLAGS, AM_CFLAGS or AM_LDFLAGS if they should be used
#   by all source files
# - give the user a chance to setup her/his own flags with the CPPFLAGS, CFLAGS
#   and LDFLAGS
# - if some flags are specific to a file add the flags via the substitute macro
#   into the Makefile
#
# Don't add the "-g" to the CFLAGS variable. It will be done automatically if
# autoconf detects a GNU compiler.
#

#
# Please note: 'configure' defaults the CFLAGS to "-O2 -g" if it detects a
# GCC. If the user overwrites the CFLAGS externallly, there will be no default!
# Keep the user informed about this behaviour.

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

#
# TODO Check for functions and header files. First write your code and then run
# the 'autoscan' tool to get an idea what is still missing in your 'configure.ac'
#


# ----------------------------------------------------------------------------

#
# Ensure this file is easy to read. First list all switches and after that
# make your descisions based the results of the switches
#

#
# Debugging
#
AC_MSG_CHECKING([whether to enable debug])
AC_ARG_ENABLE([debug],
	[AS_HELP_STRING([--enable-debug],
		[use debug compiler flags and macros @<:@default=disabled@:>@])],
	[],
	[enable_debug=no])
AC_MSG_RESULT([${enable_debug}])

#
# Enable profiling support
#
AC_MSG_CHECKING([whether to enable profiling support])
AC_ARG_ENABLE([profile],
	[AS_HELP_STRING([--enable-profile],
		[allow profiling @<:@default=disabled@:>@])],
	[],
	[enable_profile=no])
AC_MSG_RESULT([${enable_profile}])

#
# Enable test coverage support
#
AC_MSG_CHECKING([whether to enable code coverage support])
AC_ARG_ENABLE([coverage],
	[AS_HELP_STRING([--enable-coverage],
		[allow code coverage @<:@default=disabled@:>@])],
	[],
	[enable_coverage=no])
AC_MSG_RESULT([${enable_coverage}])

#
# should the library export all symbols?
#
AC_MSG_CHECKING([whether to hide internal symbols])
AC_ARG_ENABLE([hide],
	[AS_HELP_STRING([--disable-hide],
		[hide all internal library symbols @<:@default=enabled@:>@])],
	[],
	[enable_hide=yes])
AC_MSG_RESULT([${enable_hide}])

# ----------------------------------------------------------------------------

#
# TODO add as much warnings as possible, but check what the compiler
# is able to understand and use it only if possible
#
CC_CHECK_CFLAGS([-pipe],[AM_CFLAGS="${AM_CFLAGS} -pipe"])
CC_CHECK_CFLAGS([-W],[AM_CFLAGS="${AM_CFLAGS} -W"])
CC_CHECK_CFLAGS([-Wall],[AM_CFLAGS="${AM_CFLAGS} -Wall"])
CC_CHECK_CFLAGS([-Wsign-compare],[AM_CFLAGS="${AM_CFLAGS} -Wsign-compare"])
CC_CHECK_CFLAGS([-Wfloat-equal],[AM_CFLAGS="${AM_CFLAGS} -Wfloat-equal"])
CC_CHECK_CFLAGS([-Wformat-security],[AM_CFLAGS="${AM_CFLAGS} -Wformat-security"])
CC_CHECK_CFLAGS([-Wno-unused-parameter],[AM_CFLAGS="${AM_CFLAGS} -Wno-unused-parameter"])

#
# Does the linker supports "--no-undefined"?
#
CC_NOUNDEFINED

#
# TODO Can we register functions running at library's load time?
#
CC_ATTRIBUTE_CONSTRUCTOR([AC_DEFINE(PRERUN, 1, [run at link time])], [])

#
# TODO Link only those libraries that are *really* used
#
CC_CHECK_LDFLAGS([-Wl,--as-needed], [AM_LDFLAGS="${AM_LDFLAGS} -Wl,--as-needed"],[])

# ---------------------------------------------------------------------------

# TODO Checking if this CPU has a hardware floating point unit

#AX_HARDWARE_FP([target_hardware_fp=yes], [target_hardware_fp=no])

# When a hardware floating point unit seems available, then use it.
# This will end in bad code on badly configured compilers which generates
# floating point instructions even if the CPU has not hardware FP unit
#
#AS_IF([test x${target_hardware_fp} = "xyes"],
#	[AC_MSG_NOTICE([FPU available])],
#	[AC_MSG_NOTICE([FPU not available])])

# ---------------------------------------------------------------------------

# TODO discover on demand the special architecture this compiler builds code
# for. This can be useful if the package provides some optimized code for
# specific architectures.

#AS_IF([test x${host_cpu} = "xarm"],
#	[AX_DETECT_ARMV4([enable_arm4=yes], [enable_arm4=no])
#	AX_DETECT_ARMV5([enable_arm5=yes], [enable_arm5=no])
#	AX_DETECT_ARMV6([enable_arm6=yes], [enable_arm6=no])
#	AX_DETECT_ARMV7([enable_arm7=yes], [enable_arm7=no])
#
#	AS_IF([test x${enable_arm4} = "xyes"], [AC_MSG_NOTICE([ARMv4 target])])
#	AS_IF([test x${enable_arm5} = "xyes"], [AC_MSG_NOTICE([ARMv5 target])])
#	AS_IF([test x${enable_arm6} = "xyes"], [AC_MSG_NOTICE([ARMv6 target])])
#	AS_IF([test x${enable_arm7} = "xyes"], [AC_MSG_NOTICE([ARMv7 target])])])

# -------------------------- use all the settings ----------------------------

#
# we must add the optimization downgrade at the end of CFLAGS, as the compiler
# will get the flags in this order later on: $(AM_CFLAGS) $(CFLAGS)
# So, the "-O1" would always be overwritten, when we would add it to the AM_CFLAGS
#
AS_IF([test "x${enable_debug}" = "xyes"],
	[CFLAGS="${CFLAGS} -O1"
	AS_IF([test "x${enable_hide}" = "xyes"],
		[AC_MSG_NOTICE([Hiding library symbols disabled due to debugging enabled])])
	enable_hide=no
	AC_DEFINE(DEBUG, 1, [debugging])],
	[AC_DEFINE(NDEBUG, 1, [no debugging])])

AS_IF([test "${enable_profile}" = "yes"],
	[CC_CHECK_CFLAGS_SILENT([-pg], [], [enable_profile=no])
	CC_CHECK_LDFLAGS([-pg], [], [enable_profile=no])
#	still enabled?
	AS_IF([test "x${enable_profile}" = "xyes"],
		[AC_DEFINE(PROFILING, 1, [profiling])
		AM_CFLAGS="${AM_CFLAGS} -pg"
		AM_LDFLAGS="${AM_LDFLAGS} -pg"],
		[AC_MSG_NOTICE([Toolchain does not support profiling])])])

AS_IF([test "x${enable_coverage}" = "xyes"],
	[CC_CHECK_CFLAGS_SILENT([-fprofile-arcs -ftest-coverage], [], [enable_coverage=no])
	CC_CHECK_LDFLAGS([-lgcov], [], [enable_coverage=no])
#		still enabled?
	AS_IF([test "x${enable_coverage}" = "xyes"],
		[AC_DEFINE(COVERAGE, 1, [coverage])
			AM_CFLAGS="${AM_CFLAGS} -fprofile-arcs -ftest-coverage"
			AM_LDFLAGS="${AM_LDFLAGS} -lgcov"],
		[AC_MSG_NOTICE([Toolchain does not support coverage])])])

#
# Enable "-fvisibility=hidden" only if the used compiler supports it
#
AS_IF([test "x${enable_hide}" = "xyes"],
	[AC_MSG_CHECKING([whether the compiler supports -fvisibility=hidden])
	CC_CHECK_CFLAGS_SILENT([-fvisibility=hidden], [], [enable_hide=no])
#	still enabled?
	AS_IF([test "x${enable_hide}" = "xyes"],
		[AC_DEFINE(DSO_HIDDEN, 1, [hide internal library symbols])
			AM_CFLAGS="${AM_CFLAGS} -fvisibility=hidden"])
	AC_MSG_RESULT([${enable_hide}])
# TODO valid only for C++
#	CC_CHECK_CFLAGS_SILENT([-fvisibility-inlines-hidden], [enable_inline_hide=yes], [enable_inline_hide=no])
#	AS_IF([test "x${enable_inline_hide}" = "xyes"],
#		[AM_CFLAGS="${AM_CFLAGS} -fvisibility-inlines-hidden"])
	])

# ------------------------------- homework ------------------------------

#
# TODO this library provides a pkg config file
#
pkgconfigdir=${libdir}/pkgconfig
AC_SUBST(pkgconfigdir)

# substitute the settings valid for all source files
AC_SUBST(AM_CFLAGS)
AC_SUBST(AM_CPPFLAGS)
AC_SUBST(AM_LDFLAGS)

# add private libs to the pkg-config file
# 'private libs' are those required to link this library
# its used later on if someone wants to link this library statically
AC_SUBST(LIBS)

# add required lib information to the pkg-config file (on demand)
AC_SUBST(REQUIRES)

# add lib information which may conflicts with this libarry
AC_SUBST(CONFLICTS)

# add special compile flags on demand
AC_SUBST(PRIVATE_CFLAGS)

# be very silent on request
AM_CONDITIONAL(BUILD_SILENTLY, test "x$AM_DEFAULT_VERBOSITY" = x0)

AC_CONFIG_FILES([
	Makefile
	lib@name@.pc
])
AC_OUTPUT

AC_MSG_RESULT([
	------------------------------------------------------
	Configure results for: ${PACKAGE}
	------------------------------------------------------

	Release State:
	------------------------------------------------------
	 Library API release:	${API_RELEASE}
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
	 CPPFLAGS:		${AM_CPPFLAGS}
	 CFLAGS:		${AM_CFLAGS}
	 LDFLAGS:		${AM_LDFLAGS}
	 Hidden symbols		${enable_hide}
	 Coverage:		${enable_coverage}
	 Profiling:		${enable_profile}
	 Debug:			${enable_debug}
	 Private libs:		${LIBS}

	User options:
	------------------------------------------------------
	 CFLAGS:		${CFLAGS}
	 CPPFLAGS:		${CPPFLAGS}
	 LDFLAGS:		${LDFLAGS}

	Install options:
	------------------------------------------------------
	 prefix:		${prefix}
	 sysconfdir:		${sysconfdir}
	 libdir:		${libdir}
	 includedir:		${includedir}
	 bindir:		${bindir}
	 fast install:		${enable_fast_install}
])
