# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de> and
# Jan Luebbe <j.luebbe@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

SEL_ROOTFS-$(PTXCONF_IMAGE_BOOT_MLO_VFAT) += $(IMAGEDIR)/boot-mlo.vfat

ifdef PTXCONF_IMAGE_BOOT_MLO_VFAT
$(IMAGEDIR)/boot-mlo.vfat.map:
	@echo "$(IMAGEDIR)/MLO:MLO"				>  "$@"
ifdef PTXCONF_U_BOOT
	@echo "$(IMAGEDIR)/u-boot.img:u-boot.img"		>> "$@"
endif
ifdef PTXCONF_BAREBOX
	@echo "$(IMAGEDIR)/barebox-image:barebox.bin"		>> "$@"
endif
	@echo "$(IMAGEDIR)/linuximage:$(PTXCONF_KERNEL_IMAGE)"	>> "$@"

# 10MiB
boot-mlo_VFAT_SIZE := 10485760

$(IMAGEDIR)/boot-mlo.vfat: $(IMAGEDIR)/MLO $(IMAGEDIR)/linuximage
ifdef PTXCONF_U_BOOT
$(IMAGEDIR)/boot-mlo.vfat: $(IMAGEDIR)/u-boot.img
endif
ifdef PTXCONF_BAREBOX
$(IMAGEDIR)/boot-mlo.vfat: $(IMAGEDIR)/barebox-image
endif
endif

# vim: syntax=make
