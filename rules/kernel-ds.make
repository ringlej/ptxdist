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
# ifdef PTXCONF_KERNEL_DS
# KERNEL_PATCHES += kernel-ds
# endif

#
# Paths and names
#
KERNEL_DS_VERSION	= $(call get_option, \
	s/^PTXCONF_KERNEL_\([0-9]\)_\([0-9]\)_\([0-9]*\)_\(rmk[0-9]\)_\(ds[0-9]\).*/\1.\2.\3-\4-\5/, ds)
KERNEL_DS		= patch-$(KERNEL_DS_VERSION)
KERNEL_DS_SUFFIX	= gz
KERNEL_DS_URL		= ftp://source.mvista.com/pub/ds-patches/$(KERNEL_VERSION_MAJOR).$(KERNEL_VERSION_MINOR)/$(KERNEL_DS).$(KERNEL_DS_SUFFIX)
KERNEL_DS_SOURCE	= $(SRCDIR)/$(KERNEL_DS).$(KERNEL_DS_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

kernel-ds_get: $(STATEDIR)/kernel-ds.get

kernel-ds_get_deps = \
	$(KERNEL_DS_SOURCE)

$(STATEDIR)/kernel-ds.get: $(kernel-ds_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(KERNEL_DS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KERNEL_DS_URL))

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

kernel-ds_install: $(STATEDIR)/kernel-ds.install

$(STATEDIR)/kernel-ds.install: $(STATEDIR)/kernel-ds.get
	@$(call targetinfo, $@)
	@$(call patch_apply, $(KERNEL_DS_SOURCE), $(KERNEL_DIR))
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kernel-ds_clean:
	rm -rf $(STATEDIR)/kernel-ds.*

# vim: syntax=make
