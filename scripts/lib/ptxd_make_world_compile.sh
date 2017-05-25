#!/bin/bash
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# call the compiler
#
ptxd_make_world_compile() {
    ptxd_make_world_init &&

    if [ -z "${pkg_build_dir}" ]; then
	# no build dir -> assume the package has nothing to build.
	return
    fi &&
    case "${pkg_conf_tool}" in
	python*)
	(
	ptxd_eval \
	    cd "${pkg_build_dir}" '&&' \
	    "${pkg_path}" \
	    "${pkg_env}" \
	    "${pkg_make_env}" \
	    "${ptx_build_python}" \
	    setup.py \
	    "${pkg_make_opt}"
	)
	;;
	meson)
	ptxd_eval \
	    "${pkg_path}" \
	    "${pkg_env}" \
	    "${pkg_make_env}" \
	    ninja -C "${pkg_build_dir}" \
	    "${pkg_make_opt}" \
	    "${pkg_make_par}"
	;;
	*)
	ptxd_eval \
	    "${pkg_path}" \
	    "${pkg_env}" \
	    "${pkg_make_env}" \
	    "${MAKE}" -C "${pkg_build_dir}" \
	    "${pkg_make_opt}" \
	    "${pkg_make_par}"
	;;
    esac
}
export -f ptxd_make_world_compile
