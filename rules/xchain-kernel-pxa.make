# -*-makefile-*-
# $Id: xchain-kernel-pxa.make,v 1.3 2003/10/28 11:12:24 mkl Exp $
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

xchain-kernel-pxa_get: $(STATEDIR)/xchain-kernel-pxa.get

xchain-kernel-pxa_get_deps = \
	$(STATEDIR)/kernel-pxa.get

$(STATEDIR)/xchain-kernel-pxa.get: $(xchain-kernel-pxa_get_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-kernel-pxa_install: $(STATEDIR)/xchain-kernel-pxa.install

$(STATEDIR)/xchain-kernel-pxa.install: $(STATEDIR)/xchain-kernel-pxa.get
	@$(call targetinfo, $@)
	@$(call patch_apply, $(KERNEL_PXA_SOURCE), $(XCHAIN_KERNEL_BUILDDIR))
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-kernel-pxa_clean:
	rm -rf $(STATEDIR)/xchain-kernel*

# vim: syntax=make
