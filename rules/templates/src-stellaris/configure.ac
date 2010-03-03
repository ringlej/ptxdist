AC_PREREQ(2.59)

esyscmd([echo "define(myversion, $(dir=$(basename $(pwd)); if test \"${dir%%-trunk}\" != \"$dir\"; then echo 99999999-9; else prefix=${dir%%-[0-9]*-[0-9]}; echo ${dir##$prefix-}; fi))"])

AC_INIT([@name@], myversion, [bugs@pengutronix.de])
AC_CONFIG_SRCDIR([@name@.c])
AC_CANONICAL_BUILD
AC_CANONICAL_HOST


PART=LM3S3748
CFLAGS="-mthumb -mcpu=cortex-m3"
CFLAGS="${CFLAGS} -ffunction-sections -fdata-sections"
CFLAGS="${CFLAGS} -MD -std=c99"
CFLAGS="${CFLAGS} -Wall -Wsign-compare -Wfloat-equal -Wformat-security"
CFLAGS="${CFLAGS} -pedantic -DPART_${PART}"


# workaround for newlib toolchain: place this before AC_PROG_CC, even if
# LDFLAGS are not AC_SUBSTed
LDFLAGS="-Wl,--entry -Wl,main -Wl,--gc-sections"
AC_CHECK_TOOLS([CC],[gcc cc])

AC_CHECK_TOOL(OBJCOPY,objcopy)

# find out about libs
AC_MSG_CHECKING([for libc])
LIBC_A=`${CC} -print-file-name=libc.a`
AC_MSG_RESULT([${LIBC_A}])
AC_MSG_CHECKING([for libgcc])
LIBGCC_A=`${CC} -print-file-name=libgcc.a`
AC_MSG_RESULT([${LIBGCC_A}])


#
# Debugging
#
AC_MSG_CHECKING([whether to enable debugging])
AC_ARG_ENABLE(debug,
    AS_HELP_STRING([--enable-debug], [enable debugging @<:@default=yes@:>@]),
	[case "$enableval" in
	y | yes) CONFIG_DEBUG=yes ;;
        *) CONFIG_DEBUG=no ;;
    esac],
    [CONFIG_DEBUG=yes]
)
AC_MSG_RESULT([${CONFIG_DEBUG}])
if test "${CONFIG_DEBUG}" = "yes"; then
    CFLAGS="${CFLAGS} -g -O1 -DDEBUG"
    AC_DEFINE(DEBUG, 1, [debugging])
else
    CFLAGS="${CFLAGS} -Werror -O2"
fi

#
# We need the stellaris SDK, for includes and libs
#
AC_ARG_WITH(stellaris_sdk,
    AS_HELP_STRING([--with-stellaris-sdk],[path to \(installed\) stellaris sdk]),
    [
	STELLARIS_SDK="$withval"
	AC_SUBST(STELLARIS_SDK)
	AC_MSG_NOTICE([Using stellaris sdk $STELLARIS_SDK])
    ],[
        AC_MSG_ERROR([Please specify the location of the stellaris sdk with the option '--with-stellaris-sdk'])
    ]
)

#
# If we want to make dfu files, check the tools
#
AC_MSG_CHECKING([for dfuwrap])
AC_ARG_WITH(dfuwrap,
    AS_HELP_STRING([--with-dfuwrap@<:@=path@:>@],[create dfu files with @<:@dfuwrap@:>@; default is 'dfuwrap']),
    [
        test "$withval" = "yes" && withval="dfuwrap"
        if test "$withval" = "no"; then
            withval=""
        fi
        dfuwrap=${withval}
    ],[
        dfuwrap=
    ]
)
DFUWRAP=""
if test -n "${dfuwrap}"; then
    AC_MSG_RESULT([${dfuwrap}])
    AC_PATH_PROG([DFUWRAP],${dfuwrap},[],[/:${PATH}])
    test -z "${DFUWRAP}" && AC_MSG_ERROR([dfuwrap='${dfuwrap}' does not exist])
else
    AC_MSG_RESULT([no])
fi


AC_SUBST(CC)
AC_SUBST(OBJCOPY)
AC_SUBST(CFLAGS)
AC_SUBST(LIBC_A)
AC_SUBST(LIBGCC_A)
AC_SUBST(DFUWRAP)

AC_CONFIG_FILES([
	Makefile
])
AC_OUTPUT

