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

xchain-kernel-ben_get: $(STATEDIR)/xchain-kernel-ben.get

xchain-kernel-ben_get_deps = \
	$(STATEDIR)/kernel-ben.get

$(STATEDIR)/xchain-kernel-ben.get: $(xchain-kernel-ben_get_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-kernel-ben_install: $(STATEDIR)/xchain-kernel-ben.install

$(STATEDIR)/xchain-kernel-ben.install: $(STATEDIR)/xchain-kernel-ben.get
	@$(call targetinfo, $@)
	@$(call patch_apply, $(KERNEL_BEN_SOURCE), $(XCHAIN_KERNEL_BUILDDIR))
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-kernel-ben_clean:
	rm -rf $(STATEDIR)/xchain-kernel*

# vim: syntax=make
