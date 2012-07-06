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
IMAGE_PACKAGES-$(PTXCONF_IMAGE_ROOT_EXT) += image-root-ext

#
# Paths and names
#
IMAGE_ROOT_EXT		:= image-root-ext
IMAGE_ROOT_EXT_DIR	:= $(BUILDDIR)/$(IMAGE_ROOT_EXT)
IMAGE_ROOT_EXT_IMAGE	:= $(IMAGEDIR)/root.ext2
IMAGE_ROOT_EXT_FILES	:= $(IMAGEDIR)/root.tgz
IMAGE_ROOT_EXT_CONFIG	:= ext.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

IMAGE_ROOT_EXT_ENV := \
	SIZE=$(PTXCONF_IMAGE_ROOT_EXT_SIZE) \
	EXT_TYPE=$(PTXCONF_IMAGE_ROOT_EXT_TYPE)

ifdef PTXCONF_IMAGE_ROOT_EXT
$(IMAGE_ROOT_EXT_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_ROOT_EXT)
	@$(call finish)
endif

# vim: syntax=make
