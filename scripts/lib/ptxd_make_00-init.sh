#!/bin/bash
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# figure out arch string for ipkgs
#
# out:	PTXDIST_IPKG_ARCH_STRING
#
ptxd_init_arch() {
    local ptx_arch="$(ptxd_get_ptxconf PTXCONF_ARCH_STRING)"
    local ipkg_arch="${ptx_arch}"

    case "${ptx_arch}" in
	arm)
	    local target="$(ptxd_get_ptxconf PTXCONF_GNU_TARGET)"

	    case "${target}" in
		armb*gnueabi|armeb*gnueabi)
		    ipkg_arch=armeb
		    ;;
		arm-*gnueabi|armle*gnueabi|armel*gnueabi)
		    ipkg_arch=armel
		    ;;
		*)
		    ipkg_arch=arm
		    ;;
	    esac
    esac

    PTXDIST_IPKG_ARCH_STRING="${ipkg_arch}"

    export PTXDIST_IPKG_ARCH_STRING
}


#
# figure out the toolchain's sysroot
#
# out:	PTXDIST_SYSROOT_TOOLCHAIN
#
ptxd_init_sysroot_toolchain() {
    local compiler_prefix="$(ptxd_get_ptxconf PTXCONF_COMPILER_PREFIX)"

    #
    # no compiler prefix specified means using plain "gcc"
    # which comes from the distribution, so no sysroot here
    #
    if [ -z "${compiler_prefix}" ]; then
	PTXDIST_SYSROOT_TOOLCHAIN="/"
    else
	local sysroot

	sysroot="$(echo 'int main(void){return 0;}' | \
	${compiler_prefix}gcc -x c -o /dev/null -v - 2>&1 | \
	sed -ne "/.*collect2.*/s,.*--sysroot=\([^[:space:]]*\).*,\1,p" && \
	check_pipe_status)"

	if [ $? -ne 0 -o -z "${sysroot}" ]; then
	    return 1
	fi

	PTXDIST_SYSROOT_TOOLCHAIN="$(ptxd_abspath "${sysroot}")" || return
    fi

    export PTXDIST_SYSROOT_TOOLCHAIN
}



#
# figure out if we use a production BSP
#
# out:
# sysroot_production
#
ptxd_init_get_sysroot_production() {
    local prefix

    prefix="$(ptxd_get_ptxconf PTXCONF_PROJECT_USE_PRODUCTION_PREFIX)" || return

    local platform platform_version
    platform="$(ptxd_get_ptxconf PTXCONF_PLATFORM)"
    platform_version="$(ptxd_get_ptxconf PTXCONF_PLATFORM_VERSION)"

    if [ -n "${platform}" ]; then
	prefix="${prefix}/platform-${platform}${platform_version}"
    else
	: # nothing to do for non-platform BSPs
    fi

    # FIXME: HACK we hardcode "sysroot-target" here
    sysroot_production="${prefix}/sysroot-target"

    PTXDIST_PROD_PLATFORMDIR="${prefix}"
    export PTXDIST_PROD_PLATFORMDIR
}



#
# gather all sysroots
#
# out:
# PTXDIST_PATH_SYSROOT			additional sysroots (without toolchain)
# PTXDIST_PATH_SYSROOT_ALL		all sysroots (including toolchain)
# PTXDIST_PATH_SYSROOT_PREFIX		prefixes (/, /usr) of additional sysroots (without toolchain)
# PTXDIST_PATH_SYSROOT_PREFIX_ALL	prefixes (/, /usr) of all sysroots (including toolchain)
#
ptxd_init_ptxdist_path() {
    local sysroot="$(ptxd_get_ptxconf PTXCONF_SYSROOT_TARGET)"
    local sysroot_prefix="${sysroot}:${sysroot}/usr"

    local sysroot_production
    if ptxd_init_get_sysroot_production; then
	sysroot="${sysroot}:${sysroot_production}"
	sysroot_prefix="${sysroot_prefix}:${sysroot_production}:${sysroot_production}/usr"
    fi

    local sysroot_all="${sysroot}"
    local sysroot_prefix_all="${sysroot_prefix}"
    if [ -n "${PTXDIST_SYSROOT_TOOLCHAIN}" ]; then
	sysroot_all="${sysroot_all}:${PTXDIST_SYSROOT_TOOLCHAIN}"
	sysroot_prefix_all="${sysroot_prefix}:${PTXDIST_SYSROOT_TOOLCHAIN}:${PTXDIST_SYSROOT_TOOLCHAIN}/usr"
    fi

    export \
	PTXDIST_PATH_SYSROOT="${sysroot}" \
	PTXDIST_PATH_SYSROOT_ALL="${sysroot_all}"
	PTXDIST_PATH_SYSROOT_PREFIX="${sysroot_prefix}" \
	PTXDIST_PATH_SYSROOT_PREFIX_ALL="${sysroot_prefix_all}"
}



