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
IMAGE_PACKAGES-$(PTXCONF_IMAGE_KERNEL_LZOP) += image-kernel-lzop

#
# Paths and names
#
IMAGE_KERNEL_LZOP	:= image-kernel-lzop
IMAGE_KERNEL_LZOP_IMAGE	:= $(IMAGEDIR)/linuximage.lzo

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

$(IMAGE_KERNEL_LZOP_IMAGE): $(IMAGEDIR)/linuximage
	@$(call targetinfo)
	@echo "Creating '$(notdir $(@))' from '$(notdir $(<))'..."
	@lzop -f $(call remove_quotes,$(PTXCONF_IMAGE_KERNEL_LZOP_EXTRA_ARGS)) -c "$(<)" > "$(@)"
	@$(call finish)

# vim: syntax=make
