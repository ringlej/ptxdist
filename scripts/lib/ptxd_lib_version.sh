#!/bin/bash
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_bsp_autoversion() {
    PTXDIST_BSP_AUTOVERSION="$("${PTXDIST_TOPDIR}/scripts/kernel/setlocalversion" "${PTXDIST_WORKSPACE}/.tarball-version")"
    export PTXDIST_BSP_AUTOVERSION
}
export -f ptxd_bsp_autoversion

ptxd_bsp_autoversion
