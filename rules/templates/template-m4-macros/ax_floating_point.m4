#
# SYNOPSIS
#
#   AX_HARDWARE_FP([ACTION-IF-HARD-FLOAT],[ACTION-IF-SOFT-FLOAT])
#
# DESCRIPTION
#
#   AX_DETECT_FLOAT detects the compiler settings about floating point usage.
#   It is intended mostly for cross compiling to be able to collect more
#   information about the target architecture and features. The user can
#   overwrite the detection by using the option --enable-hardware-fp or
#   --disable-hardware-fp.
#   It works by detecting the compiler's macro __SOFTFP__. This one is set in
#   gcc compilers when there is no hardware floating point available.
#   This macro cannot detect the correct target's features if the compiler is
#   not correctly configured to reflect the target's features.
#
# LICENSE
#
#   Copyright (c) 2012 Juergen Borleis <jbe@pengutronix.de>
#
#   This program is free software; you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation; either version 2 of the License, or (at your
#   option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
#   Public License for more details.
#
#   You should have received a copy of the GNU General Public License along
#   with this program. If not, see <http://www.gnu.org/licenses/>.
#
#   As a special exception, the respective Autoconf Macro's copyright owner
#   gives unlimited permission to copy, distribute and modify the configure
#   scripts that are the output of Autoconf when processing the Macro. You
#   need not follow the terms of the GNU General Public License when using
#   or distributing such scripts, even though portions of the text of the
#   Macro appear in them. The GNU General Public License (GPL) does govern
#   all other use of the material that constitutes the Autoconf Macro.
#
#   This special exception to the GPL applies to versions of the Autoconf
#   Macro released by the Autoconf Archive. When you make and distribute a
#   modified version of the Autoconf Macro, you may extend this special
#   exception to the GPL to apply to your modified version as well.

AC_DEFUN([AX_HARDWARE_FP],
	[AC_REQUIRE([AC_PROG_CC])
dnl
dnl Give the user the possibility to overwrite the auto detection
dnl
	AC_ARG_ENABLE([hardware-fp],
		[AS_HELP_STRING([--enable-hardware-fp],
			[Enable hardware floating point @<:@default=auto@:>@])],
		[ax_hardware_fp="${enableval}"],
		[ax_hardware_fp=auto])

	AC_CACHE_CHECK([for hardware fp support], [ax_cv_hardware_fp],
		[ax_cv_hardware_fp=${ax_hardware_fp}])
dnl	AC_MSG_RESULT([${ax_cv_hardware_fp}])

	if test "x${ax_cv_hardware_fp}" = "xauto"; then
		if test "x$GCC" != "xyes"; then
dnl only for GCC we know it works in this way
			AC_MSG_ERROR([Cannot autodetect the hardware floating point feature for non GCC compilers])
		else
			AC_MSG_CHECKING(if hardware fp is supported)
			AC_COMPILE_IFELSE(
				[AC_LANG_PROGRAM([[]],
					[[
#define HARD_FP_SUPPORT 1
#if defined(__SOFTFP__)
# undef HARD_FP_SUPPORT
#endif
int foo = HARD_FP_SUPPORT;
					]]) dnl AC_LANG_PROGRAM
				],
				[ax_cv_hardware_fp=yes],
				[ax_cv_hardware_fp=no],
				[hardware FP support]); dnl AC_COMPILE_IFELSE
			AC_MSG_RESULT([${ax_cv_hardware_fp}]);
		fi
	fi

	case "x${ax_cv_hardware_fp}" in
	"xyes")
		$1
		;;
	"xno")
		$2
		;;
	*)
		AC_MSG_ERROR([Unknown setting for hardware floating point usage: '${ax_cv_hardware_fp}'.])
		;;
	esac
]) dnl AC_DEFUN
