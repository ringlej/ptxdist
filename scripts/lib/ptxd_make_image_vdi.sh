#!/bin/bash
#
# Copyright (C) 2011 by Philippe Corbes <philippe.corbes@gmail.com>
#           (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# create or update a vdi image from an img file.
#
# in:
# - $image_vdi_img	the source file name
# - $image_vdi_vdi	the destination file name
#
ptxd_make_image_vdi() {
	local uuid

	if ! which vboxmanage > /dev/null; then
		ptxd_bailout "Virtualbox not installed!"
	fi

	# remember UUID if the image already exists.
	if [ -f "${image_vdi_vdi}" ]; then
		uuid="$(vboxmanage showhdinfo "${image_vdi_vdi}" | awk '/^UUID:/ { print $2 }')" &&
		rm -f "${image_vdi_vdi}"
	fi &&

	vboxmanage convertdd "${image_vdi_img}" "${image_vdi_vdi}" 2>&1 &&

	if [ -n "${uuid}" ]; then
		vboxmanage internalcommands sethduuid "${image_vdi_vdi}" "${uuid}"
	fi
}
export -f ptxd_make_image_vdi
