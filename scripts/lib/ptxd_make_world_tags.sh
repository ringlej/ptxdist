#!/bin/bash
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# call the tagsr
#
ptxd_make_world_tags() {
    ptxd_make_world_init &&

    eval \
	"${pkg_path}" \
	"${pkg_env}" \
	"${pkg_make_env}" \
	"${MAKE}" -C "${pkg_build_dir}" \
	"${pkg_make_opt}" \
	"${pkg_make_par}" \
	"${pkg_tags_opt}"
}
export -f ptxd_make_world_tags
