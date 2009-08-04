#!/bin/bash
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# perform sanity check
#
ptxd_make_world_prepare_sanity_check() {
    if [ -n "${pkg_conf_opt}" -a \! -x "${pkg_conf_dir_abs}/configure" ]; then
	cat >&2 <<EOF

error: 'configure' not found or not executable in:
'${pkg_conf_dir_abs}'

EOF
	exit 1
    elif [ -n "${pkg_cmake_opt}" -a \! -e "${pkg_conf_dir_abs}/CMakeLists.txt" ]; then
	cat >&2 <<EOF

error: 'CMakeLists.txt' not found in:
'${pkg_conf_dir_abs}'

EOF
	exit 1
    fi
}
export -f ptxd_make_world_prepare_sanity_check


#
# prepare for cmake based pkgs
#
ptxd_make_world_prepare_cmake() {
    [ "${pkg_type}" != "target" ] && \
	ptxd_bailout "only cmake taget packages are supported"

    eval \
	"${pkg_path}" \
	"${pkg_env}" \
	"${pkg_cmake_env}" \
	cmake \
	-DCMAKE_TOOLCHAIN_FILE="${PTXDIST_CMAKE_TOOLCHAIN}" \
	"${pkg_cmake_opt}" \
	"${pkg_conf_dir}"
}
export -f ptxd_make_world_prepare_cmake


#
# prepare for autoconf based pkgs
#
ptxd_make_world_prepare_conf() {
    local pkg_cache_file cache_src

    case "${pkg_type}" in
	host|cross) cache_src="${PTXDIST_AUTOCONF_CACHE_HOST}"   ;;
	target)     cache_src="${PTXDIST_AUTOCONF_CACHE_TARGET}" ;;
    esac &&

    if [ -n "${PTXCONF_SETUP_COMMON_CACHE}" ]; then
	# use common cache
	pkg_cache_file="${cache_src}"
    else
	# use individual cache
	pkg_cache_file="${pkg_build_dir}/config.cache"
	cp -- "${cache_src}" "${pkg_cache_file}"
    fi &&

    eval \
	"${pkg_path}" \
	"${pkg_env}" \
	"${pkg_conf_env}" \
	"${pkg_conf_dir}/configure" \
	"${pkg_conf_opt}" \
	--cache-file="${pkg_cache_file}"
}
export -f ptxd_make_world_prepare_conf


#
# generic prepare
#
ptxd_make_world_prepare() {
    ptxd_make_world_init &&
    ptxd_make_world_prepare_sanity_check || return

    # delete existing build_dir
    if [ -n "${pkg_build_oot}" ]; then
	rm -rf   -- "${pkg_build_dir}" &&
	mkdir -p -- "${pkg_build_dir}" || return
    fi

    cd -- "${pkg_build_dir}" &&
    if [ -n "${pkg_cmake_opt}" ]; then
	ptxd_make_world_prepare_cmake
    elif [ -n "${pkg_conf_opt}" ]; then
	ptxd_make_world_prepare_conf
    fi
}
export -f ptxd_make_world_prepare
