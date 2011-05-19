#!/bin/bash
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2011 by George McCollister <george.mccollister@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#


#
# initialize variables needed to package opkgs
#
ptxd_make_opkg_init() {
    pkg_opkg_tmp="${pkg_xpkg_tmp}/opkg"
    pkg_xpkg_control_dir="${pkg_opkg_tmp}/CONTROL"
    pkg_xpkg_control="${pkg_xpkg_control_dir}/control"
    pkg_xpkg_conffiles="${pkg_xpkg_control_dir}/conffiles"
}
export -f ptxd_make_opkg_init
