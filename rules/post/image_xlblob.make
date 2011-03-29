# -*-makefile-*-
#
# Copyright (C) 2011 by Stephan Linz <linz@li-pro.net>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ifdef PTXCONF_IMAGE_XLBLOB_U_BOOT

U_BOOT_PAYLOAD		:= $(U_BOOT_DIR)/u-boot
U_BOOT_PAYLOAD_TYPE	:= U-Boot
U_BOOT_PAYLOAD_NAME	:= U-Boot-$(U_BOOT_VERSION)

SEL_ROOTFS-$(PTXCONF_U_BOOT)	+= $(IMAGEDIR)/u-boot-xl.bin
SEL_ROOTFS-$(PTXCONF_U_BOOT)	+= $(IMAGEDIR)/u-boot-xl.srec
SEL_ROOTFS-$(PTXCONF_U_BOOT)	+= $(IMAGEDIR)/u-boot-xl.elf

$(U_BOOT_DIR)/u-boot-xl.bin \
$(U_BOOT_DIR)/u-boot-xl.srec \
$(U_BOOT_DIR)/u-boot-xl.elf: $(STATEDIR)/u-boot.xlblob

$(IMAGEDIR)/u-boot-xl.%: $(U_BOOT_DIR)/u-boot-xl.% $(STATEDIR)/u-boot.targetinstall
	@echo -n "Creating '$(notdir $(@))' from '$(notdir $(<))'..."
	@install -m 644 "$(<)" "$(@)"
	@echo "done."

endif

ifdef PTXCONF_IMAGE_XLBLOB_KERNEL

KERNEL_PAYLOAD		:= $(KERNEL_IMAGE_PATH_y)
KERNEL_PAYLOAD_TYPE	:= Linux
KERNEL_PAYLOAD_NAME	:= Linux-$(KERNEL_VERSION)

SEL_ROOTFS-$(PTXCONF_IMAGE_KERNEL)	+= $(IMAGEDIR)/linuximage-xl.bin
SEL_ROOTFS-$(PTXCONF_IMAGE_KERNEL)	+= $(IMAGEDIR)/linuximage-xl.srec
SEL_ROOTFS-$(PTXCONF_IMAGE_KERNEL)	+= $(IMAGEDIR)/linuximage-xl.elf

$(KERNEL_IMAGE_PATH_y)-xl.bin \
$(KERNEL_IMAGE_PATH_y)-xl.srec \
$(KERNEL_IMAGE_PATH_y)-xl.elf: $(STATEDIR)/kernel.xlblob

ifdef PTXCONF_IMAGE_KERNEL_INITRAMFS
$(IMAGEDIR)/linuximage-xl.bin \
$(IMAGEDIR)/linuximage-xl.srec \
$(IMAGEDIR)/linuximage-xl.elf: $(STATEDIR)/image_kernel.compile
endif

$(IMAGEDIR)/linuximage-xl.%: $(KERNEL_IMAGE_PATH_y)-xl.% $(STATEDIR)/kernel.targetinstall
	@echo -n "Creating '$(notdir $(@))' from '$(notdir $(<))'..."
	@install -m 644 "$(<)" "$(@)"
	@echo "done."

endif

$(STATEDIR)/%.xlblob: $(STATEDIR)/%.compile
	@$(call targetinfo)
	@$(call xilinx/xlblob, $(PTX_MAP_TO_PACKAGE_$(*)), 			\
		$($(PTX_MAP_TO_PACKAGE_$(*))_DIR),				\
		$($(PTX_MAP_TO_PACKAGE_$(*))_PAYLOAD),				\
		$($(PTX_MAP_TO_PACKAGE_$(*))_PAYLOAD_TYPE),			\
		$($(PTX_MAP_TO_PACKAGE_$(*))_PAYLOAD_NAME))
	@$(call touch)

xilinx/xlblob = \
	$(call world/env, $(1))							\
	cd $(2) && $(CROSS_ENV)							\
		$(PTXCONF_SYSROOT_HOST)/bin/mkxlblob -t $(4) -n $(5) -o $(3)-xl $(3)

# vim: syntax=make
