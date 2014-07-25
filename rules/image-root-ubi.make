# -*-makefile-*-
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
IMAGE_PACKAGES-$(PTXCONF_IMAGE_ROOT_UBI) += image-root-ubi

#
# Paths and names
#
IMAGE_ROOT_UBI		:= image-root-ubi
IMAGE_ROOT_UBI_DIR	:= $(BUILDDIR)/$(IMAGE_ROOT_UBI)
IMAGE_ROOT_UBI_IMAGE	:= $(IMAGEDIR)/root.ubi
IMAGE_ROOT_UBI_CONFIG	:= ubi.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

ifdef PTXCONF_IMAGE_ROOT_UBI
IMAGE_ROOT_UBI_ENV := \
	PEB_SIZE=$(PTXCONF_IMAGE_ROOT_UBIFS_PEB_SIZE) \
	MINIMUM_IO_UNIT_SIZE=$(PTXCONF_IMAGE_ROOT_UBIFS_MINIMUM_IO_UNIT_SIZE) \
	SUB_PAGE_SIZE=$(PTXCONF_IMAGE_ROOT_UBIFS_SUB_PAGE_SIZE) \
	VID_HEADER_OFFSET=$(PTXCONF_IMAGE_ROOT_UBIFS_VID_HEADER_OFFSET) \
	LEB_SIZE=$(PTXCONF_IMAGE_ROOT_UBIFS_LEB_SIZE)

$(IMAGE_ROOT_UBI_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_ROOT_UBI)
	@$(call finish)
endif

# vim: syntax=make
