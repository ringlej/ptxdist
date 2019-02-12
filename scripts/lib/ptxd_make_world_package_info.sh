#!/bin/bash
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_make_world_package_info() {
    ptxd_make_world_patchin_init || return
    if [ -z "${pkg_version}" ]; then
	ptxd_bailout "'${pkg_label}' is not a valid package"
    fi
    echo "package:   ${pkg_label}"
    echo "version:   ${pkg_version}"
    echo
    if [ -n "${pkg_config}" ]; then
	echo "config:    $(ptxd_print_path "${pkg_config}")"
	echo
    fi
    if [ -n "${pkg_license}" ]; then
	echo "license:   ${pkg_license}"
    fi
    if [ -n "${pkg_license_files}" ]; then
	echo "  files:   ${pkg_license_files}"
    fi
    if [ -n "${pkg_license}" ]; then
	echo
    fi
    if [ -n "${pkg_src}" ]; then
	echo "source:    $(ptxd_print_path "${pkg_src}")"
    fi
    if [ -n "${pkg_url}" ]; then
	echo "url:       ${pkg_url}"
    fi
    if [ -n "${pkg_src}" -o -n "${pkg_url}" ]; then
	echo
    fi
    if [ -n "${pkg_dir}" ]; then
	echo "src dir:   $(ptxd_print_path "${pkg_dir}")"
    fi
    if [ "${pkg_build_dir}" != "${pkg_dir}" ]; then
	echo "build dir: $(ptxd_print_path "${pkg_build_dir}")"
    fi
    if [ -n "${pkg_pkg_dir}" ]; then
	echo "pkg dir:   $(ptxd_print_path "${pkg_pkg_dir}")"
    fi
    if [ -n "${pkg_dir}" -o -n "${pkg_pkg_dir}" ]; then
	echo
    fi
    echo "rule file: $(ptxd_print_path "${pkg_makefile}")"
    echo "menu file: $(ptxd_print_path "${pkg_infile}")"
    echo
    if [ -n "${pkg_patch_dir}" ]; then
	echo "patches:   $(ptxd_print_path "${pkg_patch_dir}")"
	echo
    fi
}
export -f ptxd_make_world_package_info
