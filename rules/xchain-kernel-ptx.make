# -*-makefile-*-
# $Id: xchain-kernel-ptx.make,v 1.3 2003/10/23 18:03:19 mkl Exp $
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

xchain-kernel-ptx_get: $(STATEDIR)/xchain-kernel-ptx.get

xchain-kernel-ptx_get_deps = \
	$(STATEDIR)/kernel-ptx.get

$(STATEDIR)/xchain-kernel-ptx.get: $(xchain-kernel-ptx_get_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-kernel-ptx_install: $(STATEDIR)/xchain-kernel-ptx.install

$(STATEDIR)/xchain-kernel-ptx.install: $(STATEDIR)/xchain-kernel-ptx.get
	@$(call targetinfo, $@)
	@$(call patch_apply, $(KERNEL_PTX_SOURCE), $(XCHAIN_KERNEL_BUILDDIR))
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-kernel-ptx_clean:
	rm -rf $(STATEDIR)/xchain-kernel*

# vim: syntax=make
