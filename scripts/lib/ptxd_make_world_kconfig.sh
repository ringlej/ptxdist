#!/bin/bash
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# run kconfig and update the config file
# @$1:	the kconfig target (e.g. menuconfig, oldconfig, ...)
#
ptxd_make_kconfig() {
    if [ -e "${pkg_config}" ]; then
	cp "${pkg_config}" .config
    fi &&
    eval \
	"${pkg_path}" \
	"${pkg_env}" \
	"${pkg_conf_env}" \
	make "${1}" \
	"${pkg_conf_opt}" &&
    if ! diff -q -I "# [^C]" .config "${pkg_config}" > /dev/null 2>&1; then
	cp .config "${pkg_config}"
    fi
}
export -f ptxd_make_kconfig

ptxd_make_world_kconfig() {
    ptxd_make_world_init &&
    cd "${pkg_build_dir}" &&
    ptxd_make_kconfig "${ptx_config_target}"
}
export -f ptxd_make_world_kconfig
