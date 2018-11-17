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
		arm-*gnueabihf|armle*gnueabihf|armel*gnueabihf)
		    ipkg_arch=armhf
		    ;;
		*)
		    ipkg_arch=arm
		    ;;
	    esac
	    ;;
    esac

    PTXDIST_IPKG_ARCH_STRING="${ipkg_arch}"

    export PTXDIST_IPKG_ARCH_STRING
}

#
# run cross-gcc with flags
#
ptxd_cross_cc() {
    local compiler_prefix extra_cppflags extra_cflags
    compiler_prefix="$(ptxd_get_ptxconf PTXCONF_COMPILER_PREFIX)"
    extra_cppflags="$(ptxd_get_ptxconf PTXCONF_TARGET_EXTRA_CPPFLAGS)"
    extra_cflags="$(ptxd_get_ptxconf PTXCONF_TARGET_EXTRA_CFLAGS)"

    ${compiler_prefix}gcc ${extra_cppflags} ${extra_cflags} "${@}"
}
export -f ptxd_cross_cc

#
# run cross-gcc with flags and -v
#
ptxd_cross_cc_v() {
    local cache="${PTXDIST_TEMPDIR}/ptxd_cross_cc_v"
    if [ -e "${cache}" ]; then
	cat "${cache}"
    else
	local tmp="$(mktemp "${cache}.XXXXXX")"
	echo 'int main(void){return 0;}' | \
	ptxd_cross_cc -x c -o /dev/null -v - 2>&1 | tee "${tmp}"
	mv "${tmp}" "${cache}"
    fi
}
export -f ptxd_cross_cc_v

#
# out: dynamic linker name
#
ptxd_get_dl() {
    local dl

    dl="$(ptxd_cross_cc_v | \
	sed -n -e 's/.* -dynamic-linker \([^ ]*\).*/\1/p')"

    echo "${dl##*/}"
}
export -f ptxd_get_dl

#
# figure out the toolchain's sysroot
#
# out:	PTXDIST_SYSROOT_TOOLCHAIN
#
ptxd_init_sysroot_toolchain() {
    #
    # no compiler prefix specified means using plain "gcc"
    # which comes from the distribution, so no sysroot here
    #
    local compiler_prefix="$(ptxd_get_ptxconf PTXCONF_COMPILER_PREFIX)"
    if [ -z "${compiler_prefix}" ]; then
	PTXDIST_SYSROOT_TOOLCHAIN="/"
    else
	local sysroot

	sysroot="$(ptxd_cross_cc -print-sysroot 2> /dev/null)" &&
	    [ -n "${sysroot}" ] ||
	sysroot="$(ptxd_cross_cc_v | \
	sed -ne "/.*collect2.*/s,.*--sysroot=\([^[:space:]]*\).*,\1,p" && \
	    check_pipe_status)" &&
	    [ -n "${sysroot}" ] ||
	sysroot="$(ptxd_lib_sysroot \
	    "$(ptxd_cross_cc -print-file-name=libc.so 2> /dev/null)")"

	if [ $? -ne 0 -o -z "${sysroot}" ]; then
	    ptxd_bailout "Could not detect toolchain sysroot! The toolchain is broken or not configured correctly."
	fi

	PTXDIST_SYSROOT_TOOLCHAIN="$(ptxd_abspath "${sysroot}")" || return
    fi

    export PTXDIST_SYSROOT_TOOLCHAIN
}


#
# gather all sysroots
#
# in:
# PTXDIST_SYSROOT_TOOLCHAIN
#
# out:
# PTXDIST_PATH_SYSROOT			additional sysroots (without toolchain)
# PTXDIST_PATH_SYSROOT_ALL		all sysroots (including toolchain)
# PTXDIST_PATH_SYSROOT_PREFIX		prefixes (/, /usr) of additional sysroots (without toolchain)
# PTXDIST_PATH_SYSROOT_PREFIX_ALL	prefixes (/, /usr) of all sysroots (including toolchain)
#
ptxd_init_ptxdist_path_sysroot() {
    local sysroot="$(ptxd_get_ptxconf PTXCONF_SYSROOT_TARGET)"
    local sysroot_prefix="${sysroot}:${sysroot}/usr"

    local sysroot_all="${sysroot}"
    local sysroot_prefix_all="${sysroot_prefix}"
    if [ -n "${PTXDIST_SYSROOT_TOOLCHAIN}" ]; then
	sysroot_all="${sysroot_all}:${PTXDIST_SYSROOT_TOOLCHAIN}"
	sysroot_prefix_all="${sysroot_prefix}:${PTXDIST_SYSROOT_TOOLCHAIN}:${PTXDIST_SYSROOT_TOOLCHAIN}/usr"
    fi

    export \
	PTXDIST_PATH_SYSROOT="${sysroot}" \
	PTXDIST_PATH_SYSROOT_ALL="${sysroot_all}" \
	PTXDIST_PATH_SYSROOT_PREFIX="${sysroot_prefix}" \
	PTXDIST_PATH_SYSROOT_PREFIX_ALL="${sysroot_prefix_all}"
}


#
# get host sysroot
#
# out:
# PTXDIST_PATH_SYSROOT_HOST		sysroot
# PTXDIST_PATH_SYSROOT_HOST_PREFIX	prefixes (/) of sysroot
#
ptxd_init_ptxdist_path_sysroot_host() {
    local sysroot="$(ptxd_get_ptxconf PTXCONF_SYSROOT_HOST)"

    export \
	PTXDIST_PATH_SYSROOT_HOST="${sysroot}" \
	PTXDIST_PATH_SYSROOT_HOST_PREFIX="${sysroot}"
}


