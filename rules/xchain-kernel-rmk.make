# -*-makefile-*-
# $Id: xchain-kernel-rmk.make,v 1.3 2003/10/28 11:12:24 mkl Exp $
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

xchain-kernel-rmk_get: $(STATEDIR)/xchain-kernel-rmk.get

xchain-kernel-rmk_get_deps = \
	$(STATEDIR)/kernel-rmk.get

$(STATEDIR)/xchain-kernel-rmk.get: $(xchain-kernel-rmk_get_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-kernel-rmk_install: $(STATEDIR)/xchain-kernel-rmk.install

$(STATEDIR)/xchain-kernel-rmk.install: $(STATEDIR)/xchain-kernel-rmk.get
	@$(call targetinfo, $@)
	@$(call patch_apply, $(KERNEL_RMK_SOURCE), $(XCHAIN_KERNEL_BUILDDIR))
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-kernel-rmk_clean:
	rm -rf $(STATEDIR)/xchain-kernel*

# vim: syntax=make
