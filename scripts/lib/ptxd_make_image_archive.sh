#!/bin/bash
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# extract ipkg an generate a tgz image
#
ptxd_make_image_archive_impl() {
    ptxd_make_image_init &&
    ptxd_get_ipkg_files ${image_pkgs} &&
    ptxd_make_image_extract_xpkg_files "${pkg_dir}" &&
    cd "${pkg_dir}" &&
    echo -ne "\nCreating $(ptxd_print_path "${image_image}") "
    if [ -n "${image_label}" ]; then
	echo -n "with label \"${image_label}\" "
    fi
    echo -ne "...\n" &&
    tar "${image_label_args[@]}" -zcf "${image_image}" .
    local ret=$?
    if [ "${ret}" != 0 ]; then
	rm -f "${image_image}"
    fi
    rm -r "${pkg_dir}"
    return "${ret}"
}
export -f ptxd_make_image_archive_impl

ptxd_make_image_archive() {
    fakeroot ptxd_make_image_archive_impl
}
export -f ptxd_make_image_archive