#
# setup compiler and pkgconfig environment
#
# in:
# ${PTXDIST_PATH_SYSROOT_PREFIX}
#
#
# out:
# PTXDIST_CROSS_CPPFLAGS		CPPFLAGS for cross-compiled packages
# PTXDIST_CROSS_LDFLAGS			LDFLAGS for cross-compiled packages
# PTXDIST_CROSS_ENV_PKG_CONFIG		PKG_CONFIG_* environemnt for cross pkg-config
#
ptxd_init_cross_env() {

    ######## CPP_FLAGS, LDFLAGS ########

    local orig_IFS="${IFS}"
    IFS=":"
    local -a prefix=( ${PTXDIST_PATH_SYSROOT_PREFIX} )
    IFS="${orig_IFS}"

    # add "-isystem <DIR>/include"
    local -a cppflags
    cppflags=( "${prefix[@]/%//include}" )
    cppflags=( "${cppflags[@]/#/-isystem }" )

    # add "-L<DIR>/lib -Wl,-rpath-link -Wl,<DIR>"
    local -a ldflags
    ldflags=( "${prefix[@]/%//lib}" )
    ldflags=( "${ldflags[@]/#/-L}" "${ldflags[@]/#/-Wl,-rpath-link -Wl,}" )

    export \
	PTXDIST_CROSS_CPPFLAGS="${cppflags[*]}" \
	PTXDIST_CROSS_LDFLAGS="${ldflags[*]}"



    ######## PKG_CONFIG_LIBDIR, PKG_CONFIG_PATH ########

    #
    # PKG_CONFIG_LIBDIR contains the default pkg-config search
    # directories. Set it to the last two components of
    # PTXDIST_PATH_SYSROOT_PREFIX. Which is allways searched last.
    #
    # PKG_CONFIG_PATH contains additional pkg-config search
    # directories, all remaining components of
    # PTXDIST_PATH_SYSROOT_PREFIX are added to this. It's searched
    # before searching the path specified in _LIBDIR
    #

    # add <DIR>/lib/pkgconfig
    local -a pkg_path=( "${prefix[@]/%//lib/pkgconfig}" )

    #
    # if we have additional pkg_config_path defined in our ptxconfig
    # prefix them with sysroot and add to pkg_path, too.
    #
    # FIXME: we only take care of normal sysroot for now, no support
    #        for production releases, though.
    #
    local -a opt_pkg_path
    if opt_pkg_path=( $(ptxd_get_ptxconf PTXCONF_PKG_CONFIG_PATH) ); then
	IFS=":"
	local -a sysroot=( ${PTXDIST_PATH_SYSROOT} )
	IFS="${orig_IFS}"

	pkg_path=( "${opt_pkg_path[@]/#/${sysroot[0]}}" "${pkg_path[@]}" )
    fi

    # last two go into pkg_libdir, the rest stays in pkg_path
    local -i n=${#pkg_path[@]}
    local -i n1=$(( --n ))
    local -i n2=$(( --n ))
    local -a pkg_libdir=( "${pkg_path[n2]}" "${pkg_path[n1]}" )

    # remove last two
    unset pkg_path[n2] pkg_path[n1]

    IFS=":"
    export PTXDIST_CROSS_ENV_PKG_CONFIG="PKG_CONFIG_PATH='${pkg_path[*]}' PKG_CONFIG_LIBDIR='${pkg_libdir[*]}'"
    IFS="${orig_ifs}"
}


#
# initialize vars needed by PTXdist's make
#
ptxd_make_init() {
    ptxd_init_arch &&

    if ptxd_get_ptxconf PTXCONF_LIBC > /dev/null &&
	! ptxd_get_ptxconf PTXCONF_BUILD_TOOLCHAIN > /dev/null; then
	ptxd_init_sysroot_toolchain || return
    fi &&

    ptxd_init_ptxdist_path &&
    ptxd_init_cross_env
}
ptxd_make_init
