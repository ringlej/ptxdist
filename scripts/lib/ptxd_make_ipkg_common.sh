#!/bin/bash
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#


#
# initialize variables needed to package ipkgs
#
ptxd_make_ipkg_init() {
    pkg_ipkg_tmp="${pkg_xpkg_tmp}/ipkg"
    pkg_ipkg_control_dir="${pkg_ipkg_tmp}/CONTROL"
    pkg_ipkg_control="${pkg_ipkg_control_dir}/control"
    pkg_xpkg_conffiles="${pkg_xpkg_control_dir}/conffiles"
}
export -f ptxd_make_ipkg_init