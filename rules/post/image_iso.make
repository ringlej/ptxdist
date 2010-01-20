# -*-makefile-*-
#
# Copyright (C) 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

SEL_ROOTFS-$(PTXCONF_IMAGE_ISO) += $(IMAGEDIR)/bootcd.iso

bootcd/workdir := $(IMAGEDIR)/bootcd-workdir

$(IMAGEDIR)/bootcd.iso: $(PTXDIST_SYSROOT_TARGET)/usr/share/syslinux/isolinux.bin $(IMAGEDIR)/initrd.gz $(IMAGEDIR)/linuximage
	@echo -n "generating boot CD from $(notdir $^)..."
	@rm -rf "$(bootcd/workdir)"
	@mkdir -p "$(bootcd/workdir)"
	@cp $(^) "$(bootcd/workdir)"
	@mv "$(bootcd/workdir)/linuximage" "$(bootcd/workdir)/kernel"
	@tar -C $(PTXCONF_IMAGE_ISO_ADDON_DIR) -cf - \
		--exclude .git \
		--exclude .pc \
		--exclude .svn \
		--exclude *~ \
		. | \
		tar -o -C "$(bootcd/workdir)" -xf -
	@if [ \! -e "$(bootcd/workdir)/isolinux.cfg" ]; then \
		ptxd_bailout "no isolinux.cfg found - please ensure you have one in your $(PTXCONF_IMAGE_ISO_ADDON_DIR) directory."; \
	fi
	@genisoimage \
		-R \
		-V "$(call remove_quotes, $(PTXCONF_PROJECT)$(PTXCONF_PROJECT_VERSION))" \
		-o $(@) \
		-b $(notdir $(<)) \
		-c boot.cat \
		-no-emul-boot \
		-boot-load-size 4 \
		-boot-info-table \
		"$(bootcd/workdir)" > /dev/null
	@rm -rf "$(bootcd/workdir)"
