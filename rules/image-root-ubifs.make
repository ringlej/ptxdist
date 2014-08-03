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
IMAGE_PACKAGES-$(PTXCONF_IMAGE_ROOT_UBIFS) += image-root-ubifs

#
# Paths and names
#
IMAGE_ROOT_UBIFS	:= image-root-ubifs
IMAGE_ROOT_UBIFS_DIR	:= $(BUILDDIR)/$(IMAGE_ROOT_UBIFS)
IMAGE_ROOT_UBIFS_IMAGE	:= $(IMAGEDIR)/root.ubifs
IMAGE_ROOT_UBIFS_FILES	:= $(IMAGEDIR)/root.tgz
IMAGE_ROOT_UBIFS_CONFIG	:= ubifs.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

ifdef PTXCONF_IMAGE_ROOT_UBIFS
IMAGE_ROOT_UBIFS_ENV := \
	PEB_SIZE=$(PTXCONF_IMAGE_ROOT_UBIFS_PEB_SIZE) \
	MINIMUM_IO_UNIT_SIZE=$(PTXCONF_IMAGE_ROOT_UBIFS_MINIMUM_IO_UNIT_SIZE) \
	SUB_PAGE_SIZE=$(PTXCONF_IMAGE_ROOT_UBIFS_SUB_PAGE_SIZE) \
	VID_HEADER_OFFSET=$(PTXCONF_IMAGE_ROOT_UBIFS_VID_HEADER_OFFSET) \
	LEB_SIZE=$(PTXCONF_IMAGE_ROOT_UBIFS_LEB_SIZE) \
	MAX_SIZE=$(PTXCONF_IMAGE_ROOT_UBIFS_MAX_SIZE)

$(IMAGE_ROOT_UBIFS_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_ROOT_UBIFS)
	@$(call finish)
endif

# vim: syntax=make
