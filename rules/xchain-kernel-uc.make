# -*-makefile-*-
# $Id: xchain-kernel-uc.make,v 1.2 2003/10/23 15:01:19 mkl Exp $
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

xchain-kernel-uc_get: $(STATEDIR)/xchain-kernel-uc.get

xchain-kernel-uc_get_deps = \
	$(STATEDIR)/kernel-uc.get

$(STATEDIR)/xchain-kernel-uc.get: $(xchain-kernel-uc_get_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-kernel-uc_install: $(STATEDIR)/xchain-kernel-uc.install

$(STATEDIR)/xchain-kernel-uc.install: $(STATEDIR)/xchain-kernel-uc.get
	@$(call targetinfo, $@)
	@$(call patch_apply, $(KERNEL-UC_SOURCE), $(XCHAIN_KERNEL_BUILDDIR))
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-kernel-uc_clean:
	rm -rf $(STATEDIR)/xchain-kernel*

# vim: syntax=make
