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
IMAGE_PACKAGES-$(PTXCONF_IMAGE_ROOT_TGZ) += image-root-tgz

#
# Paths and names
#
IMAGE_ROOT_TGZ		:= image-root-tgz
IMAGE_ROOT_TGZ_DIR	:= $(BUILDDIR)/$(IMAGE_ROOT_TGZ)
IMAGE_ROOT_TGZ_IMAGE	:= $(IMAGEDIR)/root.tgz
IMAGE_ROOT_TGZ_PKGS	= $(PTX_PACKAGES_INSTALL)
IMAGE_ROOT_TGZ_LABEL	:= $(PTXDIST_IMAGE_TGZ_LABEL)

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

ifdef PTXCONF_IMAGE_ROOT_TGZ
$(IMAGE_ROOT_TGZ_IMAGE):
	@$(call targetinfo)
	@$(call image/archive, IMAGE_ROOT_TGZ)
	@$(call finish)
endif

# vim: syntax=make
