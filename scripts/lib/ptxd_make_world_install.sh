#!/bin/bash
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# $1:	destdir
#
# in:
# $echo		optional
# $fakeroot	optional
#
# FIXME: kick ${pkg_install_env}
#
ptxd_make_world_install_pkg() {
    "${echo:-echo}" \
	"${pkg_path}" \
	"${pkg_env}" \
	"${pkg_make_env}" \
	"${pkg_install_env}" \
	"${MAKE}" \
	-C "${pkg_build_dir}" \
	"${pkg_install_opt}" \
	install -j1 \
	DESTDIR="${1}" | "${fakeroot:-fakeroot}" --
    check_pipe_status
}
export -f ptxd_make_world_install_pkg



#
# install
#
# Perform standard install actions
#
ptxd_make_world_install_target() {
    rm -rf -- "${pkg_pkgdir}" &&
    mkdir -p -- "${pkg_pkgdir}"/{etc,{,usr/}{lib,{,s}bin,include,{,share/}man/man{1,2,3,4,5,6,7,8,9}}} &&

    ptxd_make_world_install_pkg "${pkg_pkgdir}" || return

    # remove empty dirs
    find "${pkg_pkgdir}" -type d -print0 | xargs -r -0 -- \
	rmdir --ignore-fail-on-non-empty -p -- &&
    check_pipe_status &&

    if [ \! -e "${pkg_pkgdir}" ]; then
	ptxd_warning "PKG doesn't install anything to '${pkg_pkgdir}'"
	return
    fi &&

    # prefix paths in la files with sysroot
    find "${pkg_pkgdir}" -name "*.la" -print0 | xargs -r -0 -- \
	sed -i \
	-e "/^dependency_libs/s:\( \)\(/lib\|/usr/lib\):\1${PTXDIST_SYSROOT_TARGET}\2:g" \
	-e "/^libdir=/s:\(libdir='\)\(/lib\|/usr/lib\):\1${PTXDIST_SYSROOT_TARGET}\2:g" &&
    check_pipe_status &&

    # make pkgconfig's pc files relocatable
    find "${pkg_pkgdir}" -name "*.pc" -print0 | \
	xargs -r -0 gawk -f "${PTXDIST_LIB_DIR}/ptxd_make_world_install_mangle_pc.awk"
    check_pipe_status &&

    cp -dprf -- "${pkg_pkgdir}"/* "${PTXDIST_SYSROOT_TARGET}"
}
export -f ptxd_make_world_install_target


#
# for cross pkg
#
ptxd_make_world_install_cross() {
    ptxd_make_world_install_pkg
}
export -f ptxd_make_world_install_cross


#
# for host pkgs
#
ptxd_make_world_install_host() {
    #
    # fakeroot is a host pkg and
    # might not be available, yet
    #
    local echo="eval"
    local fakeroot="cat"

    ptxd_make_world_install_pkg
}
export -f ptxd_make_world_install_host


#
# generic "make install" function
#
ptxd_make_world_install() {
    ptxd_make_world_init &&
    ptxd_make_world_install_"${pkg_type}"
}
export -f ptxd_make_world_install
