# -*-makefile-*-
# $Id: kernel-pxa.make,v 1.2 2003/10/23 15:01:19 mkl Exp $
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
ifdef PTXCONF_KERNEL_PXA
PATCHES			+= kernel-pxa
endif

#
# Paths and names
#
KERNEL-PXA_VERSION	= $(call get_option, \
	s/^PTXCONF_KERNEL_\([0-9]\)_\([0-9]\)_\([0-9]*\)_\(rmk[0-9]\)_\(pxa[0-9]\).*/\1.\2.\3-\4-\5/, pxa)
KERNEL-PXA		= diff-$(KERNEL-PXA_VERSION)
KERNEL-PXA_SUFFIX	= gz
KERNEL-PXA_URL		= ftp://ftp.arm.linux.org.uk/pub/armlinux/people/nico/$(KERNEL-PXA).$(KERNEL-PXA_SUFFIX)
KERNEL-PXA_SOURCE	= $(SRCDIR)/$(KERNEL-PXA).$(KERNEL-PXA_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

kernel-pxa_get: $(STATEDIR)/kernel-pxa.get

kernel-pxa_get_deps = \
	$(KERNEL-PXA_SOURCE)

$(STATEDIR)/kernel-pxa.get: $(kernel-pxa_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(KERNEL-PXA_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KERNEL-PXA_URL))

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

kernel-pxa_install: $(STATEDIR)/kernel-pxa.install

$(STATEDIR)/kernel-pxa.install: $(STATEDIR)/kernel-pxa.get
	@$(call targetinfo, $@)
	@$(call patch_apply, $(KERNEL-PXA_SOURCE), $(KERNEL_DIR))
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kernel-pxa_clean:
	rm -rf $(STATEDIR)/kernel*

# vim: syntax=make
