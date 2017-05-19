#!/bin/bash
#
# Copyright (C) 2017 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PTXDIST_MESON_CROSS_FILE="${PTXDIST_GEN_CONFIG_DIR}/cross-file.meson"
export PTXDIST_MESON_CROSS_FILE

#
# generate meson cross file from template
#
# $1:	meson cross file
#
ptxd_make_meson_cross_file() {
    CPU="$(ptxd_cross_cc_v | sed -n -e "s/.*'-march=\([^']*\).*/\1/p" -e "/-march=/q")" \
	ptxd_replace_magic "${PTXDIST_TOPDIR}/config/meson/cross-file.meson.in" > "${1}"
}
export -f ptxd_make_meson_cross_file
