# -*-makefile-*-
# $Id: kernel-ben.make,v 1.2 2003/10/23 15:01:19 mkl Exp $
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
ifdef PTXCONF_KERNEL_BEN
PATCHES			+= kernel-ben
endif

#
# Paths and names
#
KERNEL-BEN_VERSION	= $(call get_option, s/^PTXCONF_KERNEL_\([0-9]\)_\([0-9]\)_\([0-9]*\)_\(ben[0-9]\).*/\1.\2.\3-\4/, benh)
KERNEL-BEN		= patch-$(KERNEL-BEN_VERSION)
KERNEL-BEN_SUFFIX	= bz2
KERNEL-BEN_URL		= http://www.kernel.org/pub/linux/kernel/people/benh/$(KERNEL-BEN).$(KERNEL-BEN_SUFFIX)
KERNEL-BEN_SOURCE	= $(SRCDIR)/$(KERNEL-BEN).$(KERNEL-BEN_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

kernel-ben_get: $(STATEDIR)/kernel-ben.get

kernel-ben_get_deps = \
	$(KERNEL-BEN_SOURCE)

$(STATEDIR)/kernel-ben.get: $(kernel-ben_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(KERNEL-BEN_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KERNEL-BEN_URL))

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

kernel-ben_install: $(STATEDIR)/kernel-ben.install

$(STATEDIR)/kernel-ben.install: $(STATEDIR)/kernel-ben.get
	@$(call targetinfo, $@)
	@$(call patch_apply, $(KERNEL-BEN_SOURCE), $(KERNEL_DIR))
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kernel-ben_clean:
	rm -rf $(STATEDIR)/kernel*

# vim: syntax=make
