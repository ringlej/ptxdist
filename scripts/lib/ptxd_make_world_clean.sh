#!/bin/bash
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# clean
#
ptxd_make_world_clean() {
    ptxd_make_world_init &&

    if [ -f "${pkg_xpkg_map}" ]; then
	echo "Deleting ipks:"
	for name in $(cat "${pkg_xpkg_map}" 2>/dev/null); do
	    ls "${ptx_pkg_dir}/${name}"_*.ipk
	    rm -f "${ptx_pkg_dir}/${name}"_*.ipk
	done
	echo
    fi
    if [ -n "$(ls "${ptx_state_dir}/${pkg_label}".* 2> /dev/null)" ]; then
	echo "Deleting stage files:"
	for name in $(cat "${pkg_xpkg_map}" 2>/dev/null); do
	    ls "${ptx_state_dir}/${name}".*
	    rm -f "${ptx_state_dir}/${name}".*
	done
	ls "${ptx_state_dir}/${pkg_label}".* 2>/dev/null
	rm -f "${ptx_state_dir}/${pkg_label}".*
	echo
    fi
    if [ -d "${pkg_dir}" ]; then
	echo "Deleting src dir:"
	echo "${pkg_dir}"
	rm -rf "${pkg_dir}"
	echo
    fi
    if [ -d "${pkg_build_dir}" ]; then
	echo "Deleting build dir:"
	echo "${pkg_build_dir}"
	rm -rf "${pkg_build_dir}"
	echo
    fi
    if [ -d "${pkg_pkg_dir}" ]; then
	echo "Removing files from sysroot..."
	echo
	find "${pkg_pkg_dir}" ! -type d | while read file; do
		rm -f "${pkg_sysroot_dir}/${file##${pkg_pkg_dir}}"
	done
	echo "Deleting pkg dir:"
	echo "${pkg_pkg_dir}"
	rm -rf "${pkg_pkg_dir}"
	echo
    fi
}
export -f ptxd_make_world_clean

