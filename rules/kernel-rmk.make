# -*-makefile-*-
# $Id: kernel-rmk.make,v 1.3 2003/10/28 11:12:24 mkl Exp $
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
# ifdef PTXCONF_KERNEL_RMK
# KERNEL_PATCHES += kernel-rmk
# endif

#
# Paths and names
#
KERNEL_RMK_VERSION	= $(call get_option, \
	s/^PTXCONF_KERNEL_\([0-9]\)_\([0-9]\)_\([0-9]*\)_\(rmk[0-9]\).*/\1.\2.\3-\4/, rmk)
KERNEL_RMK		= patch-$(KERNEL_RMK_VERSION)
KERNEL_RMK_SUFFIX	= bz2
KERNEL_RMK_URL		= ftp://ftp.arm.linux.org.uk/pub/armlinux/source/kernel-patches/v$(KERNEL_VERSION_MAJOR).$(KERNEL_VERSION_MINOR)/$(KERNEL_RMK).$(KERNEL_RMK_SUFFIX)
KERNEL_RMK_SOURCE	= $(SRCDIR)/$(KERNEL_RMK).$(KERNEL_RMK_SUFFIX)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

kernel-rmk_get: $(STATEDIR)/kernel-rmk.get

kernel-rmk_get_deps = \
	$(KERNEL_RMK_SOURCE)

$(STATEDIR)/kernel-rmk.get: $(kernel-rmk_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(KERNEL_RMK_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KERNEL_RMK_URL))

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

kernel-rmk_install: $(STATEDIR)/kernel-rmk.install

$(STATEDIR)/kernel-rmk.install: $(STATEDIR)/kernel-rmk.get
	@$(call targetinfo, $@)
	@$(call patch_apply, $(KERNEL_RMK_SOURCE), $(KERNEL_DIR))
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kernel-rmk_clean:
	rm -rf $(STATEDIR)/kernel*

# vim: syntax=make
