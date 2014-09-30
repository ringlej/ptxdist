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
IMAGE_PACKAGES-$(PTXCONF_IMAGE_BOOT_VFAT) += image-boot-vfat

#
# Paths and names
#
IMAGE_BOOT_VFAT		:= image-boot-vfat
IMAGE_BOOT_VFAT_DIR	:= $(BUILDDIR)/$(IMAGE_BOOT_VFAT)
IMAGE_BOOT_VFAT_IMAGE	:= $(IMAGEDIR)/boot.vfat
ifdef PTXCONF_IMAGE_BOOT_VFAT_MLO_BAREBOX
IMAGE_BOOT_VFAT_CONFIG	:= boot-vfat-mlo-barebox.config
endif
ifdef PTXCONF_IMAGE_BOOT_VFAT_MLO_UBOOT
IMAGE_BOOT_VFAT_CONFIG	:= boot-vfat-mlo-u-boot.config
endif
ifdef PTXCONF_IMAGE_BOOT_VFAT_EFI_BAREBOX
IMAGE_BOOT_VFAT_CONFIG	:= boot-vfat-efi-barebox.config
ifdef PTXCONF_ARCH_X86_64
IMAGE_BOOT_VFAT_ENV	:= EFI_IMAGE=BOOTx64.EFI
else
IMAGE_BOOT_VFAT_ENV	:= EFI_IMAGE=BOOTx32.EFI
endif
endif

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

$(IMAGE_BOOT_VFAT_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_BOOT_VFAT)
	@$(call finish)

# vim: syntax=make
