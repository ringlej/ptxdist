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

    eval \
	"${pkg_path}" \
	"${pkg_env}" \
	"${pkg_make_env}" \
	"${MAKE}" -C "${pkg_build_dir}" \
	"${pkg_make_opt}" \
	"${pkg_make_par}"
}
export -f ptxd_make_world_compile
