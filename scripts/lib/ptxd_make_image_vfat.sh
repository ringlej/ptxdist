#!/bin/bash
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_make_image_vfat_add() {
    local image="${1}"
    local src="${2}"
    local dst="${3}"

    if [ ! -e "${src}" ]; then
	ptxd_bailout "source file '$(ptxd_print_path "${src}")' for '$(ptxd_print_path "${image}") missing!"
    fi
    MTOOLS_SKIP_CHECK=1 mcopy -i "${image}" "${src}" "::${dst}"
}
export -f ptxd_make_image_vfat_add

#
# create a vfat image and fill it.
#
# in:
# - $image_vfat_file	the image file name
# - $image_vfat_size	the image file size in bytes. Guessed if undefined.
# - $image_vfat_map	file with $src:$dst mappings for the image content
#
ptxd_make_image_vfat() {
    local image="${image_vfat_file}.tmp"
    local src dst

    if [ -z "${image_vfat_size}" ]; then
	local size=0
	while IFS=: read src dst; do
	    local tmp="$(du -b "${src}")"
	    size=$[${size}+${tmp%%	*}]
	done < "${image_vfat_map}"
	# + 10%
	size=$[${size}+${size}/10]
	# round up to 16k
	size=$[(${size}/16384+1)*16384]
	image_vfat_size="${size}"
    fi
    rm -f "${image_vfat_file}" "${image}" &&
    # just seek to prepare the size for mkfs.vfat
    dd if=/dev/zero of="${image}" seek=${image_vfat_size} count=0 bs=1 2>/dev/null &&
    mkfs.vfat "${image}" >/dev/null &&

    while IFS=: read src dst; do
	ptxd_make_image_vfat_add "${image}" "${src}" "${dst}" || return
    done < "${image_vfat_map}" &&

    mv "${image}" "${image_vfat_file}"
}
export -f ptxd_make_image_vfat

