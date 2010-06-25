# -*-makefile-*-
#
# Copyright (C) 2003-2010 by the ptxdist project <ptxdist@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

SEL_ROOTFS-$(PTXCONF_IMAGE_CPIO) += $(IMAGEDIR)/root.cpio

$(IMAGEDIR)/root.cpio: $(STATEDIR)/image_working_dir
	@echo -n "Creating '$(notdir $(@))' from working dir..."
	@cd $(image/work_dir) && \
	( \
		awk -F: $(DOPERMISSIONS) $(image/permissions) && \
		echo "find . | cpio --quiet -H newc -o > '$(@)'" \
	) | $(FAKEROOT) --
	@echo "done."


SEL_ROOTFS-$(PTXCONF_IMAGE_CPIO_GZ) += $(IMAGEDIR)/root.cpio.gz

$(IMAGEDIR)/root.cpio.gz: $(IMAGEDIR)/root.cpio
	@echo -n "Creating '$(notdir $(@))' from '$(notdir $(^))'..."
	@cat "$(^)" | gzip -n --best > "$(@)"
	@echo "done."

# vim: syntax=make
