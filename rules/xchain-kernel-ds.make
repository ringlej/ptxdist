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

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-kernel-ds_get: $(STATEDIR)/xchain-kernel-ds.get

xchain-kernel-ds_get_deps = \
	$(STATEDIR)/kernel-ds.get

$(STATEDIR)/xchain-kernel-ds.get: $(xchain-kernel-ds_get_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-kernel-ds_install: $(STATEDIR)/xchain-kernel-ds.install

$(STATEDIR)/xchain-kernel-ds.install: $(STATEDIR)/xchain-kernel-ds.get
	@$(call targetinfo, $@)
	@$(call patch_apply, $(KERNEL_DS_SOURCE), $(XCHAIN_KERNEL_BUILDDIR))
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-kernel-ds_clean:
	rm -rf $(STATEDIR)/xchain-kernel*

# vim: syntax=make
