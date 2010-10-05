# -*-makefile-*-
#
# Copyright (C) 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

SEL_ROOTFS-$(PTXCONF_IMAGE_KERNEL) += $(IMAGEDIR)/linuximage
SEL_ROOTFS_$(PTXCONF_IMAGE_KERNEL_LZOP) += $(IMAGEDIR)/linuximage.lzo

ifdef PTXCONF_IMAGE_KERNEL_INITRAMFS
$(IMAGEDIR)/linuximage: $(STATEDIR)/image_kernel.compile
endif

$(STATEDIR)/image_kernel.compile: $(IMAGEDIR)/root.cpio
	@echo -n "Creating '$(KERNEL_IMAGE)' including '$(notdir $(<))'..."
	@sed -i -e 's,^CONFIG_INITRAMFS_SOURCE.*$$,CONFIG_INITRAMFS_SOURCE=\"$(<)\",g' \
		$(KERNEL_DIR)/.config
	@cd $(KERNEL_DIR) && $(KERNEL_PATH) $(KERNEL_ENV) $(MAKE) \
		$(KERNEL_MAKEVARS) $(KERNEL_IMAGE)
	@echo "done."

$(IMAGEDIR)/linuximage: $(KERNEL_IMAGE_PATH_y) $(STATEDIR)/kernel.targetinstall
	@echo -n "Creating '$(notdir $(@))' from '$(notdir $(<))'..."
	@install -m 644 "$(<)" "$(@)"
	@echo "done."

$(IMAGEDIR)/linuximage.lzo: $(IMAGEDIR)/linuximage
	@echo -n "Creating '$(notdir $(@))' from '$(notdir $(<))'..."
	@lzop -f $(call remove_quotes,$(PTXCONF_IMAGE_KERNEL_LZOP_EXTRA_ARGS)) -o "$(@)" "$(<)"
	@echo "done."

# vim: syntax=make
