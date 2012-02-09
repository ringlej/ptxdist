# -*-makefile-*-
#
# Copyright (C) 2003-2010 by the ptxdist project <ptxdist@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

SEL_ROOTFS-$(PTXCONF_IMAGE_UIMAGE)	+= $(IMAGEDIR)/uRamdisk

#
# Create architecture type for mkimge
# Most architectures are working with label $(PTXCONF_ARCH_STRING)
# but the i386 family needs "x86" instead!
#
ifeq ($(PTXCONF_ARCH_STRING),"i386")
MKIMAGE_ARCH := x86
else
MKIMAGE_ARCH := $(PTXCONF_ARCH_STRING)
endif

ifdef PTXCONF_IMAGE_UIMAGE_RAMDISK
URAMDISK_IMAGEFILE := $(IMAGEDIR)/root.ext2.gz
endif

ifdef PTXCONF_IMAGE_UIMAGE_INITRAMFS
URAMDISK_IMAGEFILE := $(IMAGEDIR)/root.cpio.gz
endif

#
# TODO
#
$(IMAGEDIR)/uRamdisk: $(URAMDISK_IMAGEFILE)
	@echo -n "Creating U-Boot ramdisk from $(notdir $(URAMDISK_IMAGEFILE))...";
	@$(PTXCONF_SYSROOT_HOST)/bin/mkimage \
		-A $(MKIMAGE_ARCH) \
		-O Linux \
		-T ramdisk \
		-C gzip \
		-n $(PTXCONF_IMAGE_UIMAGE_NAME) \
		-d $< \
		$@ > /dev/null
	@echo "done."

# vim: syntax=make
