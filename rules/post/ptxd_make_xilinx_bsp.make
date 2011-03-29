# -*-makefile-*-
#
# Copyright (C) 2011 by Stephan Linz <linz@li-pro.net>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ifdef PTXCONF_ARCH_MICROBLAZE

ifdef PTXCONF_ARCH_MICROBLAZE_HAVE_XLBSP
$(STATEDIR)/u-boot.prepare: $(STATEDIR)/u-boot.xlbsp
endif

ifdef PTXCONF_ARCH_MICROBLAZE_HAVE_XLBSP
$(STATEDIR)/kernel.prepare: $(STATEDIR)/kernel.xlbsp
endif

ifdef PTXCONF_KERNEL_IMAGE_SIMPLE
SEL_ROOTFS-$(PTXCONF_IMAGE_KERNEL) += $(IMAGEDIR)/linuximage.ub
endif

$(IMAGEDIR)/linuximage.ub: $(KERNEL_IMAGE_PATH_y).ub $(IMAGEDIR)/linuximage
	@echo -n "Creating '$(notdir $(@))' from '$(notdir $(<))'..."
	@install -m 644 "$(<)" "$(@)"
	@echo "done."

endif

$(STATEDIR)/%.xlbsp: $(STATEDIR)/%.extract
	@$(call targetinfo)
	@$(call xilinx/bsp, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call touch)

xilinx/bsp = \
	$(call world/env, $(1)) \
	ptxd_make_xilinx_bsp $(1) $(2)

# vim: syntax=make
