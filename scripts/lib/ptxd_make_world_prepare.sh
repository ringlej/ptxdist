#!/bin/bash
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# perform sanity check
#
ptxd_make_world_prepare_sanity_check() {
    if [ "${pkg_conf_tool}" = "autoconf" -a \! -x "${pkg_conf_dir_abs}/configure" ]; then
	cat >&2 <<EOF

error: 'configure' not found or not executable in:
'${pkg_conf_dir_abs}'

EOF
	exit 1
    elif [ "${pkg_conf_tool}" = "cmake" -a \! -e "${pkg_conf_dir_abs}/CMakeLists.txt" ]; then
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
    local pkg_cmake_opt

    case "${pkg_type}" in
	target)
	    pkg_cmake_opt="-DCMAKE_TOOLCHAIN_FILE='${PTXDIST_CMAKE_TOOLCHAIN_TARGET}'" ;;
	host)
	    pkg_cmake_opt="-DCMAKE_TOOLCHAIN_FILE='${PTXDIST_CMAKE_TOOLCHAIN_HOST}'" ;;
	cross)
	    ptxd_bailout "sorry - cmake 'cross' packages are not supported" ;;
    esac

    eval \
	"${pkg_path}" \
	"${pkg_env}" \
	"${pkg_conf_env}" \
	cmake \
	"${pkg_cmake_opt}" \
	"${pkg_conf_opt}" \
	"${pkg_conf_dir}"
}
export -f ptxd_make_world_prepare_cmake


#
# prepare for qmake based pkgs
#
ptxd_make_world_prepare_qmake() {
    [ "${pkg_type}" != "target" ] && \
	ptxd_bailout "only qmake taget packages are supported"

    eval \
	"${pkg_path}" \
	"${pkg_env}" \
	"${pkg_conf_env}" \
	qmake \
	"${pkg_conf_opt}" \
	"${pkg_conf_dir}"/*.pro
}
export -f ptxd_make_world_prepare_qmake


#
# prepare for autoconf based pkgs
#
ptxd_make_world_prepare_autoconf() {
    eval \
	"${pkg_path}" \
	"${pkg_env}" \
	"${pkg_conf_env}" \
	"${pkg_conf_dir}/configure" \
	"${pkg_conf_opt}"
}
export -f ptxd_make_world_prepare_autoconf


#
# generic prepare
#
ptxd_make_world_prepare() {
    ptxd_make_world_init &&
    ptxd_make_world_prepare_sanity_check || return

    if [ -z "${pkg_conf_dir_abs}" ]; then
	# no conf dir -> assume the package has nothing to configure.
	return
    fi

    # delete existing build_dir
    if [ -n "${pkg_build_oot}" ]; then
	rm -rf   -- "${pkg_build_dir}" &&
	mkdir -p -- "${pkg_build_dir}" || return
    fi

    cd -- "${pkg_build_dir}" &&
    case "${pkg_conf_tool}" in
	autoconf|cmake|qmake)
	    ptxd_make_world_prepare_"${pkg_conf_tool}" ;;
	"NO") echo "prepare stage disabled." ;;
	"")   echo "No prepare tool found. Do nothing." ;;
	*)    ptxd_bailout "automatic prepare tool selection failed. Set <PKG>_CONF_TOOL";;
    esac
}
export -f ptxd_make_world_prepare
