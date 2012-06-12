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
ptxd_make_image_genimage_impl() {
    local tmpdir config file
    config="$(mktemp "${PTXDIST_TEMPDIR}/genimage.config.XXXXXX")"
    tmpdir="$(mktemp -d "${PTXDIST_TEMPDIR}/genimage.XXXXXX")"

    ptxd_make_image_init &&
    [ -r "${1}" ] || ptxd_bailout "could not find config file $1"

    eval \
	"${image_env}" \
	IMAGE="$(basename "${image_image}")" \
	ptxd_replace_magic "${1}" > "${config}" &&

    rm -rf "${pkg_dir}" &&
    mkdir -p "${pkg_dir}" &&
    for file in ${image_files}; do
	ptxd_make_extract_archive "${image_files}" "${pkg_dir}"
    done &&

    eval \
	"${image_env}" \
	genimage \
	--rootpath "${pkg_dir}" \
	--tmppath "${tmpdir}" \
	--outputpath "$(dirname "${image_image}")" \
	--config "${config}" &&

    rm -r "${pkg_dir}"
}
export -f ptxd_make_image_genimage_impl

ptxd_make_image_genimage() {
    fakeroot ptxd_make_image_genimage_impl "${1}"
}
export -f ptxd_make_image_genimage
