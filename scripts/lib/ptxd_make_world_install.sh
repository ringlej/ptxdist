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
    if [ -z "${pkg_pkg_dir}" ]; then
	return
    fi &&
    rm -rf -- "${pkg_pkg_dir}" &&
    mkdir -p -- "${pkg_pkg_dir}"/{etc,{,usr/}{lib,{,s}bin,include,{,share/}{man/man{1,2,3,4,5,6,7,8,9},misc}}}
}
export -f ptxd_make_world_install_prepare

#
# FIXME: kick ${pkg_install_env}
#
ptxd_make_world_install() {
    local -a fakeargs

    ptxd_make_world_init &&

    if [ -z "${pkg_build_dir}" ]; then
	# no build dir -> assume the package has nothing to install.
	return
    fi &&
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
    tar -x -C "${ptx_pkg_dir}" -z -f "${ptx_pkg_dev_dir}/${pkg_pkg_dev}" &&

    # fix rpaths in host/cross tools
    if [ "${pkg_type}" != "target" ]; then
	find "${pkg_pkg_dir}" ! -type d -perm /111 -print | while read file; do
	    if chrpath "${file}" > /dev/null 2>&1; then
		chrpath --replace "${PTXDIST_SYSROOT_HOST}/lib" "${file}" || return
	    fi
	done
    fi
}
export -f ptxd_make_world_install_unpack

#
# pack
#
# pack the dev tarball from pkg_pkg_dir
#
ptxd_make_world_install_pack() {
    ptxd_make_world_init &&

    if [ -z "${pkg_pkg_dir}" ]; then
	# no pkg dir -> assume the package has nothing to install.
	return
    fi &&

    # remove empty dirs
    test \! -e "${pkg_pkg_dir}" || \
	find "${pkg_pkg_dir}" -depth -type d -print0 | xargs -r -0 -- \
	rmdir --ignore-fail-on-non-empty -- &&
    check_pipe_status &&

    if [ \! -e "${pkg_pkg_dir}" ]; then
	ptxd_warning "PKG didn't install anything to '${pkg_pkg_dir}'"
	return
    fi &&

    # make pkgconfig's pc files relocatable
    find "${pkg_pkg_dir}" -name "*.pc" -print0 | \
	xargs -r -0 gawk -f "${PTXDIST_LIB_DIR}/ptxd_make_world_install_mangle_pc.awk" &&
    check_pipe_status &&

    local pkg_sysroot_dir_nolink="$(readlink -f "${pkg_sysroot_dir}")" &&
    # remove sysroot prefix from paths in la files
    find "${pkg_pkg_dir}" -name "*.la" -print0 | xargs -r -0 -- \
	sed -i \
	-e "/^dependency_libs/s:\( \|-L\|-R\)\(\|${pkg_sysroot_dir}\|${pkg_sysroot_dir_nolink}\|${pkg_pkg_dir}\)/*\(/lib\|/usr/lib\):\1@SYSROOT@\3:g" \
	-e "/^libdir=/s:\(libdir='\)\(\|${pkg_sysroot_dir}\|${pkg_sysroot_dir_nolink}\|${pkg_pkg_dir}\)/*\(/lib\|/usr/lib\):\1@SYSROOT@\3:g" &&
    check_pipe_status &&
    find "${pkg_pkg_dir}" -name "*.prl" -print0 | xargs -r -0 -- \
	sed -i \
	-e "/^QMAKE_PRL_LIBS/s:\( \|-L\|-R\)\(\|${pkg_sysroot_dir}\|${pkg_sysroot_dir_nolink}\|${pkg_pkg_dir}\)/*\(/lib\|/usr/lib\):\1@SYSROOT@\3:g" &&
    check_pipe_status &&
    find "${pkg_pkg_dir}" ! -type d -name "${pkg_binconfig_glob}" -print0 | xargs -r -0 -- \
	sed -i \
	-e "s:\(-L\|-Wl,\)\(${pkg_sysroot_dir}\|${pkg_sysroot_dir_nolink}\)/*\(/lib\|/usr/lib\):\1@SYSROOT@\3:g" \
	-e "s:\(-I\|-isystem \)\(${pkg_sysroot_dir}\|${pkg_sysroot_dir_nolink}\)/*\(/include\|/usr/include\):\1@SYSROOT@\3:g" &&
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
    find "${pkg_pkg_dir}" \( -name "*.la" -o -name "*.prl" \) -print0 | xargs -r -0 -- \
	sed -i -e "s:@SYSROOT@:${pkg_sysroot_dir}:g" &&
    check_pipe_status &&

    # fix *-config and copy into sysroot_cross for target packages
    local config &&
    find "${pkg_pkg_dir}" ! -type d -name "${pkg_binconfig_glob}" | while read config; do
	sed -i -e "s:@SYSROOT@:${pkg_sysroot_dir}:g" "${config}" &&
	if [ "${pkg_type}" = "target" ]; then
	    cp -P -- "${config}" "${PTXDIST_SYSROOT_CROSS}/bin" || return
	fi
    done &&

    cp -dprf -- "${pkg_pkg_dir}"/* "${pkg_sysroot_dir}"
}
export -f ptxd_make_world_install_post
