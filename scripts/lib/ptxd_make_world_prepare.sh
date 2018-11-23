#!/bin/bash
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_make_world_cfghash()
{
    local -a hashes
    local hash h

    ptxd_make_world_init || return

    hashes=( "${ptx_state_dir}/${pkg_label}."*".cfghash" )
    hash="${ptx_state_dir}/${pkg_label}.${pkg_cfghash}.cfghash"

    if [ ${hashes[0]} = "${ptx_state_dir}/${pkg_label}.*.cfghash" ]; then
	hashes=()
    fi
    if [ ${#hashes[@]} -gt 1 ]; then
	ptxd_warning "more than one cfghash found!"
    fi
    for h in "${hashes[@]}"; do
	if [ "${h}" != "${hash}" ]; then
	    echo -e "Configuration changed! Reconfiguring...\n"
	fi
	rm "${h}" || break
    done
}
export -f ptxd_make_world_cfghash

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
    elif [ "${pkg_conf_tool}" = "cmake" -a "${pkg_type}" = "cross" ]; then
	cat >&2 <<EOF

error: sorry - cmake 'cross' packages are not supported

EOF
	exit 1
    elif [ \( "${pkg_conf_tool}" = "qmake" -o "${pkg_conf_tool}" = "perl" \) -a "${pkg_type}" != "target" ]; then
	cat >&2 <<EOF

error: only ${pkg_conf_tool} taget packages are supported

EOF
	exit 1
    fi
}
export -f ptxd_make_world_prepare_sanity_check


#
# prepare for cmake based pkgs
#
ptxd_make_world_prepare_cmake() {
    full_log="CMakeFiles/CMakeOutput.log"
    ptxd_eval \
	"${pkg_path}" \
	"${pkg_env}" \
	"${pkg_conf_env}" \
	cmake \
	"${pkg_conf_opt}" \
	"${pkg_conf_dir}"
}
export -f ptxd_make_world_prepare_cmake


#
# prepare for qmake based pkgs
#
ptxd_make_world_prepare_qmake() {
    ptxd_eval \
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
    full_log="config.log"
    ptxd_eval \
	"${pkg_path}" \
	"${pkg_env}" \
	"${pkg_conf_env}" \
	"${pkg_conf_dir}/configure" \
	"${pkg_conf_opt}"
}
export -f ptxd_make_world_prepare_autoconf


#
# prepare for kconfig based pkgs
#
ptxd_make_world_prepare_kconfig() {
    ptxd_make_kconfig oldconfig
}
export -f ptxd_make_world_prepare_kconfig


#
# prepare for perl modules
#
ptxd_make_world_prepare_perl() {
    ptxd_eval \
	"${pkg_path}" \
	"${pkg_env}" \
	"${pkg_conf_env}" \
	cross-perl \
	Makefile.PL \
	"${pkg_conf_opt}"
}
export -f ptxd_make_world_prepare_perl


#
# prepare for meson based pkgs
#
ptxd_make_world_prepare_meson() {
    full_log="meson-logs/meson-log.txt"
    ptxd_eval \
	"${pkg_path}" \
	"${pkg_env}" \
	"${pkg_conf_env}" \
	meson \
	"${pkg_conf_opt}" \
	"${pkg_conf_dir}"
}
export -f ptxd_make_world_prepare_meson


#
# generic prepare
#
ptxd_make_world_prepare() {
    local full_log
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

    case "${pkg_conf_tool}" in
	autoconf|cmake|qmake|kconfig|perl|meson)
	    cd -- "${pkg_build_dir}" &&
	    ptxd_make_world_prepare_"${pkg_conf_tool}" ;;
	python|python3)
	    : ;; # nothing to do
	"NO") echo "prepare stage disabled." ;;
	"")   echo "No prepare tool found. Do nothing." ;;
	*)    ptxd_bailout "automatic prepare tool selection failed. Set <PKG>_CONF_TOOL";;
    esac
    local ret=$?
    if [ ${ret} -ne 0 -a -f "${full_log}" ]; then
	echo
	echo "Full ${pkg_conf_tool} logfile (${full_log}):"
	echo
	cat "${pkg_build_dir}/${full_log}"
    fi >&${PTXDIST_QUIET:=${PTXDIST_FD_LOGFILE}}
    return ${ret}
}
export -f ptxd_make_world_prepare
