# -*-makefile-*-
# $Id$
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
# ifdef PTXCONF_KERNEL_PTX
# KERNEL_PATCHES += kernel-ptx
# endif

#
# Paths and names
#
KERNEL_PTX_VERSION	= $(call get_option, \
	s/^PTXCONF_KERNEL_\([0-9]\)_\([0-9]\)_\([0-9]*\)_\(rmk[0-9]\)_\(pxa[0-9]\)_\(mtd[0-9]*\)_\(ptx[0-9]*\).*/\1.\2.\3-\4-\5-\7/, ptx)
KERNEL_PTX		= linux-$(KERNEL_PTX_VERSION)
KERNEL_PTX_SUFFIX	= diff
KERNEL_PTX_URL		= http://www.pengutronix.de/software/linux-arm/$(KERNEL_PTX).$(KERNEL_PTX_SUFFIX)
KERNEL_PTX_SOURCE	= $(SRCDIR)/$(KERNEL_PTX).$(KERNEL_PTX_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

kernel-ptx_get: $(STATEDIR)/kernel-ptx.get

kernel-ptx_get_deps = \
	$(KERNEL_PTX_SOURCE)

$(STATEDIR)/kernel-ptx.get: $(kernel-ptx_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(KERNEL_PTX_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KERNEL_PTX_URL))

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

kernel-ptx_install: $(STATEDIR)/kernel-ptx.install

$(STATEDIR)/kernel-ptx.install: $(STATEDIR)/kernel-ptx.get
	@$(call targetinfo, $@)
	@$(call patch_apply, $(KERNEL_PTX_SOURCE), $(KERNEL_DIR))
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kernel-ptx_clean:
	rm -rf $(STATEDIR)/kernel*

# vim: syntax=make
