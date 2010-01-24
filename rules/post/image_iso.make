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

image_iso/workdir := $(IMAGEDIR)/bootcd-workdir

$(IMAGEDIR)/bootcd.iso: $(PTXDIST_SYSROOT_TARGET)/usr/share/syslinux/isolinux.bin $(IMAGEDIR)/initrd.gz $(IMAGEDIR)/linuximage
	@echo -n "generating $(notdor $(@)) from initrd.gz..."
	@rm -rf "$(image_iso/workdir)"
	@mkdir -p "$(image_iso/workdir)"
	@cp "$(^)" "$(image_iso/workdir)"
	@mv "$(image_iso/workdir)/linuximage" "$(image_iso/workdir)/kernel"
	@tar -C $(PTXCONF_IMAGE_ISO_ADDON_DIR) -cf - \
		--exclude .git \
		--exclude .pc \
		--exclude .svn \
		--exclude *~ \
		. | \
		tar -o -C "$(image_iso/workdir)" -xf -
	@if [ \! -e "$(image_iso/workdir)/isolinux.cfg" ]; then \
		ptxd_bailout "no isolinux.cfg found - please ensure you have one in your $(PTXCONF_IMAGE_ISO_ADDON_DIR) directory."; \
	fi
	@genisoimage \
		-R \
		-V "$(call remove_quotes, $(PTXCONF_PROJECT)$(PTXCONF_PROJECT_VERSION))" \
		-o $(@) \
		-b "$(notdir $(<))" \
		-c boot.cat \
		-no-emul-boot \
		-boot-load-size 4 \
		-boot-info-table \
		"$(image_iso/workdir)" >/dev/null 2>&1
	@rm -rf "$(image_iso/workdir)"
	@echo "done"

# vim: syntax=make
