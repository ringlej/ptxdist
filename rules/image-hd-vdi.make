# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
IMAGE_PACKAGES-$(PTXCONF_IMAGE_HD_VDI) += image-hd-vdi

#
# Paths and names
#
IMAGE_HD_VDI		:= image-hd-vdi
IMAGE_HD_VDI_IMAGE	:= $(IMAGEDIR)/hd.vdi
IMAGE_HD_VDI_FILES	:= $(IMAGEDIR)/hd.img

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

$(IMAGE_HD_VDI_IMAGE):
	@$(call targetinfo)
	@$(call image/env) \
		image_vdi_img="$(IMAGE_HD_VDI_FILES)" \
		image_vdi_vdi="$(@)" \
		ptxd_make_image_vdi
	@$(call finish)

# vim: syntax=make
