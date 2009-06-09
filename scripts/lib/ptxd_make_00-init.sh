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
# figure out toolchain's sysroot
#
# link a programm and look at the compiler's output
#
# in:	$compiler_prefix
# out:	$PTXDIST_SYSROOT_TOOLCHAIN
#
ptxd_init_sysroot_toolchain_by_sysroot() {
    local sysroot

    sysroot="$(echo 'int main(void){return 0;}' | \
	${compiler_prefix}gcc -x c -o /dev/null -v - 2>&1 | \
	sed -ne "/.*collect2.*/s,.*--sysroot=\([^[:space:]]*\).*,\1,p")"

    test -n "${sysroot}" || return 1

    PTXDIST_SYSROOT_TOOLCHAIN="$(ptxd_abspath "${sysroot}")"
}


#
# figure out the toolchain's sysroot
#
# out:	PTXDIST_SYSROOT_TOOLCHAIN
#
ptxd_init_sysroot_toolchain() {
    local compiler_prefix="$(ptxd_get_ptxconf PTXCONF_COMPILER_PREFIX)"
    unset PTXDIST_SYSROOT_TOOLCHAIN

    ptxd_init_sysroot_toolchain_by_sysroot

    export PTXDIST_SYSROOT_TOOLCHAIN
}


#
# initialize some vars needed in PTXdist's make
#
ptxd_make_init() {
    ptxd_init_arch &&
    ptxd_init_sysroot_toolchain || return
}
ptxd_make_init