#
# out: 'lib' or 'lib64', derived from the ld-{linux,uClibc}.so.? from the compiler toolchain
#
ptxd_get_lib_dir() {
    local dl lib_dir

    dl="$(ptxd_cross_cc_v | \
	sed -n -e 's/.* -dynamic-linker \([^ ]*\).*/\1/p')"
    lib_dir="${dl%%/ld*.so.*}"
    echo "${lib_dir#/}"
}
export -f ptxd_get_lib_dir

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
#
ptxd_init_cross_env() {

    ######## CPP_FLAGS, LDFLAGS ########

    local orig_IFS="${IFS}"
    IFS=":"
    local -a prefix
    prefix=( ${PTXDIST_PATH_SYSROOT_PREFIX} )
    IFS="${orig_IFS}"

    local -a lib_dir
    lib_dir=$(ptxd_get_lib_dir)

    # add "-isystem <DIR>/include"
    local -a cppflags
    cppflags=( "${prefix[@]/%//include}" )
    cppflags=( "${cppflags[@]/#/-isystem }" )

    # add "-L<DIR>/lib -Wl,-rpath-link -Wl,<DIR>"
    local -a ldflags
    ldflags=( "${prefix[@]/%//${lib_dir}}" )
    ldflags=( "${ldflags[@]/#/-B}" "${ldflags[@]/#/-Wl,-rpath-link -Wl,}" )

    export \
	PTXDIST_CROSS_CPPFLAGS="${cppflags[*]}" \
	PTXDIST_CROSS_LDFLAGS="${ldflags[*]}"
}

#
# setup compiler and pkgconfig environment
#
# in:
# ${PTXDIST_PATH_SYSROOT_HOST}
#
#
# out:
# PTXDIST_HOST_CPPFLAGS			CPPFLAGS for host packages
# PTXDIST_HOST_LDFLAGS			LDFLAGS for host packages
#
ptxd_init_host_env() {
    ######## CPPFLAGS, LDFLAGS ########
    local orig_IFS="${IFS}"
    IFS=":"
    local -a prefix
    prefix=( ${PTXDIST_PATH_SYSROOT_HOST_PREFIX} )
    IFS="${orig_IFS}"

    local -a lib_dir
    lib_dir=lib

    # add "-isystem <DIR>/include"
    local -a cppflags
    cppflags=( "${prefix[@]/%//include}" )
    cppflags=( "${cppflags[@]/#/-isystem }" )

    # add "-L<DIR>/lib -Wl,-rpath-link -Wl,<DIR>"
    local -a ldflags
    ldflags=( "${prefix[@]/%//${lib_dir}}" )
    ldflags=( \
	"${ldflags[@]/#/-B}" \
	"${ldflags[@]/#/-Wl,-rpath -Wl,}" \
	'-Wl,-rpath,$ORIGIN/../lib:/with/some/extra/space'
    )

    export \
	PTXDIST_HOST_CPPFLAGS="${cppflags[*]}" \
	PTXDIST_HOST_LDFLAGS="${ldflags[*]}"
}

ptxd_init_devpkg()
{
    local prefix
    local -a path

    prefix="$(ptxd_get_ptxconf PTXCONF_PROJECT_DEVPKGDIR)" || return 0

    local platform platform_version
    platform="$(ptxd_get_ptxconf PTXCONF_PLATFORM)"
    platform_version="$(ptxd_get_ptxconf PTXCONF_PLATFORM_VERSION)"

    if [ -n "${platform}" ]; then
	path[${#path[@]}]="${prefix}/platform-${platform}${platform_version}"
	path[${#path[@]}]="${prefix}/platform-${platform}/packages"
    fi
    path[${#path[@]}]="${prefix}/packages"
    path[${#path[@]}]="${prefix}"

    if ! ptxd_get_path "${path[@]}"; then
	ptxd_warning "No dev packages found in '$(ptxd_print_path "${prefix}")'"
    fi
    if [ "${PKGDIR}" = "${ptxd_reply}" ]; then
	# don't my own packages. The timestamps mess up the dependencies.
	return
    fi

    PTXDIST_DEVPKG_PLATFORMDIR="${ptxd_reply}"
    export PTXDIST_DEVPKG_PLATFORMDIR
}

ptxd_init_save_wrapper_env() {
    local sysroot="$(ptxd_get_ptxconf PTXCONF_SYSROOT_HOST)"

    if [ ! -d "${sysroot}/lib/wrapper/" ]; then
	return
    fi
    cat > ${sysroot}/lib/wrapper/env <<- EOF
	PTXDIST_PLATFORMCONFIG="${PTXDIST_PLATFORMCONFIG}"
	PTXDIST_CROSS_CPPFLAGS="${PTXDIST_CROSS_CPPFLAGS}"
	PTXDIST_CROSS_LDFLAGS="${PTXDIST_CROSS_LDFLAGS}"
	PTXDIST_HOST_CPPFLAGS="${PTXDIST_HOST_CPPFLAGS}"
	PTXDIST_HOST_LDFLAGS="${PTXDIST_HOST_LDFLAGS}"
	PTXDIST_PLATFORMDIR="${PTXDIST_PLATFORMDIR}"
	EOF
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

    ptxd_init_ptxdist_path_sysroot &&
    ptxd_init_ptxdist_path_sysroot_host &&

    ptxd_init_devpkg &&

    ptxd_init_cross_env &&
    ptxd_init_host_env &&
    ptxd_init_save_wrapper_env
}
ptxd_make_init
