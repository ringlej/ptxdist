# -*-makefile-*-
# $Id: kernel-mtd.make,v 1.2 2003/10/23 15:01:19 mkl Exp $
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef MTDCONF_KERNEL_MTD
PATCHES			+= kernel-mtd
endif

#
# Paths and names
#
KERNEL-MTD_VERSION	= $(call get_option, \
	s/^PTXCONF_KERNEL_\([0-9]\)_\([0-9]\)_\([0-9]*\)_\(rmk[0-9]\)_\(pxa[0-9]\)_\(mtd[0-9]*\).*/\1.\2.\3-\4-\5-\6/, mtd)
KERNEL-MTD		= linux-$(KERNEL-MTD_VERSION)
KERNEL-MTD_SUFFIX	= diff.bz2
KERNEL-MTD_URL		= http://www.pengutronix.de/software/linux-arm/$(KERNEL-MTD).$(KERNEL-MTD_SUFFIX)
KERNEL-MTD_SOURCE	= $(SRCDIR)/linux-$(KERNEL-MTD_VERSION).$(KERNEL-MTD_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

kernel-mtd_get: $(STATEDIR)/kernel-mtd.get

kernel-mtd_get_deps = \
	$(KERNEL-MTD_SOURCE)

$(STATEDIR)/kernel-mtd.get: $(kernel-mtd_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(KERNEL-MTD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KERNEL-MTD_URL))

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

kernel-mtd_install: $(STATEDIR)/kernel-mtd.install

$(STATEDIR)/kernel-mtd.install: $(STATEDIR)/kernel-mtd.get
	@$(call targetinfo, $@)
	@$(call patch_apply, $(KERNEL-MTD_SOURCE), $(KERNEL_DIR))
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kernel-mtd_clean:
	rm -rf $(STATEDIR)/kernel*

# vim: syntax=make
