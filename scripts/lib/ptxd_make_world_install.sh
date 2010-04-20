#!/bin/bash
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# prepare
#
# create pkg_pkg_dir and typical subdirs if pkg_pkg_dir is defined
#
ptxd_make_world_install_prepare() {
    ptxd_make_world_init &&

    if [ -z "${pkg_pkg_dir}" ]; then
	return
    fi &&
    rm -rf -- "${pkg_pkg_dir}" &&
    mkdir -p -- "${pkg_pkg_dir}"/{etc,{,usr/}{lib,{,s}bin,include,{,share/}man/man{1,2,3,4,5,6,7,8,9}}}
}
export -f ptxd_make_world_install_prepare

#
# FIXME: kick ${pkg_install_env}
#
ptxd_make_world_install() {
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

    ptxd_make_world_install_prepare &&

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
export -f ptxd_make_world_install

#
# unpack
#
# unpack the dev tarball to pkg_pkg_dir
#
ptxd_make_world_install_unpack() {
    local pkg_prefix

    ptxd_make_world_init &&

    case "${pkg_type}" in
	host|cross) pkg_prefix="${pkg_type}-" ;;
	*)          pkg_prefix="" ;;
    esac &&

    if [ \! -e "${ptx_pkg_dev_dir}/${pkg_pkg_dev}" ]; then
	ptxd_bailout "Internal error: '$(ptxd_print_path ${ptx_pkg_dev_dir}/${pkg_pkg_dev})' does not exist."
    fi &&
    rm -rf -- "${pkg_pkg_dir}" &&
    mkdir -p -- "${ptx_pkg_dir}" &&
    tar -x -C "${ptx_pkg_dir}" -z -f "${ptx_pkg_dev_dir}/${pkg_pkg_dev}"
}
export -f ptxd_make_world_install_unpack

#
# pack
#
# pack the dev tarball from pkg_pkg_dir
#
ptxd_make_world_install_pack() {
    ptxd_make_world_init &&

    # remove empty dirs
    test \! -e "${pkg_pkg_dir}" || \
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

    if [ "${pkg_pkg_dev}" != "NO" -a "$(ptxd_get_ptxconf PTXCONF_PROJECT_CREATE_DEVPKGS)" = "y" ]; then
	tar -c -C "${ptx_pkg_dir}" -z -f "${ptx_pkg_dir}/${pkg_pkg_dev}" "${pkg_pkg_dir##*/}"
    fi
}
export -f ptxd_make_world_install_pack

#
# post
#
# cleanup an copy to sysroot
#
ptxd_make_world_install_post() {
    ptxd_make_world_init &&
    # do nothing if pkg_pkg_dir does not exist
    if [ \! -d "${pkg_pkg_dir}" ]; then
	return
    fi &&
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
export -f ptxd_make_world_install_post
