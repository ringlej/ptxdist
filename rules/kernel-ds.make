# -*-makefile-*-
# $Id: kernel-ds.make,v 1.2 2003/10/23 15:01:19 mkl Exp $
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
ifdef PTXCONF_KERNEL_DS
PATCHES			+= kernel-ds
endif

#
# Paths and names
#
KERNEL-DS_VERSION	= $(call get_config, \
	s/^PTXCONF_KERNEL_\([0-9]\)_\([0-9]\)_\([0-9]*\)_\(rmk[0-9]\)_\(ds[0-9]\).*/\1.\2.\3-\4-\5/, ds)
KERNEL-DS		= patch-$(KERNEL-DS_VERSION)
KERNEL-DS_SUFFIX	= gz
KERNEL-DS_URL		= ftp://source.mvista.com/pub/ds-patches/$(KERNEL_VERSION_MAJOR).$(KERNEL_VERSION_MINOR)/$(KERNEL-DS).$(KERNEL-DS_SUFFIX)
KERNEL-DS_SOURCE	= $(SRCDIR)/$(KERNEL-DS).$(KERNEL-DS_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

kernel-ds_get: $(STATEDIR)/kernel-ds.get

kernel-ds_get_deps = \
	$(KERNEL-DS_SOURCE)

$(STATEDIR)/kernel-ds.get: $(kernel-ds_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(KERNEL-DS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KERNEL-DS_URL))

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

kernel-ds_install: $(STATEDIR)/kernel-ds.install

$(STATEDIR)/kernel-ds.install: $(STATEDIR)/kernel-ds.get
	@$(call targetinfo, $@)
	@$(call patch_apply, $(KERNEL-DS_SOURCE), $(KERNEL_DIR))
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kernel-ds_clean:
	rm -rf $(STATEDIR)/kernel-ds.*

# vim: syntax=make
