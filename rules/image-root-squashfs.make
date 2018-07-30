# -*-makefile-*-
#
# Copyright (C) 2018 by Florian Bäuerle <florian.baeuerle@allegion.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
IMAGE_PACKAGES-$(PTXCONF_IMAGE_ROOT_SQUASHFS) += image-root-squashfs

#
# Paths and names
#
IMAGE_ROOT_SQUASHFS		:= image-root-squashfs
IMAGE_ROOT_SQUASHFS_DIR		:= $(BUILDDIR)/$(IMAGE_ROOT_SQUASHFS)
IMAGE_ROOT_SQUASHFS_IMAGE	:= $(IMAGEDIR)/root.squashfs
IMAGE_ROOT_SQUASHFS_FILES	:= $(IMAGEDIR)/root.tgz
IMAGE_ROOT_SQUASHFS_CONFIG	:= squashfs.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

IMAGE_ROOT_SQUASHFS_ENV := \
	EXTRA_ARGS=$(PTXCONF_IMAGE_ROOT_SQUASHFS_EXTRA_ARGS) \
	COMPRESSION_MODE=$(PTXCONF_IMAGE_ROOT_SQUASHFS_COMPRESSION_MODE) \
	BLOCK_SIZE=$(PTXCONF_IMAGE_ROOT_SQUASHFS_BLOCK_SIZE)

$(IMAGE_ROOT_SQUASHFS_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_ROOT_SQUASHFS)
	@$(call finish)

# vim: syntax=make
