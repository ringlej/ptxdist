# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
IMAGE_PACKAGES-$(PTXCONF_IMAGE_ROOT_CPIO) += image-root-cpio

#
# Paths and names
#
IMAGE_ROOT_CPIO		:= image-root-cpio
IMAGE_ROOT_CPIO_DIR	:= $(BUILDDIR)/$(IMAGE_ROOT_CPIO)
IMAGE_ROOT_CPIO_IMAGE	:= $(IMAGEDIR)/root.cpio
IMAGE_ROOT_CPIO_FILES	:= $(IMAGEDIR)/root.tgz
IMAGE_ROOT_CPIO_CONFIG	:= cpio.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

IMAGE_ROOT_CPIO_ENV := \
	FORMAT="newc" \
	COMPRESS=

ifdef PTXCONF_IMAGE_ROOT_CPIO
$(IMAGE_ROOT_CPIO_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_ROOT_CPIO)
	@$(call finish)
endif

# vim: syntax=make
