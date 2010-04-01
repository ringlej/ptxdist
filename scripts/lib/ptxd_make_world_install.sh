#!/bin/bash
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# in:
# $echo		optional
# $fakeroot	optional
#
# FIXME: kick ${pkg_install_env}
#
ptxd_make_world_install_pkg() {
    local -a fakeargs
    #
    # fakeroot is a host pkg and
    # might not be available, yet
    #
    if ! eval "${pkg_path}" which fakeroot > /dev/null; then
	local echo="eval"
	local fakeroot="cat"
    fi &&

#    if [ -z "${fakeroot}" ]; then
#	fakeargs=( "-s" "${pkg_fake_env}" )
#    fi

    "${echo:-echo}" \
	"${pkg_path}" \
	"${pkg_env}" \
	"${pkg_make_env}" \
	"${pkg_install_env}" \
	"${MAKE}" \
	-C "${pkg_build_dir}" \
	"${pkg_install_opt}" \
	-j1 \
	| "${fakeroot:-fakeroot}" "${fakeargs[@]}" --
    check_pipe_status
}
export -f ptxd_make_world_install_pkg



#
# install
#
# Perform standard install actions
#
ptxd_make_world_install_target() {
    rm -rf -- "${pkg_pkg_dir}" &&
    mkdir -p -- "${pkg_pkg_dir}"/{etc,{,usr/}{lib,{,s}bin,include,{,share/}man/man{1,2,3,4,5,6,7,8,9}}} &&

    ptxd_make_world_install_pkg "${pkg_pkg_dir}" || return

    # remove empty dirs
    find "${pkg_pkg_dir}" -type d -print0 | xargs -r -0 -- \
	rmdir --ignore-fail-on-non-empty -p -- &&
    check_pipe_status &&

    if [ \! -e "${pkg_pkg_dir}" ]; then
	ptxd_warning "PKG didn't install anything to '${pkg_pkg_dir}'"
	return
    fi &&

    # make pkgconfig's pc files relocatable
    find "${pkg_pkg_dir}" -name "*.pc" -print0 | \
	xargs -r -0 gawk -f "${PTXDIST_LIB_DIR}/ptxd_make_world_install_mangle_pc.awk" &&
    check_pipe_status &&

    # prefix paths in la files with sysroot
    find "${pkg_pkg_dir}" -name "*.la" -print0 | xargs -r -0 -- \
	sed -i \
	-e "/^dependency_libs/s:\( \)\(/lib\|/usr/lib\):\1${pkg_sysroot_dir}\2:g" \
	-e "/^libdir=/s:\(libdir='\)\(/lib\|/usr/lib\):\1${pkg_sysroot_dir}\2:g" &&
    check_pipe_status &&

    cp -dprf -- "${pkg_pkg_dir}"/* "${pkg_sysroot_dir}" &&

    # copy *-config into sysroot_cross
    local config &&
    for config in $(find "${pkg_pkg_dir}" -name "${pkg_binconfig_glob}"); do
	cp -PR -- "${config}" "${PTXDIST_SYSROOT_CROSS}/bin" || return
    done
}
export -f ptxd_make_world_install_target


#
# generic "make install" function
#
ptxd_make_world_install() {
    ptxd_make_world_init &&

    case "${pkg_type}" in
	target) ptxd_make_world_install_target ;;
	*)      ptxd_make_world_install_pkg ;;
    esac
}
export -f ptxd_make_world_install
