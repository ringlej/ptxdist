#!/bin/bash

ptxd_install_init() {
    local ptx_arch="$(ptxd_get_ptxconf PTXCONF_ARCH_STRING)"
    local ipkg_arch="ptx_arch"

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

ptxd_install_init
