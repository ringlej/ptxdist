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
IMAGE_PACKAGES-$(PTXCONF_IMAGE_HDIMG) += image-hdimg

#
# Paths and names
#
IMAGE_HDIMG		:= image-hdimg
IMAGE_HDIMG_DIR		:= $(BUILDDIR)/$(IMAGE_HDIMG)
IMAGE_HDIMG_IMAGE	:= $(IMAGEDIR)/hd.img
IMAGE_HDIMG_CONFIG	:= hd.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

ifdef PTXCONF_IMAGE_HDIMG
IMAGE_HDIMG_BOOTLOADER_ENV := \
	BOOTLOADER_IMAGES='' \
	BOOTLOADER_PARTITIONS=''

ifdef PTXCONF_IMAGE_HDIMG_GRUB
IMAGE_HDIMG_BOOTLOADER_ENV = \
	GRUB_STAGE_DIR=$(GRUB_STAGE_DIR) \
	BOOTLOADER_IMAGES='include("grub.config")' \
	BOOTLOADER_PARTITIONS='include("grub_partitions.config")'
endif
ifdef PTXCONF_IMAGE_HDIMG_BAREBOX
IMAGE_HDIMG_BOOTLOADER_ENV := \
	BOOTLOADER_IMAGES='' \
	BOOTLOADER_PARTITIONS='include("barebox_partitions.config")'
endif
ifdef PTXCONF_IMAGE_HDIMG_VFAT
IMAGE_HDIMG_BOOTLOADER_ENV := \
	VFAT_PARTITION_TYPE=$(call ptx/ifdef, PTXCONF_IMAGE_BOOT_VFAT_EFI_BAREBOX,0xef,0x0c) \
	BOOTLOADER_IMAGES='' \
	BOOTLOADER_PARTITIONS='include("vfat_partitions.config")'
endif

IMAGE_HDIMG_ENV = \
	$(IMAGE_HDIMG_BOOTLOADER_ENV)

$(IMAGE_HDIMG_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_HDIMG)
	@$(call finish)
endif

# vim: syntax=make
