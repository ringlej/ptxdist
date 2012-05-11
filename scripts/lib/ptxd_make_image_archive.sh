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
    echo -e "\nCreating $(ptxd_print_path "${image_image}") ...\n" &&
    tar -zcf "${image_image}" . &&
    rm -r "${pkg_dir}"
}
export -f ptxd_make_image_archive_impl

ptxd_make_image_archive() {
    fakeroot ptxd_make_image_archive_impl
}
export -f ptxd_make_image_archive
