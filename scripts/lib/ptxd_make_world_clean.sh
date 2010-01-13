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

    if [ -f "${ptx_state_dir}/${pkg_label}.xpkg.map" ]; then
	echo "Deleting ipks:"
	for name in `cat "${ptx_state_dir}/${pkg_label}.xpkg.map" 2>/dev/null`; do
	    ls "${ptx_pkg_dir}/${name}"_*.ipk
	    rm -f "${ptx_pkg_dir}/${name}"_*.ipk
	done
	echo
    fi
    if [ -n "`ls "${ptx_state_dir}/${pkg_label}".* 2> /dev/null`" ]; then
	echo "Deleting stage files:"
	ls "${ptx_state_dir}/${pkg_label}".*
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
	echo "Deleting pkg dir:"
	echo "${pkg_pkg_dir}"
	rm -rf "${pkg_pkg_dir}"
	echo
    fi
}
export -f ptxd_make_world_clean

