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
IMAGE_PACKAGES-$(PTXCONF_IMAGE_ROOT_CPIO_GZ) += image-root-cpio-gz

#
# Paths and names
#
IMAGE_ROOT_CPIO_GZ		:= image-root-cpio-gz
IMAGE_ROOT_CPIO_GZ_DIR		:= $(BUILDDIR)/$(IMAGE_ROOT_CPIO_GZ)
IMAGE_ROOT_CPIO_GZ_IMAGE	:= $(IMAGEDIR)/root.cpio.gz
IMAGE_ROOT_CPIO_GZ_FILES	:= $(IMAGEDIR)/root.tgz
IMAGE_ROOT_CPIO_GZ_CONFIG	:= cpio.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

IMAGE_ROOT_CPIO_GZ_ENV := \
	FORMAT="newc" \
	COMPRESS=gzip

ifdef PTXCONF_IMAGE_ROOT_CPIO_GZ
$(IMAGE_ROOT_CPIO_GZ_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_ROOT_CPIO_GZ)
	@$(call finish)
endif

# vim: syntax=make
