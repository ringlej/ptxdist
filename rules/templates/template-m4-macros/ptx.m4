# SYNOPSIS
#
#   PTX_COMMON_CHECKS()
#   PTX_LIBRARY_CHECKS()
#   PTX_APPLICATION_CHECKS()
#
# DESCRIPTION
#
#   Does many useful checks which do no need to be done again and again in the
#   configure.ac file anymore.
#
#   PTX_COMMON_CHECKS()
#         Does common checks for libraries and programs
#   PTX_LIBRARY_CHECKS()
#         Does library specific checks wich makes no sense for programs
#   PTX_APPLICATION_CHECKS()
#         Does program specific checks wich makes no sense for libraries
#
#   Usage example:
#
#   configure.ac: (for a library project)
#
#   PTX_COMMON_CHECKS
#   PTX_LIBRARY_CHECKS
#
# LICENSE
#
#   Copyright (c) 2017 Juergen Borleis <jbe@pengutronix.de>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.  This file is offered as-is, without any
#   warranty.

# this function is derived from 'ax_add_fortify_source.m4'
# by Copyright (c) 2017 David Seifert <soap@gentoo.org>
AC_DEFUN([AX_TEST_FORTIFY_SOURCE],[
	AC_MSG_CHECKING([whether we can use '-D_FORTIFY_SOURCE=2'])
	AC_LINK_IFELSE([
		AC_LANG_SOURCE(
			[[
			int main(void);
			int main() {
			#ifndef _FORTIFY_SOURCE
				return 0;
			#else
				this_is_an_error;
			#endif
			}
			]]
	)], [
		ax_add_fortify_source=yes
		AX_ADD_FORTIFY_SOURCES="-D_FORTIFY_SOURCE=2"
	], [
		ax_add_fortify_source=no
	])
	AC_MSG_RESULT([${ax_add_fortify_source}])
])

