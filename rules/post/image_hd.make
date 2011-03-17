# -*-makefile-*-
#
# Copyright (C) 2003-2010 by the ptxdist project <ptxdist@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

SEL_ROOTFS-$(PTXCONF_IMAGE_HD)		+= $(IMAGEDIR)/hd.img

ifdef PTXCONF_IMAGE_HD_PART1
$(IMAGEDIR)/hd.img: $(call remove_quotes,$(PTXCONF_IMAGE_HD_PART1_CONTENT))
GENHDIMARGS = -p $(PTXCONF_IMAGE_HD_PART1_START):$(PTXCONF_IMAGE_HD_PART1_END):$(PTXCONF_IMAGE_HD_PART1_TYPE):$(PTXCONF_IMAGE_HD_PART1_CONTENT)
endif
ifdef PTXCONF_IMAGE_HD_PART2
$(IMAGEDIR)/hd.img: $(call remove_quotes,$(PTXCONF_IMAGE_HD_PART2_CONTENT))
GENHDIMARGS += -p $(PTXCONF_IMAGE_HD_PART2_START):$(PTXCONF_IMAGE_HD_PART2_END):$(PTXCONF_IMAGE_HD_PART2_TYPE):$(PTXCONF_IMAGE_HD_PART2_CONTENT)
endif
ifdef PTXCONF_IMAGE_HD_PART3
$(IMAGEDIR)/hd.img: $(call remove_quotes,$(PTXCONF_IMAGE_HD_PART3_CONTENT))
GENHDIMARGS += -p $(PTXCONF_IMAGE_HD_PART3_START):$(PTXCONF_IMAGE_HD_PART3_END):$(PTXCONF_IMAGE_HD_PART3_TYPE):$(PTXCONF_IMAGE_HD_PART3_CONTENT)
endif
ifdef PTXCONF_IMAGE_HD_PART4
$(IMAGEDIR)/hd.img: $(call remove_quotes,$(PTXCONF_IMAGE_HD_PART4_CONTENT))
GENHDIMARGS += -p $(PTXCONF_IMAGE_HD_PART4_START):$(PTXCONF_IMAGE_HD_PART4_END):$(PTXCONF_IMAGE_HD_PART4_TYPE):$(PTXCONF_IMAGE_HD_PART4_CONTENT)
endif

$(IMAGEDIR)/hd.img:
	@echo "Creating hdimg from root.ext2";					\
	PATH=$(PTXCONF_SYSROOT_HOST)/bin:$$PATH $(PTXDIST_TOPDIR)/scripts/genhdimg	\
	-o $@ $(GENHDIMARGS)
	@$(call ptx/env) \
		ptxd_make_bootable $@ $(PTXCONF_IMAGE_HD_PART1_START)
	@echo "done."

# vim: syntax=make
