#!/bin/bash
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#


#
# figure out if we use a production or base BSP
#
# out:
# sysroot_base_platform
#
ptxd_init_get_sysroot_base_platform() {
    local prefix

    if prefix="$(ptxd_get_ptxconf PTXCONF_PROJECT_USE_PRODUCTION_PREFIX)"; then
	local platform
	if platform="$(ptxd_get_ptxconf PTXCONF_PLATFORM)"; then
	    local platform_version="$(ptxd_get_ptxconf PTXCONF_PLATFORM_VERSION)"
	    prefix="${prefix}/platform-${platform}${platform_version}"
	else
	    : # nothing to do for non-platform BSPs
	fi
    elif prefix="$(ptxd_get_ptxconf PTXCONF_PROJECT_USE_LOCAL_PLATFORM_NAME)"; then
	prefix="${PTXDIST_WORKSPACE}/${prefix}"
    else
	return
    fi

    # FIXME: HACK we hardcode "sysroot-target" here
    sysroot_base_platform="${prefix}/sysroot-target"

    if [ ! -d "${sysroot_base_platform}" ]; then
	ptxd_bailout "$(ptxd_print_path "${prefix}") is not a valid platform."
    fi

    PTXDIST_BASE_PLATFORMDIR="${prefix}"
    export PTXDIST_BASE_PLATFORMDIR
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
ptxd_init_ptxdist_path_sysroot() {
    local sysroot="$(ptxd_get_ptxconf PTXCONF_SYSROOT_TARGET)"
    local sysroot_prefix="${sysroot}:${sysroot}/usr"

    local sysroot_base_platform
    if ptxd_init_get_sysroot_base_platform; then
	sysroot="${sysroot}:${sysroot_base_platform}"
	sysroot_prefix="${sysroot_prefix}:${sysroot_base_platform}:${sysroot_base_platform}/usr"
    fi

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
#
#
ptxd_init_ptxdist_path() {
    PTXDIST_PATH="${PTXDIST_WORKSPACE}:${PTXDIST_PLATFORMCONFIGDIR}:${PTXDIST_TOPDIR}:"
    export PTXDIST_PATH

    PTXDIST_PATH_PATCHES="${PTXDIST_PATH//://patches:}"
    export PTXDIST_PATH_PATCHES

    PTXDIST_PATH_RULES="${PTXDIST_PATH//://rules:}"
    export PTXDIST_PATH_RULES

    PTXDIST_PATH_PRERULES="${PTXDIST_PATH_RULES//://pre:}"
    export PTXDIST_PATH_PRERULES

    PTXDIST_PATH_POSTRULES="${PTXDIST_PATH_RULES//://post:}"
    export PTXDIST_PATH_POSTRULES

    PTXDIST_PATH_PLATFORMS="${PTXDIST_PATH//://platforms:}"
    export PTXDIST_PATH_PLATFORMS

    PTXDIST_PATH_SCRIPTS="${PTXDIST_PATH//://scripts:}"
    export PTXDIST_PATH_SCRIPTS

    ptxd_init_ptxdist_path_sysroot
}


#
# initialize vars needed by PTXdist's libs
#
ptxd_lib_init() {
    ptxd_init_ptxdist_path
}
ptxd_lib_init

