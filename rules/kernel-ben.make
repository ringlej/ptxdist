# -*-makefile-*-
# $Id: kernel-ben.make,v 1.3 2003/10/28 11:12:24 mkl Exp $
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
# ifdef PTXCONF_KERNEL_BEN
# KERNEL_PATCHES += kernel-ben
# endif

#
# Paths and names
#
KERNEL_BEN_VERSION	= $(call get_option, s/^PTXCONF_KERNEL_\([0-9]\)_\([0-9]\)_\([0-9]*\)_\(ben[0-9]\).*/\1.\2.\3-\4/, benh)
KERNEL_BEN		= patch-$(KERNEL_BEN_VERSION)
KERNEL_BEN_SUFFIX	= bz2
KERNEL_BEN_URL		= http://www.kernel.org/pub/linux/kernel/people/benh/$(KERNEL_BEN).$(KERNEL_BEN_SUFFIX)
KERNEL_BEN_SOURCE	= $(SRCDIR)/$(KERNEL_BEN).$(KERNEL_BEN_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

kernel-ben_get: $(STATEDIR)/kernel-ben.get

kernel-ben_get_deps = \
	$(KERNEL_BEN_SOURCE)

$(STATEDIR)/kernel-ben.get: $(kernel-ben_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(KERNEL_BEN_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KERNEL_BEN_URL))

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

kernel-ben_install: $(STATEDIR)/kernel-ben.install

$(STATEDIR)/kernel-ben.install: $(STATEDIR)/kernel-ben.get
	@$(call targetinfo, $@)
	@$(call patch_apply, $(KERNEL_BEN_SOURCE), $(KERNEL_DIR))
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kernel-ben_clean:
	rm -rf $(STATEDIR)/kernel*

# vim: syntax=make
