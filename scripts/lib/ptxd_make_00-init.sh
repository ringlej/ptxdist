#!/bin/bash

#
# figure out arch string for ipkgs
#
# out:	$PTXDIST_IPKG_ARCH_STRING
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
    local sysroot

    sysroot="$(echo 'int main(void){return 0;}' | \
	${compiler_prefix}gcc -x c -o /dev/null -v - 2>&1 | \
	sed -ne "/.*collect2.*/s,.*--sysroot=\([^[:space:]]*\).*,\1,p" && \
	check_pipe_status)"

    if [ $? -ne 0 -o -z "${sysroot}" ]; then
	return 1
    fi

    PTXDIST_SYSROOT_TOOLCHAIN="$(ptxd_abspath "${sysroot}")" || return

    export PTXDIST_SYSROOT_TOOLCHAIN
}


#
# initialize some vars needed in PTXdist's make
#
ptxd_make_init() {
    ptxd_init_arch &&

    if ptxd_get_ptxconf PTXCONF_LIBC > /dev/null &&
	! ptxd_get_ptxconf PTXCONF_BUILD_TOOLCHAIN > /dev/null; then
	ptxd_init_sysroot_toolchain || return
    fi
}
ptxd_make_init