AC_DEFUN([PTX_COMMON_CHECKS],[
# Debugging
	AC_MSG_CHECKING([whether to enable debugging])
	AC_ARG_ENABLE([debug],
		[AS_HELP_STRING([--enable-debug],
			[use debug compiler flags and macros @<:@default=disabled@:>@])],
		[],
		[enable_debug=no])
	AC_MSG_RESULT([${enable_debug}])

# severe failure handling
	AC_MSG_CHECKING([whether to enable abort() on failure])
	AC_ARG_ENABLE([abort],
		[AS_HELP_STRING([--enable-abort],
			[use abort() instead of exit() in hopeless conditions @<:@default=exit()@:>@])],
		[],
		[enable_abort=no])
	AC_MSG_RESULT([${enable_abort}])

# profile handling
	AC_MSG_CHECKING([whether to enable profiling support])
	AC_ARG_ENABLE([profile],
		[AS_HELP_STRING([--enable-profile],
			[allow profiling @<:@default=disabled@:>@])],
		[],
		[enable_profile=no])
	AC_MSG_RESULT([${enable_profile}])

# optimisation handling
	AC_MSG_CHECKING([which optimisation goal to be used])
	AC_ARG_WITH([goal],
		[AS_HELP_STRING([--with-goal[=goal]], [define @<:@secure@:>@ or @<:@speed@:>@ as the goal for optimisation @<:@default=secure@:>@])],
		[],
		[with_goal=secure])
	AC_MSG_RESULT([${with_goal}])
#
# Check for coverage support
# refer 'ax_code_coverage.m4' for details how to make use of it.
	AX_CODE_COVERAGE
#
# check for some useful compiler attribute features
	CC_ATTRIBUTE_FORMAT
	CC_ATTRIBUTE_FORMAT_ARG
	CC_ATTRIBUTE_NONNULL
	CC_ATTRIBUTE_UNUSED
	CC_ATTRIBUTE_PACKED
	CC_ATTRIBUTE_CONST
	CC_ATTRIBUTE_PURE
	CC_ATTRIBUTE_NORETURN
	CC_ATTRIBUTE_CLEANUP
	CC_ATTRIBUTE_DEPRECATED
#
# add useful switches according the used compiler's capabilities
	CC_CHECK_CFLAG_APPEND([-pipe])
#
# add as much warnings as possible
	CC_CHECK_CFLAG_APPEND([-W])
	CC_CHECK_CFLAG_APPEND([-Wall])
	CC_CHECK_CFLAG_APPEND([-Wextra])
	CC_CHECK_CFLAG_APPEND([-Wsign-compare])
	CC_CHECK_CFLAG_APPEND([-Wfloat-equal])
	CC_CHECK_CFLAG_APPEND([-Wformat-security])
	CC_CHECK_CFLAG_APPEND([-Wno-unused-parameter])
	CC_CHECK_CFLAG_APPEND([-Wstrict-prototypes])
	CC_CHECK_CFLAG_APPEND([-Wpointer-arith])
	CC_CHECK_CFLAG_APPEND([-Wnonnull])
#
# Add only those libraries which are really used
# This option must be listed *before* all libraries.
	CC_CHECK_LDFLAGS([-Wl,--as-needed], [LDFLAGS="${LDFLAGS} -Wl,--as-needed"],[])
#
# support recent distributions
	CC_CHECK_LDFLAGS([-Wl,--build-id=sha1], [LDFLAGS="${LDFLAGS} -Wl,--build-id=sha1"],[])
#
# Does the linker supports "--no-undefined"?
	CC_NOUNDEFINED
#
# check if we can add fortify support
	AX_TEST_FORTIFY_SOURCE
#
# if coverage is enabled, their macro defines NDEBUG. So disable debugging for this case.
# Note that all optimisation flags in CFLAGS must be disabled when code
# coverage is enabled.
	AC_MSG_CHECKING([if code coverage is enabled])
	AS_IF([test "${enable_code_coverage}" = "yes"],[
		enable_debug=no
		CFLAGS=${CFLAGS/-O2/}
		AC_MSG_RESULT([yes, debugging disabled due to enabled coverage])
	],[
		AC_MSG_RESULT([no])
	])

	AS_IF([test "${enable_debug}" = "yes"], [
# remove automagically added parameters by the autotools
		CFLAGS=${CFLAGS/-O2/}
		CFLAGS=${CFLAGS/-g/}
#
# all kind of optimisation makes debugging much harder, so disable it entirely
		CC_CHECK_CFLAGS([-Og], [CFLAGS="${CFLAGS} -Og"], [CFLAGS="${CFLAGS} -O0"])
		CC_CHECK_CFLAG_APPEND([-frecord-gcc-switches])
		CC_CHECK_CFLAG_APPEND([-fno-inline])
		CC_CHECK_CFLAG_APPEND([-fno-builtin])
		CC_CHECK_CFLAG_APPEND([-funwind-tables])
#
# in order to make backtrace_symbols() work, add the "-rdynamic" option
# according to the man page.
		CC_CHECK_LDFLAGS([-rdynamic], [LDFLAGS="${LDFLAGS} -rdynamic"])
		CFLAGS="${CFLAGS} -ggdb3"
		AC_DEFINE(DEBUG, 1, [debugging])
	],[
		CC_CHECK_CFLAG_APPEND([-Winline])
		AC_DEFINE(NDEBUG, 1, [no debugging])
	])
#
# if we want a more secure build:
# - disable built-ins (to make fortify better)
# - enable fortify
# - enable stack protector
	AS_IF([test "${with_goal}" = "secure" -a "${enable_debug}" = "no"], [
		CPPFLAGS="${CPPFLAGS} ${AX_ADD_FORTIFY_SOURCES}"
		CC_CHECK_CFLAG_APPEND([-fno-builtin])
	])

	AS_IF([test "${enable_profile}" = "yes"], [
		CC_CHECK_CFLAGS_SILENT([-pg], [], [enable_profile=no])
		CC_CHECK_LDFLAGS([-pg], [], [enable_profile=no])
		# still enabled?
		AS_IF([test "x${enable_profile}" = "xyes"],
			[AC_DEFINE(PROFILING, 1, [profiling])
			CFLAGS="${CFLAGS} -pg"
			LDFLAGS="${LDFLAGS} -pg"],
			[AC_MSG_NOTICE([Toolchain does not support profiling])])
	])

	AS_IF([test "${with_goal}" = "secure" -o "${enable_debug}" = "yes"],
		[CC_CHECK_CFLAGS([-fstack-protector-strong],
			[CFLAGS="${CFLAGS} -fstack-protector-strong"],
			[CC_CHECK_CFLAGS([-fstack-protector-all],
				[CFLAGS="${CFLAGS} -fstack-protector-all"],
				CC_CHECK_CFLAGS([-fstack-protector],
					[CFLAGS="${CFLAGS} -fstack-protector"]))])
	],[
		CC_CHECK_CFLAGS_APPEND([-fno-stack-protector])
	])

	AC_MSG_CHECKING([if abort() instead of exit() should be used])
	AS_IF([test "${enable_abort}" = "yes"],[
		AC_MSG_RESULT([yes])
		AC_DEFINE(LIBCAPS_SIMPLY_EXIT, 0, [use abort()])
	],[
		AC_MSG_RESULT([no])
		AC_DEFINE(LIBCAPS_SIMPLY_EXIT, 1, [use exit()])
	])
])

#
# Checks for library packages
AC_DEFUN([PTX_LIBRARY_CHECKS],[

	CC_ATTRIBUTE_VISIBILITY(default)
#
# should the library export all symbols?
	AC_MSG_CHECKING([whether to hide internal symbols])
	AC_ARG_ENABLE([hide],
		[AS_HELP_STRING([--disable-hide],
			[export all internal library symbols @<:@default=hide@:>@])],
		[],
		[enable_hide=yes]
	)

	AS_IF([test ${enable_debug} = "yes"],
		[AC_MSG_RESULT([no (due to debug enabled)])
		enable_hide=no
	],[
		AC_MSG_RESULT([${enable_hide}])
	])

# Enable "-fvisibility=hidden" only if the used gcc supports it
	AS_IF([test "${enable_hide}" = "yes"],
		[CC_CHECK_CFLAGS([-fvisibility=hidden], [], [enable_hide=no])
		AS_IF([test "${enable_hide}" = "yes"],
			[AC_DEFINE(DSO_HIDDEN, 1, [hide internal library symbols])
			CFLAGS="${CFLAGS} -fvisibility=hidden"
		])
	])
])

AC_DEFUN([PTX_APPLICATION_CHECKS],[
])

